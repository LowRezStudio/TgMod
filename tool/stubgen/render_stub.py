"""Stub emitter — re-emits a compilable .uc skeleton from the parsed model.

Strips function/event/delegate/operator bodies to empty braces {}.
Strips defaultproperties to empty braces {}.
Preserves vars, consts, enums, structs, replication, state declarations (with their members stripped).
"""

from __future__ import annotations

from typing import Any, List, Optional

from .model import (
    ClassDecl,
    ConstDecl,
    EnumDecl,
    EnumMember,
    VarGroup,
    FunctionDecl,
    ReplicationBlock,
    StateDecl,
    StructDecl,
    DefaultPropertiesBlock,
    RawStatement,
)


# Class-level modifiers that only make sense on native classes. The game's
# decompiled classes carry them (the game built against its own modified native
# classes), but we compile the stubs against the stock UDK binary whose native
# classes have a different property layout. Emitting them as `native` would make
# the script properties misalign with the binary's native properties and break
# compilation (e.g. Actor's `Role` check). The stubs are compile-time scaffolding
# only — the mod links against the game's real packages at runtime — so we emit
# every class as a plain UnrealScript class and drop these keywords.
NATIVE_CLASS_MODS = {"native", "nativereplication", "noexport", "dllbind"}


def _strip_native_class_mods(mods):
    """Remove native-only class modifiers (handles ``native(CppName)`` too)."""
    return [m for m in mods
            if m not in NATIVE_CLASS_MODS and not m.startswith("native(")]


def _params_str(fn: FunctionDecl) -> str:
    parts = []
    for p in fn.params:
        bits = []
        if p.modifiers:
            bits.append(" ".join(p.modifiers) + " ")
        # Remove editinline from array types in parameter types
        param_type = p.type
        if param_type:
            # Replace array<editinline Type> with array<Type>
            import re
            param_type = re.sub(r'array\s*<\s*editinline\s+', 'array<', param_type)
            param_type = re.sub(r'array\s*<\s*editconst\s+', 'array<', param_type)
            param_type = re.sub(r'array\s*<\s*editinline\s+editconst\s+', 'array<', param_type)
            param_type = re.sub(r'array\s*<\s*editconst\s+editinline\s+', 'array<', param_type)
        bits.append(param_type)
        bits.append(" " + p.name)
        if p.dim is not None:
            bits.append(f"[{p.dim}]")
        if p.default is not None:
            bits.append("=" + p.default)
        parts.append("".join(bits))
    return ", ".join(parts)


def _clean_type(t: str) -> str:
    """Remove editinline/editconst from array generics in type strings."""
    import re
    # Replace array<editinline Type> with array<Type>
    t = re.sub(r'array\s*<\s*editinline\s+', 'array<', t)
    t = re.sub(r'array\s*<\s*editconst\s+', 'array<', t)
    t = re.sub(r'array\s*<\s*editinline\s+editconst\s+', 'array<', t)
    t = re.sub(r'array\s*<\s*editconst\s+editinline\s+', 'array<', t)
    return t


