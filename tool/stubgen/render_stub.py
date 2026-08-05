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


def _fn_signature(fn: FunctionDecl) -> str:
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
    if fn.native_index is not None:
        bits.append(f"native({fn.native_index})")
    elif "native" in fn.modifiers:
        # Bare "native" keyword (no index)
        bits.append("native")

    # 2. Other modifiers (excluding bare "native" since we handled it above)
    other_mods = [m for m in fn.modifiers if m != "native"]
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


def _var_str(vg: VarGroup) -> str:
    bits = ["var"]
    if vg.category:
        bits.append(vg.category)
    if vg.modifiers:
        bits.append(" ".join(vg.modifiers))
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
    # For stubs, preserve native/transient modifiers but strip atomicwhencooked/immutablewhencooked
    mods_to_keep = [m for m in s.modifiers if m in ("native", "transient")]
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


def _replication_str(r: ReplicationBlock) -> str:
    lines = ["replication {"]
    for rule in r.rules:
        rel = f"{rule.reliability} " if rule.reliability else ""
        cond = f"if({rule.condition}) " if rule.condition else ""
        props = ", ".join(rule.props)
        # Fix ROLE_ constants to use ENetRole. prefix
        import re
        cond = re.sub(r'int\((RemoteRole|Role)\)\s*==\s*int\((ROLE_\w+)\)', r'int(\1) == int(ENetRole.\2)', cond)
        # Add semicolon at end of replication rule
        lines.append(f"    {rel}{cond}{props};")
    lines.append("}")
    return "\n".join(lines)


def _member_stub(m: Any) -> List[str]:
    """Emit a member as stub lines."""
    if isinstance(m, VarGroup):
        # Skip compiler-generated VfTable_ variables
        if any(v.name.startswith("VfTable_") for v in m.vars):
            return []
        return [_var_str(m) + ";"]
    if isinstance(m, ConstDecl):
        return [f"const {m.name} = {m.value};"]
    if isinstance(m, EnumDecl):
        return [_enum_str(m).split("\n")]
    if isinstance(m, StructDecl):
        return [_struct_str(m).split("\n")]
    if isinstance(m, FunctionDecl):
        if m.is_declaration:
            # native/interface declarations already end with ;
            sig = _fn_signature(m)
            export = f"  {m.export_comment}" if m.export_comment else ""
            return [f"{sig};{export}"]
        else:
            # Has a body -> strip to empty braces
            return [f"{_fn_signature(m)} {{ }}"]
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


def emit_stub(c: ClassDecl, dependson: Optional[List[str]] = None, all_classes: Optional[dict] = None) -> str:
    """Emit the full stub source for a class/interface."""
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
        if mods:
            for mod in mods:
                lines.append(f"    {mod}")

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

    # Members
    for m in c.members:
        member_lines = _member_stub(m)
        if member_lines:
            lines.extend(_flatten(member_lines))
            lines.append("")

    # defaultproperties
    if c.defaultproperties is not None:
        lines.append("defaultproperties {}")
        lines.append("")

    return "\n".join(lines).rstrip() + "\n"