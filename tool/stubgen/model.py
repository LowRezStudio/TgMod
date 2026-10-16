"""AST model for parsed UnrealScript.

Every declaration node carries 1-based (line, col) anchors pointing at the
start of the statement. Bodies (function bodies, defaultproperties, state
bodies) keep their raw source text so later editing / re-emission has the
original bytes to work from. The model is deliberately lossless on the
things the stub generator will need (signature lines, body spans, parameter
types, keyword modifiers) and coarse elsewhere (statement-level body AST is
a later milestone; raw text is preserved meanwhile).
"""

from __future__ import annotations

from dataclasses import dataclass, field, asdict
from typing import List, Optional, Tuple, Any


@dataclass
class Node:
    """Base: source anchor (1-based line/col of the statement's first char)."""

    line: int
    col: int


@dataclass
class ConstDecl(Node):
    name: str
    value: str
    raw: str
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class EnumMember:
    name: str
    line: int
    value: Optional[str] = None  # from `= N` or the `// N` index comment
    comment: Optional[str] = None  # trailing `// ...` on the member's line


@dataclass
class EnumDecl(Node):
    name: str
    modifiers: List[str]
    members: List[EnumMember]
    body_start: int
    body_end: int
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class VarDecl:
    name: str
    dim: Optional[str] = None  # e.g. "2" from `x[2]`
    init: Optional[str] = None  # raw initializer, if any
    line: int = 0
    col: int = 0


@dataclass
class VarGroup(Node):
    """One `var ...;` statement (may declare several names)."""

    category: Optional[str]  # `(BeaconExit)` from `var(BeaconExit)`, None if absent
    modifiers: List[str]
    type: str  # e.g. "bool", "array<TgPlayerController>", "TgObject.EDeviceFailType"
    vars: List[VarDecl]
    raw: str  # the whole statement including `var` and `;`
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class Param:
    modifiers: List[str]  # out / optional / const / coerce / init ...
    type: str
    name: str
    default: Optional[str]  # raw default value (e.g. "false"), None if absent
    dim: Optional[str] = None  # fixed array size from `name[10]`, None if absent
    line: int = 0


@dataclass
class LocalDecl:
    line: int
    raw: str
    modifiers: List[str] = field(default_factory=list)
    type: Optional[str] = None
    names: List[str] = field(default_factory=list)


@dataclass
class FunctionDecl(Node):
    kind: str  # "function" | "event" | "delegate" | "operator" | "" (kindless)
    modifiers: List[str]  # native / final / exec / simulated / reliable / server / client ...
    native_index: Optional[str]  # e.g., "131" from native(131)
    operator_kind: Optional[str]  # "operator" | "preoperator" | "postoperator"
    operator_priority: Optional[str]  # e.g., "24" from operator(24)
    return_type: Optional[str]
    name: str
    params: List[Param]
    is_declaration: bool  # True = ends `;` (native/interface decl), False = has a body
    signature: str  # raw text from decl start through the closing `)`
    body_start: Optional[int]
    body_end: Optional[int]
    body_text: Optional[str]
    export_comment: Optional[str]  # attached `// Export ...` comment, if any
    locals: List[LocalDecl] = field(default_factory=list)
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class ReplicationRule:
    condition: Optional[str]  # raw `if(...)` condition, None if absent
    reliability: Optional[str]  # "reliable" | "unreliable" | None
    props: List[str]
    line: int


@dataclass
class ReplicationBlock(Node):
    rules: List[ReplicationRule]
    body_start: int
    body_end: int
    body_text: str
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class RawStatement(Node):
    text: str


@dataclass
class StateDecl(Node):
    name: str
    is_auto: bool
    category: Optional[str]
    modifiers: List[str]
    ignores: List[str]
    members: List[Any]  # FunctionDecl | RawStatement
    body_start: int
    body_end: int
    body_text: str
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class StructDecl(Node):
    name: str
    modifiers: List[str]
    extends: Optional[str]  # parent struct name, e.g. "Vector"
    members: List[Any]  # VarGroup
    structdefaultproperties: Optional[Tuple[int, int, str]]  # (start, end, text)
    body_start: int
    body_end: int
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class DefaultPropertiesBlock(Node):
    body_start: int
    body_end: int
    body_text: str
    leading_comments: List[str] = field(default_factory=list)


@dataclass
class ParseError:
    line: int
    message: str


@dataclass
class ClassDecl:
    package: str
    filename: str
    kind: str  # "class" | "interface"
    name: str
    extends: Optional[str]
    within: Optional[str]
    modifiers: List[str]  # e.g. "native(Anim)", "hidecategories(...)", "transient"
    header_line: int
    header_text: str  # raw class/interface statement through `;`
    members: List[Any]
    defaultproperties: Optional[DefaultPropertiesBlock]
    errors: List[ParseError]
    leading_comments: List[str] = field(default_factory=list)
    # New fields for dependson detection
    declared_nested_types: List[str] = field(default_factory=list)  # struct/enum names declared in this class
    referenced_types: List[str] = field(default_factory=list)  # type references used by this class


def to_dict(node: Node) -> dict:
    """Serialise any model node to a JSON-friendly dict."""
    return asdict(node)