def _fn_signature(fn: FunctionDecl, keep_native: bool = False) -> str:
    """Return the function signature (through closing ')') without body."""
    # Build parts in the correct source order:
    # 1. native(index) or bare "native"
    # 2. other modifiers (static, final, etc.) except bare "native"
    # 3. operator(priority)
    # 4. operator_kind (preoperator/operator/postoperator) or kind (function/event/delegate)
    # 5. return_type
    # 6. name(params)
    bits = []

    # 1. native(index) - comes first in source
    if keep_native:
        if fn.native_index is not None:
            bits.append(f"native({fn.native_index})")
        elif "native" in fn.modifiers:
            bits.append("native")
    # else: stubs emitted as non-native classes drop native()/native keywords

    # 2. Other modifiers (excluding bare "native" since we handled it above)
    other_mods = [m for m in fn.modifiers if m != "native"]
    # 'latent'/'iterator' are only allowed on native functions; when emitting a
    # non-native class they must be dropped.
    if not keep_native:
        other_mods = [m for m in other_mods if m not in ("latent", "iterator")]
    # Interfaces can't have final, static, private, protected, public on functions
    # EXCEPT: native functions with an index (native(N)) must be static final
    if fn.operator_kind is None and fn.kind not in ("operator", "preoperator", "postoperator"):
        # Check if this function is in an interface
        # We don't have access to the parent class here, but we can strip known invalid modifiers for interfaces
        invalid_interface_mods = {"final", "static", "private", "protected", "public"}
        # But native functions with index MUST keep static final
        if fn.native_index is not None:
            # Keep static and final for indexed native functions
            invalid_interface_mods = {"private", "protected", "public"}
        other_mods = [m for m in other_mods if m not in invalid_interface_mods]
    if other_mods:
        bits.append(" ".join(other_mods))

    # 3. operator(priority)
    if fn.operator_priority is not None:
        bits.append(f"operator({fn.operator_priority})")

    # 4. operator_kind or kind
    if fn.operator_kind is not None:
        if fn.operator_kind != "operator" or fn.operator_priority is None:
            bits.append(fn.operator_kind)
    elif fn.kind:
        bits.append(fn.kind)

    # 5. return type
    if fn.return_type:
        bits.append(_clean_type(fn.return_type))

    # 6. name(params)
    bits.append(f"{fn.name}({_params_str(fn)})")

    return " ".join(bits)


def _var_decl_names(decl: str) -> List[str]:
    """Extract every declared name from a stock var declaration.

    ``var ENetRole RemoteRole, Role;`` -> ``["RemoteRole", "Role"]``.
    Handles categories ``(Display)``, modifiers, inline enum/struct bodies
    (``var(Movement) const enum EPhysics { ... } Physics;`` -> ``["Physics"]``),
    metadata ``<...>``, array dims and defaults.
    """
    import re
    body = decl.strip()
    # drop category (Display)
    body = re.sub(r'^var\s*\([^)]*\)', 'var', body, count=1)
    # drop leading 'var'
    body = body[3:].strip() if body.startswith('var') else body.strip()
    # remove inline enum/struct bodies: "enum Name { ... }" or "struct Name { ... }"
    body = re.sub(r'\b(?:enum|struct)\s+\w+\s*\{[^{}]*\}', '', body)
    # remove metadata <...> blocks (may contain '=' and '|')
    body = re.sub(r'<[^<>]*>', '', body)
    # remove native map suffixes: MenuInputSets{TMap<FName, INT>}
    body = re.sub(r'\{[^{}]*\}', '', body)
    body = re.sub(r'\s+', ' ', body).strip()

    names = []
    # A name is an identifier immediately followed by '[' (dim), '=' (default),
    # ',' or ';'. The first such identifier after the type is the first name.
    for m in re.finditer(r'\b([A-Za-z_]\w*)\s*(?=[\[=,;])', body):
        name = m.group(1)
        if name not in names:
            names.append(name)
    return names


def _var_str(vg: VarGroup, drop_native: bool = True) -> str:
    bits = ["var"]
    if vg.category:
        bits.append(vg.category)
    if vg.modifiers:
        mods = [m for m in vg.modifiers if m != "native"] if drop_native else list(vg.modifiers)
        if mods:
            bits.append(" ".join(mods))
    bits.append(_clean_type(vg.type))
    names = []
    for v in vg.vars:
        s = v.name
        if v.dim is not None:
            s += f"[{v.dim}]"
        if v.init is not None:
            s += f"={v.init}"
        names.append(s)
    bits.append(", ".join(names))
    return " ".join(bits)


def _enum_str(e: EnumDecl) -> str:
    # For stubs, omit the _MAX sentinel value (last element)
    # Format: enum EName { VAL1, VAL2, VAL3 }; with index comments
    head = f"enum {e.name}"
    lines = [head + " {"]
    members = e.members
    if members and members[-1].name.endswith("_MAX"):
        members = members[:-1]
    for i, mem in enumerate(members):
        c = f"  // {i}"
        lines.append(f"    {mem.name},{c}")
    lines.append("};")  # trailing semicolon
    return "\n".join(lines)


