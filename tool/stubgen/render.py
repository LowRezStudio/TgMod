"""Human-readable tree printer for the parsed model (dry-run output)."""

from __future__ import annotations

from typing import Any, List

from .model import (
    ClassDecl,
    ConstDecl,
    EnumDecl,
    VarGroup,
    FunctionDecl,
    ReplicationBlock,
    StateDecl,
    StructDecl,
    DefaultPropertiesBlock,
    RawStatement,
    ParseError,
)


def _params_str(fn: FunctionDecl) -> str:
    parts = []
    for p in fn.params:
        bits = []
        if p.modifiers:
            bits.append(" ".join(p.modifiers) + " ")
        bits.append(p.type)
        bits.append(" " + p.name)
        if p.dim is not None:
            bits.append(f"[{p.dim}]")
        if p.default is not None:
            bits.append("=" + p.default)
        parts.append("".join(bits))
    return ", ".join(parts)


def _var_str(vg: VarGroup) -> str:
    bits = ["var"]
    if vg.category:
        bits.append(vg.category)
    if vg.modifiers:
        bits.append(" ".join(vg.modifiers))
    bits.append(vg.type)
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


def _fn_str(fn: FunctionDecl) -> str:
    # Build parts in the correct source order:
    # 1. native(index) or bare "native"
    # 2. other modifiers (static, final, etc.) except bare "native"
    # 3. operator(priority)
    # 4. operator_kind (preoperator/operator/postoperator) or kind (function/event/delegate)
    # 5. return_type
    # 6. name(params)
    bits = []

    # 1. native(index) - comes first in source
    if fn.native_index:
        bits.append(f"native({fn.native_index})")
    elif "native" in fn.modifiers:
        # Bare "native" keyword (no index)
        bits.append("native")

    # 2. Other modifiers (excluding bare "native" since we handled it above)
    other_mods = [m for m in fn.modifiers if m != "native"]
    if other_mods:
        bits.append(" ".join(other_mods))

    # 3. operator(priority)
    if fn.operator_priority:
        bits.append(f"operator({fn.operator_priority})")

    # 4. operator_kind or kind
    if fn.operator_kind:
        if fn.operator_kind != "operator" or not fn.operator_priority:
            bits.append(fn.operator_kind)
    elif fn.kind:
        bits.append(fn.kind)

    # 5. return type
    if fn.return_type:
        bits.append(fn.return_type)

    # 6. name(params)
    bits.append(f"{fn.name}({_params_str(fn)})")

    head = " ".join(bits)
    if fn.is_declaration:
        return f"{head};  [declaration]"
    return f"{head}  [body {fn.body_start}..{fn.body_end}]"


def _state_str(s: StateDecl) -> str:
    auto = "auto " if s.is_auto else ""
    mods = " ".join(s.modifiers)
    m = (mods + " ") if mods else ""
    cat = s.category if s.category else ""
    ignores = f"  ignores: {', '.join(s.ignores)}" if s.ignores else ""
    return f"{auto}state {cat}{m}{s.name}{ignores}  [body {s.body_start}..{s.body_end}]"


def _member_lines(m: Any) -> List[str]:
    if isinstance(m, VarGroup):
        return [f"L{m.line:<6} var {_var_str(m)[4:]}" if m.line else _var_str(m)]
    if isinstance(m, ConstDecl):
        return [f"L{m.line:<6} const {m.name} = {m.value}"]
    if isinstance(m, EnumDecl):
        head = f"L{m.line:<6} enum {m.name}  [{len(m.members)} members, lines {m.body_start}..{m.body_end}]"
        lines = [head]
        for mem in m.members:
            v = f" = {mem.value}" if mem.value else ""
            c = f"  {mem.comment}" if mem.comment else ""
            lines.append(f"          {mem.name}{v}{c}  (L{mem.line})")
        return lines
    if isinstance(m, StructDecl):
        head = f"L{m.line:<6} struct {m.name}  [{len(m.members)} members, lines {m.body_start}..{m.body_end}]"
        lines = [head]
        for sub in m.members:
            for ln in _member_lines(sub):
                lines.append("          " + ln)
        if m.structdefaultproperties:
            s, e, _ = m.structdefaultproperties
            lines.append(f"          structdefaultproperties  [body {s}..{e}]")
        return lines
    if isinstance(m, FunctionDecl):
        export = f"  <{m.export_comment}>" if m.export_comment else ""
        locals_ = f"  [{len(m.locals)} locals]" if m.locals else ""
        return [f"L{m.line:<6} {_fn_str(m)}{export}{locals_}"]
    if isinstance(m, ReplicationBlock):
        lines = [f"L{m.line:<6} replication  [{len(m.rules)} rules, lines {m.body_start}..{m.body_end}]"]
        for r in m.rules:
            rel = f"{r.reliability} " if r.reliability else ""
            cond = f"if({r.condition}) " if r.condition else ""
            lines.append(f"          {rel}{cond}{', '.join(r.props)}")
        return lines
    if isinstance(m, StateDecl):
        head = f"L{m.line:<6} {_state_str(m)}"
        lines = [head]
        for sub in m.members:
            if isinstance(sub, RawStatement):
                lines.append(f"          {sub.text}  (L{sub.line})")
            else:
                for ln in _member_lines(sub):
                    lines.append("          " + ln)
        return lines
    if isinstance(m, DefaultPropertiesBlock):
        return [f"L{m.line:<6} defaultproperties  [body {m.body_start}..{m.body_end}]"]
    return [f"L{m.line:<6} ? {m!r}"]


def render_class(c: ClassDecl) -> str:
    kind = "interface" if c.kind == "interface" else "class"
    header = f"L{c.header_line:<6} {kind} {c.name}"
    if c.extends:
        header += f" extends {c.extends}"
    if c.within:
        header += f" within {c.within}"
    out = [header]
    if c.modifiers:
        out.append(f"          modifiers: {', '.join(c.modifiers)}")
    out.append("")
    for m in c.members:
        out.extend(_member_lines(m))
    if c.defaultproperties is not None:
        out.extend(_member_lines(c.defaultproperties))
    if c.errors:
        out.append("")
        out.append("  ERRORS:")
        for e in c.errors:
            out.append(f"    L{e.line}: {e.message}")
    return "\n".join(out)
