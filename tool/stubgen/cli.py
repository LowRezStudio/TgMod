"""Command-line entry point.

Run from the repo root:

    python3 -m tool.stubgen parse exported/TgGame/Classes/TgProj_Simulated.uc
    python3 -m tool.stubgen scan [--root exported] [--only TgGame] [--limit 200]
    python3 -m tool.stubgen dumptree --out /tmp/uc-model [--root exported]
    python3 -m tool.stubgen stub [--file ...] [--root exported] [--all]

Dry-run only: nothing is ever written into Development/Src/.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import sys
from collections import deque
from dataclasses import asdict
from typing import Dict, List, Tuple, Optional

from .model import (
    ClassDecl,
    ConstDecl,
    EnumDecl,
    FunctionDecl,
    ReplicationBlock,
    StateDecl,
    StructDecl,
    VarGroup,
    ParseError,
)
from .parser import Parser, UcParseError
from .render import render_class
from .render_stub import emit_stub, _var_decl_names

DEFAULT_ROOT = os.path.join("exported")

# Stock packages that are already in another config file (UDK's DefaultEngineUDK.ini)
# These are standard UDK packages, NOT the mod's packages
STOCK_PACKAGES = {
    "Core", "Engine", "GameFramework", "GFxUI", "GFxUIEditor", "IpDrv",
    "OnlineSubsystemSteamworks", "OnlineSubsystemPC",
    "OnlineSubsystemGameCenter", "SubstanceAir", "SubstanceAirEd",
    "UDKBase", "UTEditor", "UnrealEd", "WinDrv",
}

# Path (relative to the stubgen package dir) of the stock UDK native var-layout
# index. Generated once from a pristine UDK source tree by `stubgen stock-index`;
# used to emit native engine classes with a layout that links against the stock
# native binary.
STOCK_VAR_INDEX_PATH = os.path.join(os.path.dirname(__file__), "stock_var_index.json")

_stock_var_index_cache = None


def load_stock_var_index(path: Optional[str] = None) -> Dict[str, dict]:
    """Load the stock native layout index (class key -> {"vars": [...], "types": [...]}).

    Cache after first load; returns {} if the file is missing (native classes
    are then emitted non-native, which still compiles but loses native layout).
    """
    global _stock_var_index_cache
    if _stock_var_index_cache is not None:
        return _stock_var_index_cache
    p = path or STOCK_VAR_INDEX_PATH
    try:
        with open(p, "r", encoding="utf-8") as fh:
            raw = json.load(fh)
    except (OSError, json.JSONDecodeError):
        _stock_var_index_cache = {}
        return _stock_var_index_cache
    _stock_var_index_cache = {}
    for k, v in raw.items():
        if isinstance(v, dict) and "vars" in v:
            _stock_var_index_cache[k] = {
                "vars": [tuple(x) for x in v["vars"]],
                "types": [tuple(x) for x in v.get("types", [])],
            }
        else:
            # Backward compatible: old format was just [[decl, name], ...]
            _stock_var_index_cache[k] = {
                "vars": [tuple(x) for x in v],
                "types": [],
            }
    return _stock_var_index_cache


def iter_uc_files(root: str):
    for pkg in sorted(os.listdir(root)):
        pkg_dir = os.path.join(root, pkg)
        if not os.path.isdir(pkg_dir):
            continue
        classes_dir = os.path.join(pkg_dir, "Classes")
        if not os.path.isdir(classes_dir):
            continue
        for fn in sorted(os.listdir(classes_dir)):
            if fn.endswith(".uc"):
                yield pkg, os.path.join(classes_dir, fn)


def compute_dependson(class_map: Dict[str, ClassDecl], package: str) -> Dict[str, List[str]]:
    """Compute dependson targets for each class in a package.

    For each class, find nested type references (structs/enums) that are declared
    in other classes in the same package, excluding the class itself and its parent.

    Returns a dict mapping class name -> list of dependson targets (class names).
    """
    # Build map of nested type -> declaring class (for this package only)
    nested_type_to_class: Dict[str, str] = {}
    for class_name, c in class_map.items():
        for nested in c.declared_nested_types:
            # Key can be bare name or ClassName.NestedName
            nested_type_to_class[nested] = class_name
            nested_type_to_class[f"{class_name}.{nested}"] = class_name

    dependson_map: Dict[str, List[str]] = {}

    for class_name, c in class_map.items():
        targets = set()
        parent_class = c.extends.split(".")[-1] if c.extends else None

        for ref in c.referenced_types:
            # Check bare reference
            if ref in nested_type_to_class:
                declaring_class = nested_type_to_class[ref]
                if declaring_class != class_name and declaring_class != parent_class:
                    targets.add(declaring_class)
            # Check dotted reference (ClassName.NestedType)
            elif "." in ref:
                parts = ref.split(".")
                if len(parts) == 2:
                    outer, inner = parts
                    if outer in class_map and inner in class_map[outer].declared_nested_types:
                        if outer != class_name and outer != parent_class:
                            targets.add(outer)

        if targets:
            dependson_map[class_name] = sorted(targets)

    return dependson_map


def parse_file(path: str, package: str = "") -> ClassDecl:
    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        src = fh.read()
    try:
        return Parser(src, package=package, filename=os.path.basename(path)).parse()
    except UcParseError as e:
        # Only the header failed; synthesize a minimal model so reporting works.
        return ClassDecl(
            package=package, filename=os.path.basename(path), kind="?", name="?",
            extends=None, within=None, modifiers=[], header_line=e.line,
            header_text="", members=[], defaultproperties=None,
            errors=[ParseError(line=e.line, message=e.msg)],
        )


class Counts:
    def __init__(self):
        self.files = 0
        self.classes = 0
        self.interfaces = 0
        self.functions = 0
        self.events = 0
        self.delegates = 0
        self.vars = 0
        self.enums = 0
        self.structs = 0
        self.consts = 0
        self.states = 0
        self.replication = 0
        self.errors = 0

    def add_model(self, c: ClassDecl):
        self.files += 1
        if c.kind == "interface":
            self.interfaces += 1
        else:
            self.classes += 1
        self.errors += len(c.errors)
        for m in c.members:
            if isinstance(m, FunctionDecl):
                if m.kind == "event":
                    self.events += 1
                elif m.kind == "delegate":
                    self.delegates += 1
                else:
                    self.functions += 1
            elif isinstance(m, VarGroup):
                self.vars += len(m.vars)
            elif isinstance(m, EnumDecl):
                self.enums += 1
            elif isinstance(m, StructDecl):
                self.structs += 1
            elif isinstance(m, ConstDecl):
                self.consts += 1
            elif isinstance(m, ReplicationBlock):
                self.replication += 1
            elif isinstance(m, StateDecl):
                self.states += 1
                for sub in m.members:
                    if isinstance(sub, FunctionDecl):
                        if sub.kind == "event":
                            self.events += 1
                        elif sub.kind == "delegate":
                            self.delegates += 1
                        else:
                            self.functions += 1

    def as_row(self) -> List[object]:
        return [
            self.files, self.classes, self.interfaces, self.functions,
            self.events, self.delegates, self.vars, self.enums, self.structs,
            self.consts, self.states, self.replication, self.errors,
        ]


COLS = ["files", "classes", "ifaces", "funcs", "events", "delegs",
        "vars", "enums", "structs", "consts", "states", "repl", "errors"]


def cmd_parse(args: argparse.Namespace) -> int:
    path = args.file
    pkg = args.package or os.path.basename(os.path.dirname(os.path.dirname(os.path.abspath(path))))
    c = parse_file(path, package=pkg)
    print(render_class(c))
    return 0


def cmd_scan(args: argparse.Namespace) -> int:
    root = args.root
    per_pkg: Dict[str, Counts] = {}
    totals = Counts()
    errored_files: List[Tuple[str, ClassDecl]] = []
    limit = args.limit or 0
    n = 0
    for pkg, path in iter_uc_files(root):
        if args.only and pkg != args.only:
            continue
        c = parse_file(path, package=pkg)
        per_pkg.setdefault(pkg, Counts()).add_model(c)
        totals.add_model(c)
        if c.errors:
            errored_files.append((path, c))
        n += 1
        if limit and n >= limit:
            break

    # table
    rows = [["pkg"] + COLS]
    for pkg in sorted(per_pkg):
        rows.append([pkg] + per_pkg[pkg].as_row())
    rows.append(["TOTAL"] + totals.as_row())
    widths = [max(len(str(r[i])) for r in rows) for i in range(len(COLS) + 1)]
    for r in rows:
        print("  ".join(str(x).rjust(widths[i]) for i, x in enumerate(r)))

    print(f"\nparsed {totals.files} files, {totals.errors} parse errors "
          f"across {len(errored_files)} files")
    if errored_files and args.verbose:
        for path, c in errored_files[:40]:
            print(f"  {path}")
            for e in c.errors[:5]:
                print(f"      L{e.line}: {e.message}")
    return 0 if totals.errors == 0 else 1


def cmd_dumptree(args: argparse.Namespace) -> int:
    root = args.root
    out = args.out
    os.makedirs(out, exist_ok=True)
    total_bytes = 0
    nfiles = 0
    nerrors = 0
    limit = args.limit or 0
    n = 0
    for pkg, path in iter_uc_files(root):
        if args.only and pkg != args.only:
            continue
        c = parse_file(path, package=pkg)
        d = asdict(c)
        pkg_out = os.path.join(out, pkg)
        os.makedirs(pkg_out, exist_ok=True)
        stem = os.path.basename(path)[:-3]
        out_path = os.path.join(pkg_out, stem + ".json")
        text = json.dumps(d, indent=1, ensure_ascii=False)
        with open(out_path, "w", encoding="utf-8") as fh:
            fh.write(text)
        total_bytes += len(text)
        nfiles += 1
        nerrors += len(c.errors)
        n += 1
        if limit and n >= limit:
            break
    print(f"wrote {nfiles} JSON files to {out} ({total_bytes:,} bytes), "
          f"{nerrors} parse errors")
    return 0


def cmd_report_dependson(args: argparse.Namespace) -> int:
    """Report dependson analysis for classes in a package."""
    root = args.root
    limit = args.limit or 0
    n = 0

    # Build path map by package
    pkg_to_files = {}
    for pkg, path in iter_uc_files(root):
        if args.only and pkg != args.only:
            continue
        pkg_to_files.setdefault(pkg, []).append(path)

    for pkg in sorted(pkg_to_files.keys()):
        if limit and n >= limit:
            break
        # First pass: parse all files in package to build class map
        class_map: Dict[str, ClassDecl] = {}
        for path in pkg_to_files[pkg]:
            c = parse_file(path, package=pkg)
            class_map[c.name] = c
        # Compute dependson for this package
        dependson_map = compute_dependson(class_map, pkg)
        # Report
        if dependson_map:
            print(f"\n=== Package: {pkg} ===")
            for class_name, targets in sorted(dependson_map.items()):
                print(f"  {class_name}: dependson({', '.join(targets)})")
        n += len(pkg_to_files[pkg])

    return 0


def _resolve_output_dir(args: argparse.Namespace, package: str) -> str:
    """Resolve the output directory for a package."""
    if args.out:
        return os.path.join(args.out, package, "Classes")
    # Default: Development/Src/<Package>/Classes/
    return os.path.join("Development", "Src", package, "Classes")


def _order_pkg_files(paths: List[str], class_map: Dict[str, ClassDecl],
                     dependson_map: Dict[str, List[str]]) -> List[str]:
    """Order package files so classes referenced via nested types come first.

    Within a package, a class that references ``Other.Enum`` needs ``Other``
    declared before it. ``dependson`` should handle this, but the compiler
    doesn't reliably order same-package classes, so source order must put
    declarers first (topological sort on the dependson relation).
    """
    from collections import deque
    path_by_class = {}
    for p in paths:
        stem = os.path.basename(p)[:-3]
        path_by_class[stem] = p
    # build dependson edges: class -> classes that depend on it (must come after)
    indegree = {c.name: 0 for c in class_map.values()}
    rev = {c.name: [] for c in class_map.values()}
    for cls, targets in dependson_map.items():
        for t in targets:
            if t in rev:
                rev[t].append(cls)
                indegree[cls] = indegree.get(cls, 0) + 1
    q = deque([c for c, d in indegree.items() if d == 0 and c in path_by_class])
    order = []
    while q:
        c = q.popleft()
        order.append(c)
        for dep in rev.get(c, []):
            indegree[dep] -= 1
            if indegree[dep] == 0 and dep in path_by_class:
                q.append(dep)
    # append any remaining (cycles / not in map), keep original relative order
    for p in paths:
        stem = os.path.basename(p)[:-3]
        if stem not in order:
            order.append(stem)
    return [path_by_class[c] for c in order if c in path_by_class]


def _prepare_output_dir(args: argparse.Namespace, package: str) -> str:
    """Resolve output dir and optionally replace it (delete + recreate)."""
    out_dir = _resolve_output_dir(args, package)
    if args.replace:
        import shutil
        if os.path.exists(out_dir):
            print(f"  replacing {out_dir}")
            shutil.rmtree(out_dir)
    return out_dir


def _compute_package_order(root: str, include_stock: bool = False) -> List[str]:
    """Compute topological order of packages based on extends dependencies."""
    packages = [d for d in sorted(os.listdir(root))
                if os.path.isdir(os.path.join(root, d)) and (include_stock or d not in STOCK_PACKAGES)]

    # Map class names to packages
    class_to_pkg = {}
    for pkg in packages:
        classes_dir = os.path.join(root, pkg, "Classes")
        if os.path.isdir(classes_dir):
            for f in os.listdir(classes_dir):
                if f.endswith(".uc"):
                    class_to_pkg[f[:-3]] = pkg

    # Build dependency graph
    pkg_deps = {pkg: set() for pkg in packages}
    for pkg in packages:
        classes_dir = os.path.join(root, pkg, "Classes")
        if not os.path.isdir(classes_dir):
            continue
        for f in os.listdir(classes_dir):
            if not f.endswith(".uc"):
                continue
            with open(os.path.join(classes_dir, f), "r", encoding="utf-8", errors="replace") as fp:
                content = fp.read()
            for match in re.finditer(r"class\s+\w+\s+extends\s+([\w.]+)", content):
                base = match.group(1)
                base_pkg = base.split(".")[0]
                if base_pkg in class_to_pkg:
                    dep_pkg = class_to_pkg[base_pkg]
                    if dep_pkg != pkg and dep_pkg not in STOCK_PACKAGES:
                        pkg_deps[pkg].add(dep_pkg)

    # Kahn's algorithm for topological sort
    indegree = {pkg: 0 for pkg in packages}
    for pkg, deps in pkg_deps.items():
        indegree[pkg] = len(deps)

    rev_adj = {pkg: [] for pkg in packages}
    for pkg, deps in pkg_deps.items():
        for dep in deps:
            if dep in rev_adj:
                rev_adj[dep].append(pkg)

    queue = deque([pkg for pkg, deg in indegree.items() if deg == 0])
    result = []
    while queue:
        pkg = queue.popleft()
        result.append(pkg)
        for dependent in rev_adj.get(pkg, []):
            indegree[dependent] -= 1
            if indegree[dependent] == 0:
                queue.append(dependent)

    # Add any remaining (cycles)
    for pkg in packages:
        if pkg not in result:
            result.append(pkg)

    return result


def _write_editpackages_ini(order: List[str], out_path: str) -> None:
    """Write +EditPackages= lines to a config file, preserving existing sections."""
    os.makedirs(os.path.dirname(out_path), exist_ok=True)

    # Read existing content to preserve pre-section lines and all sections except [UnrealEd.EditorEngine]
    pre_section_lines = []
    existing_sections = {}
    if os.path.exists(out_path):
        with open(out_path, "r", encoding="utf-8", errors="replace") as fh:
            content = fh.read()

        # Parse sections
        current_section = None
        section_lines = []
        for line in content.split("\n"):
            stripped = line.strip()
            if stripped.startswith("[") and stripped.endswith("]"):
                if current_section is not None:
                    existing_sections[current_section] = "\n".join(section_lines)
                elif section_lines:
                    # Lines before first section header
                    pre_section_lines = list(section_lines)
                current_section = stripped
                section_lines = []
            else:
                section_lines.append(line)
        if current_section is not None:
            existing_sections[current_section] = "\n".join(section_lines)
        elif section_lines and not pre_section_lines:
            pre_section_lines = list(section_lines)

    # Build new content
    lines = []

    # Preserve lines before first section header (e.g., BasedOn=...)
    if pre_section_lines:
        lines.extend(pre_section_lines)
        lines.append("")

    # Preserve [Configuration] section if it exists
    if "[Configuration]" in existing_sections:
        lines.append("[Configuration]")
        lines.append(existing_sections["[Configuration]"].strip())
        lines.append("")

    # Preserve any other sections except [UnrealEd.EditorEngine] which we regenerate
    for section_name, section_content in existing_sections.items():
        if section_name not in ("[Configuration]", "[UnrealEd.EditorEngine]"):
            lines.append(section_name)
            lines.append(section_content.strip())
            lines.append("")

    # Write [UnrealEd.EditorEngine] with EditPackages
    lines.append("[UnrealEd.EditorEngine]")
    for pkg in order:
        lines.append(f"+EditPackages={pkg}")

    with open(out_path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")
    print(f"wrote {out_path}")


def _write_stub_file(c: ClassDecl, out_dir: str, dry_run: bool, dependson: Optional[List[str]] = None, all_classes: Optional[dict] = None, stock_index: Optional[Dict] = None) -> None:
    """Write a single stub file."""
    # Skip placeholder None classes (UE Explorer artifacts)
    if c.name == "None":
        return
    os.makedirs(out_dir, exist_ok=True)
    stem = c.filename[:-3] if c.filename.endswith(".uc") else c.filename
    out_path = os.path.join(out_dir, stem + ".uc")
    # If this class has a stock native counterpart, pass its layout info so the
    # emitter reorders vars and adds stock types to link against the stock
    # native binary.
    stock_vars = None
    stock_types = None
    if stock_index:
        entry = stock_index.get(f"{c.package}.{c.name}")
        if entry is not None:
            stock_vars = entry.get("vars")
            stock_types = entry.get("types")
    stub_src = emit_stub(c, dependson, all_classes, stock_vars=stock_vars, stock_types=stock_types)
    if not stub_src:
        return
    if dry_run:
        print(f"DRY RUN: would write {out_path} ({len(stub_src)} bytes)")
        print("---")
        print(stub_src)
        print("---")
    else:
        with open(out_path, "w", encoding="utf-8") as fh:
            fh.write(stub_src)
        print(f"wrote {out_path}")


def cmd_stock_index(args: argparse.Namespace) -> int:
    """Build the stock native var-layout index from a pristine UDK source tree.

    Scans ``--root`` (default ``Development/Src``) for classes that overlap the
    exported game packages and records each class's var declarations in order.
    The result is written to ``--out`` (default the committed stock_var_index.json).
    Run this against a stock UDK tree before generating stubs.
    """
    import re
    root = args.root
    out_path = args.out or STOCK_VAR_INDEX_PATH

    def stock_var_decls(src: str):
        # Track brace depth so we only capture class-level (top-level) vars,
        # not vars nested inside struct/function/state bodies.
        src = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
        src = re.sub(r'//[^\n]*', '', src)
        out = []
        depth = 0
        for m in re.finditer(r'\bvar\b[^;]*;|\{|\}', src):
            tok = m.group(0)
            if tok == '{':
                depth += 1
            elif tok == '}':
                depth = max(0, depth - 1)
            elif depth == 0:
                decl = re.sub(r'[ \t]+', ' ', tok).strip()
                # Extract every declared name (var ENetRole RemoteRole, Role; ->
                # both RemoteRole and Role), each preserving its own [dim]/init.
                names = _var_decl_names(decl)
                for name in names:
                    out.append((decl, name))
        return out

    def stock_type_decls(src: str):
        """Extract top-level enum/struct declarations (raw text, incl. braces)."""
        src = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
        src = re.sub(r'//[^\n]*', '', src)
        out = []
        depth = 0
        i = 0
        n = len(src)
        while i < n:
            c = src[i]
            if c == '{':
                depth += 1
                i += 1
                continue
            if c == '}':
                depth = max(0, depth - 1)
                i += 1
                continue
            if depth == 0 and (src.startswith('enum', i) or src.startswith('struct', i)):
                m = re.match(r'(enum|struct)\s+', src[i:])
                if m:
                    # Find the body-opening brace. The type NAME is the first
                    # identifier in the header after any modifier keywords (and
                    # after stripping C++-style {TYPE} markers like
                    # `struct {QWORD} qword`). Don't be fooled by `extends`.
                    j = i + m.end()
                    brace = src.find('{', j)
                    if brace != -1:
                        header = src[j:brace]
                        header = re.sub(r'\{[^{}]*\}', ' ', header)  # drop {QWORD} etc
                        STRUCT_MODS = {"native", "transient", "atomic", "immutable",
                                       "noexport", "export", "atomicwhencooked",
                                       "immutablewhencooked", "databinding", "const"}
                        name = None
                        for tok in re.findall(r'[A-Za-z_]\w*', header):
                            if tok not in STRUCT_MODS:
                                name = tok
                                break
                        # find matching close + trailing ';'
                        d2 = 0
                        k = brace
                        while k < n:
                            if src[k] == '{': d2 += 1
                            elif src[k] == '}':
                                d2 -= 1
                                if d2 == 0:
                                    end = k + 1
                                    # Stock may write `} Name;` (inline enum in a
                                    # var decl). Capture up to the closing `}` and
                                    # ensure a trailing `;`.
                                    while end < n and (src[end] == ';' or src[end].isspace()):
                                        if src[end] == ';':
                                            end += 1
                                            break
                                        end += 1
                                    block = src[i:end].rstrip()
                                    if not block.endswith(';'):
                                        block += ';'
                                    if name:
                                        out.append((m.group(1), name, block))
                                    i = end
                                    break
                            k += 1
                        continue
            i += 1
        return out

    index: Dict[str, list] = {}
    # Only packages we stub from exported/
    exported_pkgs = {p for p, _ in iter_uc_files('exported')}
    for pkg in sorted(exported_pkgs):
        d = os.path.join(root, pkg, "Classes")
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith(".uc"):
                continue
            src = open(os.path.join(d, fn), encoding="utf-8", errors="replace").read()
            decls = stock_var_decls(src)
            types = stock_type_decls(src)
            # Include every overlapping class (even with no vars) so its stub is
            # emitted native (needed for native subclasses to extend it).
            index[f"{pkg}.{fn[:-3]}"] = {
                "vars": [[d_, n] for d_, n in decls],
                "types": [[k_, n_, t_] for k_, n_, t_ in types],
            }
    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as fh:
        json.dump(index, fh)
    print(f"wrote {len(index)} classes to {out_path}")
    return 0


def cmd_stub(args: argparse.Namespace) -> int:
    """Generate stub .uc files with bodies stripped."""
    dry_run = args.dry_run
    limit = args.limit or 0
    n = 0
    nerrors = 0

    if args.file:
        # Single file mode
        pkg = args.package or os.path.basename(os.path.dirname(os.path.dirname(os.path.abspath(args.file))))
        c = parse_file(args.file, package=pkg)
        nerrors += len(c.errors)
        out_dir = _prepare_output_dir(args, pkg)
        # For single file, we still want to check parent interface
        class_map: Dict[str, ClassDecl] = {c.name: c}
        # Also parse the parent class if it's in the same package
        if c.extends:
            parent_name = c.extends.split(".")[-1]
            parent_path = os.path.join("exported", pkg, "Classes", parent_name + ".uc")
            if os.path.exists(parent_path):
                parent_c = parse_file(parent_path, package=pkg)
                class_map[parent_name] = parent_c
        _write_stub_file(c, out_dir, dry_run, [], class_map, load_stock_var_index())
        n = 1
    else:
        # Directory tree mode
        root = args.root
        # If --all, compute package order first and process in that order
        if args.all:
            # Stock packages (Core, Engine, ...) keep the pristine UDK source
            # verbatim — the game's versions differ from the stock native binary
            # and crash CDO import. Only GAME packages get stubs, and game-only
            # classes are overlaid onto stock packages.
            pkg_order = _compute_package_order(root, include_stock=False)
            # Default to --replace when using --all
            if not args.replace:
                args.replace = True
            # Filter by --only if specified
            if args.only:
                pkg_order = [p for p in pkg_order if p == args.only]

            # Build path map for quick lookup
            pkg_to_files = {}
            for pkg, path in iter_uc_files(root):
                pkg_to_files.setdefault(pkg, []).append(path)

            stock_index = load_stock_var_index()
            stock_pkg_dirs = {p for p in STOCK_PACKAGES
                              if os.path.isdir(os.path.join("Development", "Src", p))}

            for pkg in pkg_order:
                if pkg not in pkg_to_files:
                    continue
                # Only generate a stub package if it's NOT a stock package (or
                # the stock source dir is absent). For stock packages we only
                # overlay game-only class files.
                if pkg in stock_pkg_dirs:
                    out_dir = _resolve_output_dir(args, pkg)
                else:
                    out_dir = _prepare_output_dir(args, pkg)
                # First pass: parse all files in package to build class map
                class_map: Dict[str, ClassDecl] = {}
                for path in pkg_to_files[pkg]:
                    c = parse_file(path, package=pkg)
                    class_map[c.name] = c
                # Compute dependson for this package
                dependson_map = compute_dependson(class_map, pkg)
                # Order files so nested-type declarers come before referencers.
                # The compiler's `dependson` doesn't reliably order same-package
                # classes, so source order must put declarers first.
                pkg_files = _order_pkg_files(pkg_to_files[pkg], class_map, dependson_map)
                # Second pass: write stubs with dependson
                for path in pkg_files:
                    if limit and n >= limit:
                        break
                    c = parse_file(path, package=pkg)
                    nerrors += len(c.errors)
                    dependson = dependson_map.get(c.name, [])
                    _write_stub_file(c, out_dir, dry_run, dependson, class_map, stock_index)
                    n += 1
                if limit and n >= limit:
                    break

            # Overlay game-only classes onto stock packages (e.g. AkEvent into
            # Engine) so game stubs that reference them compile.
            for pkg in sorted(STOCK_PACKAGES):
                if pkg not in pkg_to_files:
                    continue
                if not os.path.isdir(os.path.join("Development", "Src", pkg, "Classes")):
                    continue
                out_dir = _resolve_output_dir(args, pkg)
                stock_class_names = set()
                for fn in os.listdir(os.path.join("Development", "Src", pkg, "Classes")):
                    if fn.endswith(".uc"):
                        stock_class_names.add(fn[:-3])
                class_map = {}
                for path in pkg_to_files[pkg]:
                    c = parse_file(path, package=pkg)
                    class_map[c.name] = c
                dependson_map = compute_dependson(class_map, pkg)
                for path in pkg_to_files[pkg]:
                    if limit and n >= limit:
                        break
                    c = parse_file(path, package=pkg)
                    # Only write game-only classes (not already in stock)
                    if c.name in stock_class_names:
                        continue
                    nerrors += len(c.errors)
                    dependson = dependson_map.get(c.name, [])
                    _write_stub_file(c, out_dir, dry_run, dependson, class_map, stock_index)
                    n += 1
                if limit and n >= limit:
                    break

            # Write EditPackages.ini if not dry-run
            if not dry_run and args.editpackages_out:
                _write_editpackages_ini(pkg_order, args.editpackages_out)
        else:
            # Original order (alphabetical by package)
            # Need to track which packages we've already prepared
            prepared_pkgs = set()
            # Build path map by package
            pkg_to_files = {}
            for pkg, path in iter_uc_files(root):
                if args.only and pkg != args.only:
                    continue
                pkg_to_files.setdefault(pkg, []).append(path)

            for pkg in sorted(pkg_to_files.keys()):
                if limit and n >= limit:
                    break
                out_dir = _prepare_output_dir(args, pkg) if pkg not in prepared_pkgs else _resolve_output_dir(args, pkg)
                if pkg not in prepared_pkgs:
                    prepared_pkgs.add(pkg)
                # First pass: parse all files in package to build class map
                class_map: Dict[str, ClassDecl] = {}
                for path in pkg_to_files[pkg]:
                    c = parse_file(path, package=pkg)
                    class_map[c.name] = c
                # Compute dependson for this package
                dependson_map = compute_dependson(class_map, pkg)
                # Second pass: write stubs with dependson
                for path in pkg_to_files[pkg]:
                    if limit and n >= limit:
                        break
                    c = parse_file(path, package=pkg)
                    nerrors += len(c.errors)
                    dependson = dependson_map.get(c.name, [])
                    _write_stub_file(c, out_dir, dry_run, dependson, class_map, load_stock_var_index())
                    n += 1

    # After --all generation, apply post-generation fixes so the tree compiles
    # against the stock UDK classes (game-added types/signatures reconciled).
    if args.all and not dry_run and not args.only:
        from . import fixers
        fixers.run_all()

    action = "would write" if dry_run else "wrote"
    print(f"{action} {n} stub files, {nerrors} parse errors")
    return 0 if nerrors == 0 else 1


def build_arg_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="tool.stubgen",
        description="UnrealScript parser and stub generator for the exported Paladins source.",
    )
    sub = p.add_subparsers(dest="cmd", required=True)

    pp = sub.add_parser("parse", help="parse one .uc file and print its model tree")
    pp.add_argument("file")
    pp.add_argument("--package", default="")
    pp.set_defaults(func=cmd_parse)

    ps = sub.add_parser("scan", help="parse the whole exported tree and summarize")
    ps.add_argument("--root", default=DEFAULT_ROOT)
    ps.add_argument("--only", default=None, help="restrict to one package dir")
    ps.add_argument("--limit", type=int, default=0, help="stop after N files")
    ps.add_argument("-v", "--verbose", action="store_true", help="print errored files")
    ps.set_defaults(func=cmd_scan)

    pd = sub.add_parser("dumptree", help="dump the parsed model as JSON to a scratch dir")
    pd.add_argument("--root", default=DEFAULT_ROOT)
    pd.add_argument("--out", required=True, help="scratch output directory (never Development/Src/)")
    pd.add_argument("--only", default=None)
    pd.add_argument("--limit", type=int, default=0)
    pd.set_defaults(func=cmd_dumptree)

    pstub = sub.add_parser("stub", help="generate stub .uc files (strip bodies) into Development/Src/")
    pstub.add_argument("--file", default=None, help="single .uc file to process (mutually exclusive with --root/--only)")
    pstub.add_argument("--package", default="", help="package name for single-file mode (default: inferred from path)")
    pstub.add_argument("--root", default=DEFAULT_ROOT, help="exported source root (directory mode)")
    pstub.add_argument("--only", default=None, help="restrict to one package dir (directory mode)")
    pstub.add_argument("--limit", type=int, default=0, help="stop after N files (directory mode)")
    pstub.add_argument("--out", default=None, help="custom output root (default: Development/Src/)")
    pstub.add_argument("--dry-run", action="store_true", help="print what would be written without writing")
    pstub.add_argument("--all", action="store_true", help="process all packages in dependency order and write EditPackages.ini")
    pstub.add_argument("--editpackages-out", default="UDKGame/Config/DefaultEngine.ini", help="path to write EditPackages.ini (default: UDKGame/Config/DefaultEngine.ini)")
    pstub.add_argument("--replace", action="store_true", help="replace (delete+recreate) each package's output directory before writing stubs")
    pstub.set_defaults(func=cmd_stub)

    pidx = sub.add_parser("stock-index", help="build the stock native var-layout index from a UDK source tree")
    pidx.add_argument("--root", default=os.path.join("Development", "Src"),
                      help="path to a pristine stock UDK Development/Src tree")
    pidx.add_argument("--out", default=STOCK_VAR_INDEX_PATH,
                      help="where to write the index JSON (default: committed stock_var_index.json)")
    pidx.set_defaults(func=cmd_stock_index)

    preport = sub.add_parser("report-dependson", help="report dependson analysis for nested types")
    preport.add_argument("--root", default=DEFAULT_ROOT, help="exported source root")
    preport.add_argument("--only", default=None, help="restrict to one package dir")
    preport.add_argument("--limit", type=int, default=0, help="stop after N files")
    preport.set_defaults(func=cmd_report_dependson)

    return p


def main(argv: List[str] | None = None) -> int:
    args = build_arg_parser().parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