def _struct_str(s: StructDecl) -> str:
    # For stubs, preserve transient modifiers but strip native/atomicwhencooked/immutablewhencooked
    # (structs in a non-native class can't be 'native')
    mods_to_keep = [m for m in s.modifiers if m == "transient"]
    head = "struct"
    if mods_to_keep:
        head += " " + " ".join(mods_to_keep)
    head += f" {s.name}"
    if s.extends:
        head += f" extends {s.extends}"
    lines = [head + " {"]
    for sub in s.members:
        if isinstance(sub, VarGroup):
            lines.append("    " + _var_str(sub) + ";")
    if s.structdefaultproperties:
        lines.append("    structdefaultproperties {}")
    lines.append("};")  # Native structs end with };
    return "\n".join(lines)


def _state_str(st: StateDecl) -> str:
    # For stubs, states are simplified to just "state StateName { }" (no body)
    auto = "auto " if st.is_auto else ""
    head = f"{auto}state {st.name}"
    return head + " {}"


def _fix_replication_condition(cond: str) -> str:
    """Normalize a replication condition for compilation."""
    import re
    # Fix ROLE_ constants to use ENetRole. prefix
    cond = re.sub(r'int\((RemoteRole|Role)\)\s*==\s*int\((ROLE_\w+)\)',
                  r'int(\1) == int(ENetRole.\2)', cond)
    # Fix int(<number>) -> <number> (casting int to int is redundant)
    cond = re.sub(r'int\((\d+)\)', r'\1', cond)
    return cond


def _replication_str(r: ReplicationBlock) -> str:
    lines = ["replication {"]
    for rule in r.rules:
        rel = f"{rule.reliability} " if rule.reliability else ""
        cond = f"if({_fix_replication_condition(rule.condition)}) " if rule.condition else ""
        props = ", ".join(rule.props)
        lines.append(f"    {rel}{cond}{props};")
    lines.append("}")
    return "\n".join(lines)


def _member_refs_dropped(fn: FunctionDecl, dropped_names: set, all_classes: Optional[dict]) -> bool:
    """True if a function's signature references a name that won't compile.

    Checks the return type, each param's type and default, against ``dropped``
    (game-only vars/enum values). Also prunes when a param type is a nested
    member of another class that doesn't declare it (e.g. the game's enums).
    """
    import re
    if not dropped_names:
        return False
    def refs(text: str) -> bool:
        if not text:
            return False
        toks = re.findall(r'[A-Za-z_]\w*', text)
        return any(t.lower() in dropped_names for t in toks)
    if refs(fn.return_type):
        return True
    for p in fn.params:
        if refs(p.type) or refs(p.default):
            return True
    return False


# Vars the game added to native Actor that stock Actor doesn't have. Game-class
# replication blocks that reference them (e.g. bNetTimelapse conditions) can't
# compile against the stock Actor, so those props/conditions are pruned.
_GAME_ONLY_ACTOR_VARS = {
    "balwaysinformoftimelapse", "bclientsideonly", "bhavokposonlyusecollisioncomponent",
    "bnetacked", "bnetrelevant", "bnettimelapse", "bnettimelapseinit", "bnettimelapsepost",
    "bnotick", "botrankid", "breplicatebotrankid", "bservertickisdisabled",
    "bsupportnetirrelevant", "bupdatehavokpos", "bwhitelistcollisionwarning",
    "c_bjustendedtimelapseplayback", "c_bjuststartedtimelapseplayback", "databasefieldname",
    "indexinticklist", "lastslowrelevancychecktime", "locationpackedkey", "locationprev",
    "m_bcanbaseon", "m_bcanplayfirstpersonakevent", "m_bcomplexoccluder", "m_bhasthreadedwork",
    "m_bsupportsrelativelocationbase", "m_flastocclusionchecklocation", "m_flastocclusionchecktime",
    "m_fmaxdistforocclusioncheck", "m_fmaxdistforocclusionpathfinding", "m_focclusionamount",
    "m_focclusioncheckdist", "m_focclusioncheckinterval", "m_focclusionnormalization",
    "s_bthrottlenetrelevancy",
}


