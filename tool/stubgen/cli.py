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
from typing import Dict, List, Tuple

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
from .render_stub import emit_stub

DEFAULT_ROOT = os.path.join("exported")

# Stock packages that are already in another config file (UDK's DefaultEngineUDK.ini)
# These are standard UDK packages, NOT the mod's packages
STOCK_PACKAGES = {
    "Core", "Engine", "GameFramework", "GFxUI", "GFxUIEditor", "IpDrv",
    "OnlineSubsystemSteamworks", "OnlineSubsystemPC",
    "OnlineSubsystemGameCenter", "SubstanceAir", "SubstanceAirEd",
    "UDKBase", "UTEditor", "UnrealEd", "WinDrv",
}


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


def _resolve_output_dir(args: argparse.Namespace, package: str) -> str:
    """Resolve the output directory for a package."""
    if args.out:
        return os.path.join(args.out, package, "Classes")
    # Default: Development/Src/<Package>/Classes/
    return os.path.join("Development", "Src", package, "Classes")


def _prepare_output_dir(args: argparse.Namespace, package: str) -> str:
    """Resolve output dir and optionally replace it (delete + recreate)."""
    out_dir = _resolve_output_dir(args, package)
    if args.replace:
        import shutil
        if os.path.exists(out_dir):
            print(f"  replacing {out_dir}")
            shutil.rmtree(out_dir)
    return out_dir


def _compute_package_order(root: str) -> List[str]:
    """Compute topological order of non-stock packages based on extends dependencies."""
    packages = [d for d in sorted(os.listdir(root))
                if os.path.isdir(os.path.join(root, d)) and d not in STOCK_PACKAGES]

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
    """Write +EditPackages= lines to a config file."""
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    lines = ["[UnrealEd.EditorEngine]"]
    for pkg in order:
        lines.append(f"+EditPackages={pkg}")
    with open(out_path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines) + "\n")
    print(f"wrote {out_path}")


def _write_stub_file(c: ClassDecl, out_dir: str, dry_run: bool) -> None:
    """Write a single stub file."""
    os.makedirs(out_dir, exist_ok=True)
    stem = c.filename[:-3] if c.filename.endswith(".uc") else c.filename
    out_path = os.path.join(out_dir, stem + ".uc")
    stub_src = emit_stub(c)
    if dry_run:
        print(f"DRY RUN: would write {out_path} ({len(stub_src)} bytes)")
        print("---")
        print(stub_src)
        print("---")
    else:
        with open(out_path, "w", encoding="utf-8") as fh:
            fh.write(stub_src)
        print(f"wrote {out_path}")


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
        _write_stub_file(c, out_dir, dry_run)
        n = 1
    else:
        # Directory tree mode
        root = args.root
        # If --all, compute package order first and process in that order
        if args.all:
            pkg_order = _compute_package_order(root)
            # Filter by --only if specified
            if args.only:
                pkg_order = [p for p in pkg_order if p == args.only]

            # Build path map for quick lookup
            pkg_to_files = {}
            for pkg, path in iter_uc_files(root):
                pkg_to_files.setdefault(pkg, []).append(path)

            for pkg in pkg_order:
                if pkg not in pkg_to_files:
                    continue
                out_dir = _prepare_output_dir(args, pkg)
                for path in pkg_to_files[pkg]:
                    if limit and n >= limit:
                        break
                    c = parse_file(path, package=pkg)
                    nerrors += len(c.errors)
                    _write_stub_file(c, out_dir, dry_run)
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
            for pkg, path in iter_uc_files(root):
                if args.only and pkg != args.only:
                    continue
                if limit and n >= limit:
                    break
                c = parse_file(path, package=pkg)
                nerrors += len(c.errors)
                if pkg not in prepared_pkgs:
                    out_dir = _prepare_output_dir(args, pkg)
                    prepared_pkgs.add(pkg)
                else:
                    out_dir = _resolve_output_dir(args, pkg)
                _write_stub_file(c, out_dir, dry_run)
                n += 1

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

    return p


def main(argv: List[str] | None = None) -> int:
    args = build_arg_parser().parse_args(argv)
    return args.func(args)


if __name__ == "__main__":
    sys.exit(main())