def _pruned_replication_str(r: ReplicationBlock, dropped_names: set) -> Optional[str]:
    """Render a replication block, dropping props/conditions that reference
    dropped (game-only) vars. Returns None if no rules remain."""
    import re
    lines_out = []
    for rule in r.rules:
        cond = rule.condition or ""
        props = rule.props
        # Drop props that reference dropped vars
        keep_props = []
        for p in props:
            toks = re.findall(r'[A-Za-z_]\w*', p)
            if not any(t.lower() in dropped_names for t in toks):
                keep_props.append(p)
        # Drop the whole rule if the condition references a dropped var
        cond_toks = re.findall(r'[A-Za-z_]\w*', cond)
        if any(t.lower() in dropped_names for t in cond_toks):
            continue
        if not keep_props:
            continue
        rel = f"{rule.reliability} " if rule.reliability else ""
        c = f"if({_fix_replication_condition(cond)}) " if cond else ""
        props_s = ", ".join(keep_props)
        lines_out.append(f"    {rel}{c}{props_s};")
    if not lines_out:
        return None
    return "replication {\n" + "\n".join(lines_out) + "\n}"


def _fix_defaultprops_enum_refs(text: str) -> str:
    """Make decompiled defaultproperties compilable.

    UE Explorer emits enum values as qualified member refs (e.g.
    ``Role=ENetRole.ROLE_Authority``). The defaults importer reads a single
    token per enum property and looks it up in that property's enum, so the
    ``ENetRole.`` qualifier makes the import fail with "Invalid property value
    in defaults". Strip the qualifier to the bare member name (``Role=ROLE_Authority``).

    Only dotted refs *outside* quoted strings are touched (strings hold object
    paths like ``Texture2D'EngineResources.S_Actor'`` which must be preserved).
    """
    out = []
    i = 0
    n = len(text)
    in_quote = False
    while i < n:
        ch = text[i]
        if ch == '"':
            in_quote = not in_quote
            out.append(ch)
            i += 1
            continue
        if not in_quote and (ch.isalpha() or ch == "_"):
            j = i
            while j < n and (text[j].isalnum() or text[j] == "_"):
                j += 1
            ident = text[i:j]
            # Qualified enum reference: Ident.Member
            if j < n and text[j] == ".":
                k = j + 1
                if k < n and (text[k].isalpha() or text[k] == "_"):
                    k2 = k
                    while k2 < n and (text[k2].isalnum() or text[k2] == "_"):
                        k2 += 1
                    member = text[k:k2]
                    # UE Explorer sometimes renders a numeric enum default as
                    # "EnumName.None" (e.g. ReplicatedCollisionType=ECollisionType.None).
                    # "None" isn't an enum member; emit the numeric 0 instead.
                    if member.lower() == "none":
                        out.append("0")
                    else:
                        out.append(member)
                    i = k2
                    continue
            out.append(ident)
            i = j
            continue
        out.append(ch)
        i += 1
    return "".join(out)


def _strip_inline_types(decl: str) -> str:
    """Remove inline enum/struct bodies from a stock var decl.

    Stock decls sometimes carry an inline type::
        var(Movement) const enum EPhysics { PHYS_None, ... } Physics;
    The class already declares ``EPhysics`` at class scope, so the inline body
    must go: ``var(Movement) const EPhysics Physics;``.
    """
    import re
    # "enum Name { ... }" or "struct Name { ... }" (non-nested bodies) -> keep
    # the type NAME so `var(Movement) const enum EPhysics {...} Physics;`
    # becomes `var(Movement) const EPhysics Physics;`
    out = re.sub(r'\b(?:enum|struct)\s+(\w+)\s*\{[^{}]*\}\s*', r'\1 ', decl)
    # collapse whitespace but keep category spacing readable
    out = re.sub(r'\s+', ' ', out).strip()
    return out


def _layout_fixed_var_lines(
    members: List[Any],
    stock_vars: List[tuple],
) -> List[str]:
    """Return var declaration lines reordered to match the stock native layout.

    The game's binary stripped editor-only native fields and interleaved its own
    script vars, so its class source doesn't line up with the stock UDK native
    binary we compile against. Re-declaring a native class's vars with a
    different order/types breaks property linking (Actor's ``Role`` check,
    defaults-import crashes).

    Strategy — favour compile-safety over preserving every game var change:
      1. Walk the stock var order and emit the STOCK declaration for each
         (inline enum/struct bodies stripped; class-level enums/structs are
         declared by the game's stub). This guarantees the native layout links.
      2. Append game-only vars (names with no stock counterpart, case-insensitive)
         at the end. These are script-only vars appended after the native ones,
         which the compiler tolerates (a size-mismatch warning at most).

    ``stock_vars`` is a list of ``(decl_text, name)`` in stock native order.
    """
    # Emit the stock var declarations in order. Inline enum/struct bodies are
    # stripped (the class-level type is declared separately). Game-only vars
    # (no stock counterpart) are NOT emitted: appending script vars to a native
    # class overlaps the native subclass's property region and crashes CDO
    # import, so they must be dropped (functions/replication that reference them
    # are pruned by the caller).
    lines: List[str] = []
    prev_decl = None
    for decl, name in stock_vars:
        stripped = _strip_inline_types(decl)
        # A multi-name stock decl produces several entries with the same text;
        # emit it once.
        if stripped != prev_decl:
            lines.append(stripped)
            prev_decl = stripped
    return lines


# UnrealScript primitive types and keywords that need no declaration.
_PRIMITIVES = {
    "int", "float", "bool", "byte", "string", "name", "vector", "rotator",
    "coerce", "object", "class", "pointer", "qword", "double", "color",
    "linearcolor", "guid", "int64", "matrix", "quat", "plane", "sphere",
    "box", "vector2d", "vector4", "twovectors", "delegate", "optional",
    "out", "const", "array", "init", "export", "editinline", "noclear",
    "const", "return", "none", "true", "false", "self", "super", "global",
    "reliable", "unreliable", "simulated", "event", "function", "exec",
    "latent", "iterator", "static", "final", "public", "protected",
    "private", "native", "transient", "repnotify", "interp", "config",
    "globalconfig", "noimport", "editconst", "databinding", "autocomment",
    "input", "editoronly", "duplicatetransient", "localized", "map",
    "mirror", "serializetext", "atomicwhencooked", "immutablewhencooked",
    "string", "texture", "texture2d", "texturecube", "soundcue", "material",
}


def _stock_enum_members(stock_types: Optional[List[tuple]]) -> set:
    """All enum member names from stock types (lowercased)."""
    import re
    out = set()
    for kind, name, raw in stock_types or []:
        if kind == "enum" and "{" in raw and "}" in raw:
            body = raw.split("{", 1)[1].rsplit("}", 1)[0]
            for tok in re.findall(r'[A-Za-z_]\w*', body):
                out.add(tok.lower())
    return out


def _dropped_names(members: List[Any], stock_vars: List[tuple],
                   stock_types: Optional[List[tuple]], emitted_type_names: set) -> set:
    """Names that appear in game members but won't exist in the emitted class.

    For native classes we emit stock vars (dropping game-only vars) and stock
    types (dropping game-only enum values/structs the game added). Any name the
    game uses that isn't in stock vars/types or emitted game-only types is
    unavailable; members referencing it are pruned.
    """
    stock_var_names = {name.lower() for _, name in stock_vars}
    dropped = set()
    for m in members:
        if isinstance(m, VarGroup):
            for v in m.vars:
                if v.name.lower() not in stock_var_names:
                    dropped.add(v.name.lower())
        elif isinstance(m, EnumDecl):
            # Enum members the game added that aren't in the stock enum: any use
            # of them fails (the stock enum replaced the game's). Collect them.
            stock_members = _stock_enum_members(stock_types)
            for mem in m.members:
                if mem.name.lower() not in stock_members and not mem.name.endswith("_MAX"):
                    dropped.add(mem.name.lower())
    return dropped


def _member_stub(m: Any, is_interface: bool = False, keep_native: bool = False) -> List[str]:
    """Emit a member as stub lines.

    ``is_interface`` is True when the enclosing class is emitted as an
    interface, in which case functions/events keep their ``;`` declaration form
    (interfaces can't have bodies).

    ``keep_native`` is True for classes that stay ``native`` (they have a stock
    UDK native counterpart and must match its layout). In that case native
    functions keep their ``;`` declaration form; script functions get ``{ }``.
    When False, the class is emitted non-native and every function gets ``{ }``.
    """
    if isinstance(m, VarGroup):
        # Skip compiler-generated VfTable_ variables
        if any(v.name.startswith("VfTable_") for v in m.vars):
            return []
        # Skip native-only map properties (map{...}); they can't exist in a
        # non-native class and aren't usable from UnrealScript anyway.
        if "map{" in _clean_type(m.type):
            return []
        return [_var_str(m, drop_native=not keep_native) + ";"]
    if isinstance(m, ConstDecl):
        return [f"const {m.name} = {m.value};"]
    if isinstance(m, EnumDecl):
        return [_enum_str(m).split("\n")]
    if isinstance(m, StructDecl):
        return [_struct_str(m).split("\n")]
    if isinstance(m, FunctionDecl):
        if m.kind == "delegate":
            # Delegates are always declarations (end with ;)
            export = f"  {m.export_comment}" if m.export_comment else ""
            return [f"{_fn_signature(m, keep_native=keep_native)};{export}"]
        if is_interface:
            export = f"  {m.export_comment}" if m.export_comment else ""
            return [f"{_fn_signature(m, keep_native=keep_native)};{export}"]
        if keep_native and m.is_declaration:
            # Native class native/event declarations keep their ; form
            export = f"  {m.export_comment}" if m.export_comment else ""
            return [f"{_fn_signature(m, keep_native=True)};{export}"]
        # Everything else gets an empty body
        return [f"{_fn_signature(m, keep_native=keep_native)} {{ }}"]
    if isinstance(m, ReplicationBlock):
        return [_replication_str(m).split("\n")]
    if isinstance(m, StateDecl):
        return [_state_str(m).split("\n")]
    if isinstance(m, DefaultPropertiesBlock):
        # Handled separately at class level
        return []
    return []


def _flatten(lines: List[Any]) -> List[str]:
    """Flatten nested lists of strings."""
    result: List[str] = []
    for item in lines:
        if isinstance(item, list):
            result.extend(_flatten(item))
        else:
            result.append(item)
    return result


def emit_stub(c: ClassDecl, dependson: Optional[List[str]] = None, all_classes: Optional[dict] = None,
              stock_vars: Optional[List[tuple]] = None,
              stock_types: Optional[List[tuple]] = None) -> str:
    """Emit the full stub source for a class/interface.

    ``stock_vars`` — list of ``(decl_text, name)`` in stock UDK native order;
    when provided the class is emitted native with vars matching the stock
    layout so the script links against stock native offsets.

    ``stock_types`` — list of ``(kind, name, raw_decl)`` for the stock class's
    top-level enums/structs. Emitted (merged with the game's) so stock var pads
    that reference stock-removed types resolve.
    """
    # Skip placeholder None classes (UE Explorer artifacts)
    if c.name == "None":
        return ""

    # Fix UE Explorer decompilation error: classes named Interface_* are actually interfaces
    # The decompiler incorrectly outputs them as "class Interface_..." instead of "interface Interface_..."
    # Also: if a class extends an interface, it must be an interface
    is_interface = c.kind == "interface" or c.name.startswith("Interface_")
    if not is_interface and c.extends:
        # Check if the parent is an interface
        parent_name = c.extends.split(".")[-1]
        if all_classes and parent_name in all_classes:
            if all_classes[parent_name].kind == "interface" or parent_name.startswith("Interface_"):
                is_interface = True
    kind = "interface" if is_interface else "class"

    # A class stays native when it has a stock counterpart (it must match the
    # stock native layout) or when the game declared it native (script-native
    # class with no stock counterpart; keeping native lets native classes extend
    # it, and lets game classes implement native interfaces). Interfaces are
    # never native here.
    has_stock = stock_vars is not None
    declares_native = any(m == "native" or m.startswith("native(") for m in c.modifiers)
    keep_native = not is_interface and (has_stock or declares_native)

    lines = []

    # Class header
    header = f"{kind} {c.name}"
    if c.extends:
        header += f" extends {c.extends}"
    if c.within:
        header += f" within {c.within}"
    lines.append(header)

    # Modifiers on separate lines
    if c.modifiers:
        # For interfaces, strip "abstract" keyword
        mods = [m for m in c.modifiers if not (kind == "interface" and m == "abstract")]
        if not keep_native:
            # Non-native stubs drop native-only modifiers
            mods = _strip_native_class_mods(mods)
        if mods:
            for mod in mods:
                lines.append(f"    {mod}")

    # A class that declares config/globalconfig vars must specify a config file.
    # Applies to native classes with stock pads AND game classes whose vars carry
    # a config/globalconfig modifier. Game classes also need it when they inherit
    # a config var from a stock class whose config name doesn't propagate cleanly,
    # so emit config(Engine) for every game stub class (harmless, just sets the
    # config file).
    if not any(m.startswith("config(") for m in c.modifiers):
        has_config_var = False
        if has_stock:
            has_config_var = any("config" in d for d, _ in stock_vars)
        elif not is_interface:
            has_config_var = True  # game class: always add config(Engine)
        if has_config_var:
            lines.append("    config(Engine)")

    # Add dependson modifiers
    if dependson:
        lines.append(f"    dependson({', '.join(dependson)})")

    lines[-1] += ";"
    lines.append("")

    # Leading comments on class
    for comment in c.leading_comments:
        lines.append(comment)
    if c.leading_comments:
        lines.append("")

    # Members. Vars MUST be emitted before functions/events/states: the compiler
    # clears ALLOW_VarDecl from the class nest after a function is popped, so a
    # var declared after any function is an error ("'Var' is not allowed here").
    # Order: type decls (const/enum/struct) -> vars -> functions/replication/state.
    if has_stock:
        var_lines = _layout_fixed_var_lines(c.members, stock_vars)
    else:
        var_lines = []
        for m in c.members:
            if isinstance(m, VarGroup):
                ml = _member_stub(m, is_interface=is_interface, keep_native=keep_native)
                if ml:
                    var_lines.extend(_flatten(ml))

    # Type decls first (const/enum/struct).
    #
    # For native classes with a stock counterpart, the stock types MUST be used
    # (the game's enums/structs differ from the native binary and crash CDO
    # import). Emit stock enums/structs verbatim, then game-only types (those
    # with no stock counterpart) so game code that uses them still compiles.
    #
    # For non-native (game) classes, emit the game's own type declarations.
    stock_type_names = {name.lower() for _, name, _ in (stock_types or [])}
    stock_raw_by_name = {name.lower(): raw for _, name, raw in (stock_types or [])}
    emitted_type_names = set()
    if has_stock:
        # Order matters in UnrealScript: types must be declared before use. The
        # game's member order is self-consistent (it compiled), so walk the
        # game's members in order, emitting the STOCK version wherever the game
        # type has a stock counterpart (the game's differs from the native
        # binary) and the game's own version for game-only types. Stock-only
        # types the game removed are appended at the end.
        #
        # consts first (consts must precede the structs/vars that use them)
        for m in c.members:
            if isinstance(m, ConstDecl):
                ml = _member_stub(m, is_interface=is_interface, keep_native=keep_native)
                if ml:
                    lines.extend(_flatten(ml))
                    lines.append("")
        # types in game order
        for m in c.members:
            if isinstance(m, (EnumDecl, StructDecl)):
                if m.name.lower() in emitted_type_names:
                    continue
                if m.name.lower() in stock_type_names:
                    lines.append(stock_raw_by_name[m.name.lower()])
                else:
                    ml = _member_stub(m, is_interface=is_interface, keep_native=keep_native)
                    if ml:
                        lines.extend(_flatten(ml))
                lines.append("")
                emitted_type_names.add(m.name.lower())
        # stock-only types the game removed
        for kind, name, raw in stock_types or []:
            if name.lower() not in emitted_type_names:
                lines.append(raw)
                lines.append("")
                emitted_type_names.add(name.lower())
    else:
        for m in c.members:
            if isinstance(m, (ConstDecl, EnumDecl, StructDecl)):
                ml = _member_stub(m, is_interface=is_interface, keep_native=keep_native)
                if ml:
                    lines.extend(_flatten(ml))
                    lines.append("")
                if hasattr(m, "name"):
                    emitted_type_names.add(m.name.lower())
    # Then vars
    if var_lines:
        lines.extend(var_lines)
        lines.append("")
    # Then functions / replication / states.
    # For native classes with a stock counterpart, game-only vars were dropped
    # and stock types replaced game types, so any member that references a name
    # that won't exist in the emitted class must be pruned.
    dropped_names = set()
    if has_stock:
        dropped_names = _dropped_names(c.members, stock_vars, stock_types, emitted_type_names)
    else:
        # Game classes reference game-only Actor vars (bNetTimelapse etc.) that
        # stock Actor lacks; prune those from replication.
        dropped_names = set(_GAME_ONLY_ACTOR_VARS)
    for m in c.members:
        if isinstance(m, (ConstDecl, EnumDecl, StructDecl, VarGroup)):
            continue
        if isinstance(m, FunctionDecl) and dropped_names:
            if _member_refs_dropped(m, dropped_names, all_classes):
                continue
        if isinstance(m, ReplicationBlock) and dropped_names:
            ml = _pruned_replication_str(m, dropped_names)
            if ml is None:
                continue
            lines.extend(ml.split("\n"))
            lines.append("")
            continue
        ml = _member_stub(m, is_interface=is_interface, keep_native=keep_native)
        if ml:
            lines.extend(_flatten(ml))
            lines.append("")

    # defaultproperties
    # For native classes (stock counterpart) we emit an empty defaults block:
    # they link against the stock native CDO, whose defaults already exist, and
    # importing the game's release-build defaults into the stock native layout
    # crashes the compiler (e.g. CameraActor's PostProcessSettings). The one
    # exception is Actor, whose CDO must set Role=ROLE_Authority or the compiler
    # errors. Non-native (game) classes keep the full defaults — they don't link
    # to native, so importing them is safe.
    if c.defaultproperties is not None:
        if has_stock:
            # Stock-native class: empty defaults (importing the game's release
            # defaults into the stock native layout crashes). Actor must set
            # Role=ROLE_Authority or the compiler errors.
            body = "{\n    Role=ROLE_Authority\n}" if (c.package, c.name) == ("Engine", "Actor") else "{}"
        else:
            body = c.defaultproperties.body_text or "{}"
            body = _fix_defaultprops_enum_refs(body)
            # `begin object` subobjects reference templates that the stock
            # parents don't define in the stubs; drop the whole block.
            if "begin object" in body:
                body = "{}"
        lines.append("defaultproperties")
        lines.append(body)
        lines.append("")

    return "\n".join(lines).rstrip() + "\n"