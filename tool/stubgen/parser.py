"""Recursive-descent parser for decompiled UnrealScript.

Grammar (UE Explorer 0.57 output dialect, Paladins UDK Feb 2013):

    file          := class-header member* eof
    class-header  := ('class'|'interface') NAME ['extends' dotted] ['within' dotted]
                     (modifier ['(' ... ')'])* ';'
    member        := const | enum | struct | var | replication | state
                   | function-like | defaultproperties
    function-like := (modifier | 'function'|'event'|'delegate')* [type] NAME '(' params ')'
                     (';' | '{' body '}')
    var           := 'var' ['(' cat ')'] (modifier)* type name (',' name)* ';'
    state         := ['auto'] 'state' NAME '{' state-member* '}'

The trickiest ambiguity — distinguishing a return type from the function name
or a var's type from its first name — is resolved structurally: the name is
the last identifier before `(` (functions) or before the first `,`/`;`/`[`/`=`
(vars), and the type is the type-reference that precedes it. Modifier keywords
are only needed in the few places where they can't be inferred (params, state
members), so the keyword lists are deliberately small.

Error recovery: each top-level member is parsed in a try/except; on failure a
ParseError is recorded and the parser re-syncs to the next `;` or balanced
`{...}` group, so one bad declaration doesn't kill the whole file.
"""

from __future__ import annotations

import re
from typing import List, Optional, Tuple, Any

from .lexer import tokenize, Tok
from .model import (
    ClassDecl,
    ConstDecl,
    EnumDecl,
    EnumMember,
    VarDecl,
    VarGroup,
    Param,
    LocalDecl,
    FunctionDecl,
    ReplicationBlock,
    ReplicationRule,
    StateDecl,
    StructDecl,
    DefaultPropertiesBlock,
    RawStatement,
    ParseError,
)

# Function-kind keywords. Everything else that can lead a function signature
# (native, simulated, exec, reliable, server, client, final, static, ...) is
# handled generically by the "name = last ident before '('" rule, so we only
# need to *name* these to strip them out of the type region.
KINDS = {"function", "event", "delegate", "operator"}

# Modifiers that can lead a top-level member and therefore route dispatch
# toward a function. Used only for member-level dispatch (a bare `const` that
# is actually `const function ...`, state-member routing, and detecting
# `simulated state X` / `reliable server function ...`).
FUNCTION_MODS = {
    "native", "final", "exec", "simulated", "reliable", "unreliable", "server",
    "client", "static", "singular", "latent", "coerce", "noexport", "iterator",
    "abstract", "private", "protected", "public", "const", "cpptext",
}

# Parameter modifiers (types can't collide with these in practice).
PARAM_MODS = {"out", "optional", "const", "coerce", "init", "ref"}

# Keywords whose trailing `(...)` in a function signature is a modifier/priority
# group (native(242), operator(24)) rather than the parameter list.
# Note: preoperator/postoperator don't have parens, so they're NOT in this set.
ARG_KEYWORDS = {"native", "operator"}

# Regex to extract index from native(XX) or operator(XX)
INDEX_RE = re.compile(r"\((\d+)\)")

_LOCAL_RE = re.compile(r"^\s*local\s+(.+?)\s*;?\s*$")
_COMMENT_VALUE_RE = re.compile(r"//\s*(-?\d+)")
_EXPORT_RE = re.compile(r"^\s*//\s*Export\b")


class UcParseError(Exception):
    """Recoverable parse failure (records a ParseError, parser re-syncs)."""

    def __init__(self, line: int, msg: str):
        super().__init__(f"line {line}: {msg}")
        self.line = line
        self.msg = msg


class Parser:
    def __init__(self, source: str, package: str = "", filename: str = "<string>"):
        self.src = source
        # Split preserving interior content; strip trailing \r from each line
        # so (line, col) anchors line up with the tokenizer, which counts \r
        # as skipped whitespace at the end of a line.
        self.lines = source.split("\n")
        if self.lines and self.lines[-1] == "":
            self.lines.pop()
        self.lines = [ln[:-1] if ln.endswith("\r") else ln for ln in self.lines]
        self.package = package
        self.filename = filename
        self.tokens = tokenize(source)
        self.pos = 0
        self.errors: List[ParseError] = []
        self.current_class: Optional[ClassDecl] = None
        # For nested type tracking
        self.nested_type_stack: List[str] = []  # Stack of class names we're currently inside

    # ------------------------------------------------------------------ #
    # token helpers
    # ------------------------------------------------------------------ #

    def peek(self) -> Tok:
        return self.tokens[self.pos]

    def advance(self) -> Tok:
        t = self.tokens[self.pos]
        if t.kind != "eof":
            self.pos += 1
        return t

    def _peek_sig(self, offset: int = 0) -> Tok:
        """Peek the (offset)-th significant token without consuming."""
        i = self.pos
        seen = -1
        while i < len(self.tokens):
            t = self.tokens[i]
            if t.kind not in ("comment", "newline"):
                seen += 1
                if seen == offset:
                    return t
            i += 1
        return self.tokens[-1]  # eof

    def _is_sig(self, kind: str, text: Optional[str] = None, offset: int = 0) -> bool:
        t = self._peek_sig(offset)
        if t.kind != kind:
            return False
        return text is None or t.text == text

    def _advance_sig(self) -> Tok:
        """Skip trivia, then consume and return the next significant token."""
        while self.peek().kind in ("comment", "newline"):
            self.advance()
        return self.advance()

    def _expect(self, kind: str, text: Optional[str] = None) -> Tok:
        t = self._peek_sig(0)
        if t.kind != kind or (text is not None and t.text != text):
            raise UcParseError(
                t.line,
                f"expected {kind}{' ' + text if text else ''}, got {t.kind} {t.text!r}",
            )
        return self._advance_sig()

    def _expect_ident(self) -> Tok:
        return self._expect("ident")

    def _collect_comments(self) -> List[str]:
        """Skip trivia at a member boundary, collecting comment texts."""
        comments: List[str] = []
        while True:
            t = self.peek()
            if t.kind == "comment":
                comments.append(t.text.strip())
                self.advance()
            elif t.kind == "newline":
                self.advance()
            else:
                break
        return comments

    # ------------------------------------------------------------------ #
    # raw source slicing (line/col anchors)
    # ------------------------------------------------------------------ #

    def _raw_span(self, l1: int, c1: int, l2: int, c2: int) -> str:
        """Raw source from (l1,c1) inclusive to (l2,c2) exclusive (1-based)."""
        if l1 < 1 or l1 > len(self.lines):
            return ""
        if l2 == l1 and c2 <= c1:
            return ""
        if l1 == l2:
            ln = self.lines[l1 - 1]
            return ln[c1 - 1 : c2 - 1]
        parts = [self.lines[l1 - 1][c1 - 1 :]]
        for ln in range(l1 + 1, l2):
            parts.append(self.lines[ln - 1])
        parts.append(self.lines[l2 - 1][: c2 - 1])
        return "\n".join(parts)

    def _raw_toks(self, toks: List[Tok]) -> str:
        if not toks:
            return ""
        a = toks[0]
        b = toks[-1]
        return self._raw_span(a.line, a.col, b.line, b.col + len(b.text))

    def _line_comment(self, line_no: int) -> Optional[str]:
        if 1 <= line_no <= len(self.lines):
            s = self.lines[line_no - 1]
            idx = s.find("//")
            if idx >= 0:
                return s[idx:].strip()
        return None

    # ------------------------------------------------------------------ #
    # balanced groups
    # ------------------------------------------------------------------ #

    def _skip_balanced(self, open_ch: str, close_ch: str) -> Tok:
        """Consume from the token after open_ch through the matching close_ch.

        The caller must already have consumed the opening token; depth starts
        at 1 so the matching close is the first one that brings it to 0.
        """
        depth = 1
        while True:
            t = self.advance()
            if t.kind == "eof":
                raise UcParseError(t.line, f"unterminated '{open_ch}' block")
            if t.kind == "op":
                if t.text == open_ch:
                    depth += 1
                elif t.text == close_ch:
                    depth -= 1
                    if depth == 0:
                        return t

    def _skip_balanced_braces(self) -> Tok:
        return self._skip_balanced("{", "}")

    def _skip_balanced_paren(self) -> Tok:
        return self._skip_balanced("(", ")")

    def _collect_until(self, stop_texts: Tuple[str, ...]) -> Tuple[List[Tok], Optional[Tok]]:
        """Collect significant tokens until a top-level token in stop_texts.

        Returns (tokens, terminator); the terminator is *not* consumed.
        """
        toks: List[Tok] = []
        depth = 0
        while True:
            t = self._peek_sig(0)
            if t.kind == "eof":
                return toks, None
            if depth == 0 and t.kind == "op" and t.text in stop_texts:
                return toks, t
            self._advance_sig()
            toks.append(t)
            if t.kind == "op":
                if t.text in ("{", "(", "["):
                    depth += 1
                elif t.text in ("}", ")", "]"):
                    depth -= 1

    # ------------------------------------------------------------------ #
    # type-reference detection (shared by var / function / param / local)
    # ------------------------------------------------------------------ #

    @staticmethod
    def _type_start(region: List[Tok]) -> int:
        """Index into `region` where the trailing type-reference starts.

        `region` is the tokens before a name: a run of modifier idents followed
        by exactly one type-reference (IDENT, possibly dotted, possibly a
        generic like array<...> / delegate<...> / Class<...>). Returns the
        index of the type's first token.
        """
        if not region:
            return 0
        last = region[-1]
        if last.kind == "op" and last.text == ">":
            # generic: scan backwards from the closing `>`, find the matching
            # outermost `<`, then step to the base ident before it
            depth = 0
            cand = None
            for k in range(len(region) - 1, -1, -1):
                t = region[k]
                if t.kind == "op" and t.text == ">":
                    depth += 1
                elif t.kind == "op" and t.text == "<":
                    depth -= 1
                    if depth < 0:  # outermost '<'
                        m = k - 1
                        while m >= 0 and region[m].kind != "ident":
                            m -= 1
                        return m if m >= 0 else k
                    if depth == 0:
                        m = k - 1
                        while m >= 0 and region[m].kind != "ident":
                            m -= 1
                        cand = m if m >= 0 else k
            return cand if cand is not None else 0
        if last.kind == "ident":
            i = len(region) - 1
            if i - 1 >= 0 and region[i - 1].kind == "op" and region[i - 1].text == ".":
                k = i - 2
                while k >= 0 and region[k].kind != "ident":
                    k -= 1
                return k if k >= 0 else i - 1
            return i
        return 0

    def _extract_type_references(self, type_raw: str) -> List[str]:
        """Extract type references from a raw type string.

        Handles:
        - Simple types: "bool", "int", "float", "string", "name", "Vector", "Rotator", etc.
        - Class/struct/enum references: "MyClass", "MyStruct", "MyEnum"
        - Dotted references: "OuterClass.InnerStruct", "Package.Class.SubStruct"
        - Arrays: "array<MyType>", "MyType[10]"
        - Class references: "class<MyClass>"
        - Delegates: "delegate<...>"

        Returns a list of base type names (without generics/arrays).
        """
        if not type_raw:
            return []

        refs = []

        # Handle array<MyType> - extract MyType
        import re
        # Match array<...> and extract inner type
        array_matches = re.findall(r'array\s*<\s*([^<>]+(?:\s*<\s*[^<>]+\s*>)*\s*)>', type_raw)
        for match in array_matches:
            refs.extend(self._extract_type_references(match.strip()))

        # Handle class<...> - extract inner class
        class_matches = re.findall(r'class\s*<\s*([^<>]+(?:\s*<\s*[^<>]+\s*>)*\s*)>', type_raw)
        for match in class_matches:
            refs.extend(self._extract_type_references(match.strip()))

        # For the remaining, find identifiers that look like type names
        # Type names typically start with uppercase
        # Split by non-identifier chars but preserve dots for dotted names
        # First, replace generics with placeholder
        cleaned = re.sub(r'<[^<>]*>', '', type_raw)  # Remove simple generics
        # Remove array brackets
        cleaned = re.sub(r'\[\s*\d*\s*\]', '', cleaned)
        # Split by non-ident characters except dots
        parts = re.split(r'[^\w.]+', cleaned)

        for part in parts:
            part = part.strip('.')
            if not part:
                continue
            # Check if it looks like a type (starts with uppercase, or is a known primitive)
            # Primitives: bool, byte, int, float, double, string, name, object, class, delegate, interface,
            # array, vector, rotator, etc.
            primitives = {"bool", "byte", "int", "float", "double", "string", "name",
                         "object", "class", "delegate", "interface", "array",
                         "vector", "rotator", "plane", "quat", "color", "linearcolor",
                         "guid", "timespan", "datetime", "int64", "uint64", "uint32",
                         "uint16", "int8", "uint8", "int16", "int32", "int64"}
            if part.lower() in primitives:
                continue
            if part[0].isupper() or part[0] == '_':  # Type names typically start with uppercase
                refs.append(part)

        return refs

    def _record_type_reference(self, type_raw: str) -> None:
        """Record type references from a type string in the current class."""
        if not self.current_class:
            return
        refs = self._extract_type_references(type_raw)
        for ref in refs:
            if ref not in self.current_class.referenced_types:
                self.current_class.referenced_types.append(ref)

    def _parse_type_names(self, toks: List[Tok]) -> Tuple[List[str], str, List[VarDecl]]:
        """Parse `modifiers type name, name...` (used by var and local).

        `toks` is the significant token run of one statement (terminator `;`
        excluded). Returns (modifiers, type, var-decls).
        """
        if not toks:
            raise UcParseError(0, "empty declaration")
        # first name = first ident followed by , ; [ = or end-of-run
        name_idx: Optional[int] = None
        for i, t in enumerate(toks):
            if t.kind != "ident":
                continue
            nxt = None
            for u in toks[i + 1 :]:
                if u.kind not in ("comment", "newline"):
                    nxt = u
                    break
            if nxt is None or (nxt.kind == "op" and nxt.text in (",", ";", "[", "=")):
                name_idx = i
                break
        if name_idx is None:
            raise UcParseError(toks[0].line, "no variable name in declaration")

        region = toks[:name_idx]
        ts = self._type_start(region)
        mods = [t.text for t in region[:ts] if t.kind == "ident"]
        type_raw = self._raw_toks(region[ts:]).strip()

        # Record type reference
        self._record_type_reference(type_raw)

        names: List[VarDecl] = []
        i = name_idx
        while i < len(toks):
            t = toks[i]
            if t.kind != "ident":
                i += 1
                continue
            name = t.text
            dim = None
            init = None
            i += 1
            if i < len(toks) and toks[i].kind == "op" and toks[i].text == "[":
                dim_toks: List[Tok] = []
                i += 1
                while i < len(toks) and not (toks[i].kind == "op" and toks[i].text == "]"):
                    dim_toks.append(toks[i])
                    i += 1
                if i < len(toks):
                    i += 1  # skip ']'
                dim = self._raw_toks(dim_toks).strip()
            if i < len(toks) and toks[i].kind == "op" and toks[i].text == "=":
                init_toks: List[Tok] = []
                i += 1
                while i < len(toks) and not (
                    toks[i].kind == "op" and toks[i].text in (",", ";")
                ):
                    init_toks.append(toks[i])
                    i += 1
                init = self._raw_toks(init_toks).strip()
            names.append(VarDecl(name=name, dim=dim, init=init, line=t.line, col=t.col))
            if i < len(toks) and toks[i].kind == "op" and toks[i].text == ",":
                i += 1
            else:
                break
        return mods, type_raw, names

    # ------------------------------------------------------------------ #
    # members
    # ------------------------------------------------------------------ #

    def _parse_const(self, comments: List[str]) -> ConstDecl:
        start = self._peek_sig(0)
        self._advance_sig()  # 'const'
        name_tok = self._expect_ident()
        self._expect("op", "=")
        val_toks, term = self._collect_until((";",))
        if term is None:
            raise UcParseError(start.line, "const statement not terminated by ';'")
        value = self._raw_toks(val_toks).strip()
        raw = self._raw_span(start.line, start.col, term.line, term.col + 1)
        self._advance_sig()  # consume ';'
        return ConstDecl(
            line=start.line, col=start.col, name=name_tok.text, value=value,
            raw=raw, leading_comments=comments,
        )

    def _parse_enum(self, comments: List[str]) -> EnumDecl:
        start = self._peek_sig(0)
        self._advance_sig()  # 'enum'
        head_toks, term = self._collect_until(("{",))
        if term is None:
            raise UcParseError(start.line, "enum without '{'")
        name = None
        for t in reversed(head_toks):
            if t.kind == "ident":
                name = t.text
                break
        mods = [t.text for t in head_toks if t.kind == "ident" and t.text != name]
        body_start = term.line
        self._advance_sig()  # '{'
        members: List[EnumMember] = []
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == "}":
                break
            if t.kind == "eof":
                raise UcParseError(t.line, "unterminated enum")
            name_tok = self._expect_ident()
            comment = self._line_comment(name_tok.line)
            value = None
            nxt = self._peek_sig(0)
            if nxt.kind == "op" and nxt.text == "=":
                self._advance_sig()
                val_toks, term2 = self._collect_until((",", "}"))
                value = self._raw_toks(val_toks).strip() or None
                nxt = self._peek_sig(0)
            if value is None and comment:
                m = _COMMENT_VALUE_RE.search(comment)
                if m:
                    value = m.group(1)
            members.append(
                EnumMember(name=name_tok.text, line=name_tok.line, value=value, comment=comment)
            )
            if nxt.kind == "op" and nxt.text == ",":
                self._advance_sig()
            elif nxt.kind == "op" and nxt.text == "}":
                break
            else:
                raise UcParseError(nxt.line, f"expected ',' or '}}' after enum member, got {nxt.text!r}")
        close = self._expect("op", "}")
        if self._is_sig("op", ";"):
            self._advance_sig()

        # Record nested type declaration in current class
        if self.current_class and name:
            self.current_class.declared_nested_types.append(name)

        return EnumDecl(
            line=start.line, col=start.col, name=name or "", modifiers=mods,
            members=members, body_start=body_start, body_end=close.line,
            leading_comments=comments,
        )

    def _parse_struct(self, comments: List[str]) -> StructDecl:
        start = self._peek_sig(0)
        self._advance_sig()  # 'struct'
        head_toks, term = self._collect_until(("{",))
        if term is None:
            raise UcParseError(start.line, "struct without '{'")

        # Known struct modifiers that come before the name
        STRUCT_MODIFIERS = {"atomic", "immutable", "native", "const", "static", "export", "noexport", "transient", "atomicwhencooked", "immutablewhencooked"}

        # Find struct name (first non-modifier ident after 'struct')
        # Format: struct [modifiers...] Name [extends Base] ;
        name = None
        extends = None

        # First, collect all idents in order
        ident_tokens = [t for t in head_toks if t.kind == "ident"]

        # Skip leading modifiers
        i = 0
        while i < len(ident_tokens) and ident_tokens[i].text in STRUCT_MODIFIERS:
            i += 1

        # Next ident is the name
        if i < len(ident_tokens):
            name = ident_tokens[i].text
            i += 1

        # Check for 'extends' after name
        while i < len(ident_tokens):
            if ident_tokens[i].text == "extends":
                if i + 1 < len(ident_tokens):
                    extends = ident_tokens[i + 1].text
                break
            i += 1

        # Modifiers are all idents before the name
        mods = [t.text for t in head_toks if t.kind == "ident" and t.text in STRUCT_MODIFIERS]

        body_start = term.line
        self._advance_sig()  # '{'
        members: List[Any] = []
        sdp = None
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == "}":
                break
            if t.kind == "eof":
                raise UcParseError(t.line, "unterminated struct")
            if t.kind == "ident" and t.text == "structdefaultproperties":
                self._advance_sig()
                brace = self._expect("op", "{")
                close_b = self._skip_balanced_braces()
                sdp = (
                    brace.line,
                    close_b.line,
                    "\n".join(self.lines[brace.line - 1 : close_b.line]),
                )
                continue
            if t.kind == "ident" and t.text == "var":
                members.append(self._parse_var([]))
                continue
            raise UcParseError(t.line, f"unexpected token in struct: {t.text!r}")
        close = self._expect("op", "}")
        if self._is_sig("op", ";"):
            self._advance_sig()

        # Record nested type declaration in current class
        if self.current_class and name:
            self.current_class.declared_nested_types.append(name)

        return StructDecl(
            line=start.line, col=start.col, name=name or "", modifiers=mods, extends=extends,
            members=members, structdefaultproperties=sdp, body_start=body_start,
            body_end=close.line, leading_comments=comments,
        )

    def _parse_var(self, comments: List[str]) -> VarGroup:
        start = self._peek_sig(0)
        self._advance_sig()  # 'var'
        category = None
        if self._is_sig("op", "("):
            cs = self._advance_sig()
            ce = self._skip_balanced_paren()
            category = self._raw_span(cs.line, cs.col, ce.line, ce.col + 1)
        toks, term = self._collect_until((";",))
        if term is None:
            raise UcParseError(start.line, "var statement not terminated by ';'")
        mods, type_raw, names = self._parse_type_names(toks)
        raw = self._raw_span(start.line, start.col, term.line, term.col + 1)
        self._advance_sig()  # consume ';'
        return VarGroup(
            line=start.line, col=start.col, category=category, modifiers=mods,
            type=type_raw, vars=names, raw=raw, leading_comments=comments,
        )

    def _parse_replication(self, comments: List[str]) -> ReplicationBlock:
        start = self._peek_sig(0)
        self._advance_sig()  # 'replication'
        brace = self._expect("op", "{")
        rules: List[ReplicationRule] = []
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == "}":
                break
            if t.kind == "eof":
                raise UcParseError(t.line, "unterminated replication block")
            reliability = None
            if t.kind == "ident" and t.text in ("reliable", "unreliable"):
                reliability = t.text
                self._advance_sig()
            condition = None
            t = self._peek_sig(0)
            if t.kind == "ident" and t.text == "if":
                self._advance_sig()
                self._expect("op", "(")
                cond_toks, term = self._collect_until((")",))
                if term is None:
                    raise UcParseError(start.line, "unterminated replication condition")
                condition = self._raw_toks(cond_toks).strip()
                self._advance_sig()  # ')'
            props: List[str] = []
            while True:
                t = self._peek_sig(0)
                if t.kind == "op" and t.text == ";":
                    self._advance_sig()
                    break
                if t.kind == "op" and t.text == "}":
                    break  # safety (missing ';')
                if t.kind == "eof":
                    break
                if t.kind == "ident":
                    props.append(t.text)
                self._advance_sig()
            rules.append(
                ReplicationRule(condition=condition, reliability=reliability, props=props, line=start.line)
            )
        close = self._expect("op", "}")
        body_text = "\n".join(self.lines[brace.line - 1 : close.line])
        return ReplicationBlock(
            line=start.line, col=start.col, rules=rules, body_start=brace.line,
            body_end=close.line, body_text=body_text, leading_comments=comments,
        )

    def _looks_like_state(self) -> bool:
        """True if the token stream at self.pos is a state declaration, possibly
        preceded by 'auto' and/or function modifiers (e.g. `auto simulated state`).
        Non-consuming."""
        i = self.pos
        while i < len(self.tokens):
            t = self.tokens[i]
            if t.kind in ("comment", "newline"):
                i += 1
                continue
            if t.kind == "ident":
                if t.text == "auto" or t.text in FUNCTION_MODS:
                    i += 1
                    continue
                if t.text == "state":
                    return True
            return False
        return False

    def _parse_state(self, comments: List[str], auto: bool) -> StateDecl:
        start = self._peek_sig(0)
        mods: List[str] = []
        if auto:
            self._advance_sig()  # 'auto'
        # leading function modifiers, e.g. `simulated state X` / `auto simulated state X`
        while self._peek_sig(0).kind == "ident" and self._peek_sig(0).text in FUNCTION_MODS:
            mods.append(self._advance_sig().text)
        self._advance_sig()  # 'state'
        category = None
        if self._is_sig("op", "("):
            cs = self._advance_sig()
            ce = self._skip_balanced_paren()
            category = self._raw_span(cs.line, cs.col, ce.line, ce.col + 1)
        name_tok = self._expect_ident()
        while not self._is_sig("op", "{"):
            t = self._peek_sig(0)
            if t.kind == "eof":
                raise UcParseError(t.line, "unterminated state header")
            if t.kind == "ident":
                mods.append(t.text)
            self._advance_sig()
        brace = self._expect("op", "{")
        body_start = brace.line
        members: List[Any] = []
        ignores: List[str] = []
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == "}":
                break
            if t.kind == "eof":
                raise UcParseError(t.line, "unterminated state")
            if t.kind != "ident":
                self._advance_sig()
                continue
            w = t.text
            if w in KINDS or w in FUNCTION_MODS:
                members.append(self._parse_function_like([]))
                continue
            if w == "ignores":
                self._advance_sig()
                ign: List[str] = []
                while True:
                    t2 = self._peek_sig(0)
                    if t2.kind == "op" and t2.text == ";":
                        self._advance_sig()
                        break
                    if t2.kind == "op" and t2.text == "}":
                        break
                    if t2.kind == "ident":
                        ign.append(t2.text)
                    self._advance_sig()
                ignores = ign
                continue
            if w == "stop":
                st = self._advance_sig()
                if self._is_sig("op", ";"):
                    self._advance_sig()
                members.append(RawStatement(line=st.line, col=st.col, text="stop;"))
                continue
            if w == "begin":
                st = self._advance_sig()
                if self._is_sig("op", ":"):
                    self._advance_sig()
                members.append(RawStatement(line=st.line, col=st.col, text="begin:"))
                continue
            nxt = self._peek_sig(1)
            if nxt.kind == "op" and nxt.text == ":":
                st = self._advance_sig()
                self._advance_sig()  # ':'
                members.append(RawStatement(line=st.line, col=st.col, text=st.text + ":"))
                continue
            # fallback: a plain statement, consume to ';' (or a nested brace group)
            st = self._advance_sig()
            raw_toks = [st]
            while True:
                t2 = self._peek_sig(0)
                if t2.kind == "op" and t2.text == ";":
                    self._advance_sig()
                    break
                if t2.kind == "op" and t2.text == "}":
                    break
                if t2.kind == "eof":
                    break
                if t2.kind == "op" and t2.text == "{":
                    self._advance_sig()  # consume '{' (skip_balanced expects it consumed)
                    self._skip_balanced_braces()
                    break
                raw_toks.append(self._advance_sig())
            members.append(
                RawStatement(line=st.line, col=st.col, text=self._raw_toks(raw_toks).strip())
            )
        close = self._expect("op", "}")
        body_text = "\n".join(self.lines[body_start - 1 : close.line])
        return StateDecl(
            line=start.line, col=start.col, name=name_tok.text, is_auto=auto,
            category=category, modifiers=mods, ignores=ignores, members=members,
            body_start=body_start, body_end=close.line, body_text=body_text,
            leading_comments=comments,
        )

    def _parse_defaultprops(self, comments: List[str]) -> DefaultPropertiesBlock:
        start = self._peek_sig(0)
        self._advance_sig()  # 'defaultproperties'
        brace = self._expect("op", "{")
        close = self._skip_balanced_braces()
        body_text = "\n".join(self.lines[brace.line - 1 : close.line])
        return DefaultPropertiesBlock(
            line=start.line, col=start.col, body_start=brace.line, body_end=close.line,
            body_text=body_text, leading_comments=comments,
        )

    # ------------------------------------------------------------------ #
    # function-like declarations
    # ------------------------------------------------------------------ #

    def _parse_function_like(self, comments: List[str]) -> FunctionDecl:
        start = self._peek_sig(0)

        # Collect signature tokens, skipping modifier/priority arg groups:
        #   native(242) static final operator(24) bool ==(...)
        # The parameter-list '(' is the first one NOT attached to a keyword.
        toks: List[Tok] = []
        # Track native_index and operator_priority from modifier groups
        native_index = None
        operator_priority = None
        while True:
            t = self._peek_sig(0)
            if t.kind == "eof":
                raise UcParseError(start.line, "function signature without '('")
            if t.kind == "op" and t.text == "(":
                if toks and toks[-1].kind == "ident" and toks[-1].text in ARG_KEYWORDS:
                    kw = toks[-1].text
                    self._advance_sig()  # '('
                    # Collect the content of the paren group to extract index
                    paren_content = []
                    depth = 1
                    while depth > 0:
                        nt = self._advance_sig()
                        if nt.kind == "op":
                            if nt.text == "(":
                                depth += 1
                            elif nt.text == ")":
                                depth -= 1
                                if depth == 0:
                                    break
                        if depth > 0:
                            paren_content.append(nt)
                    # Extract index from paren content
                    index = None
                    for pt in paren_content:
                        if pt.kind == "number":
                            index = pt.text
                            break
                    if kw == "native":
                        native_index = index
                        # native(XX) is always a modifier group, pop it
                        toks.pop()
                    elif kw == "operator":
                        operator_priority = index
                        # operator(XX) is the priority modifier; DON'T pop the operator token
                        # We need it later to detect op_kind (operator vs preoperator vs postoperator)
                        pass
                    continue
                break  # this is the parameter list
            toks.append(self._advance_sig())
        if not toks:
            raise UcParseError(start.line, "empty function signature")
        paren_tok = self._peek_sig(0)

        # operator / preoperator / postoperator: the name is the symbol after
        # the return type, so it may not be an identifier at all (==, &&, !).
        op_kind = None
        op_idx = -1
        for i in range(len(toks) - 1, -1, -1):
            if toks[i].kind == "ident" and toks[i].text in ("operator", "preoperator", "postoperator"):
                op_kind = toks[i].text
                op_idx = i
                break

        if op_kind is not None:
            kind = "operator"
            after = toks[op_idx + 1 :]
            return_type = None
            name_start = None
            if after:
                if after[0].kind == "ident":
                    return_type = after[0].text
                    name_start = after[1] if len(after) > 1 else None
                else:
                    name_start = after[0]
            if name_start is None:
                raise UcParseError(start.line, "operator declaration without a symbol")
            name = self._raw_span(name_start.line, name_start.col, paren_tok.line, paren_tok.col).strip()
            mods = [t.text for t in toks[:op_idx] if t.kind == "ident"]
            # operator_kind is already set to op_kind (operator/preoperator/postoperator)
            operator_kind = op_kind
        else:
            kind = ""
            name = None
            name_idx = -1
            for i in range(len(toks) - 1, -1, -1):
                if toks[i].kind == "ident":
                    name = toks[i].text
                    name_idx = i
                    break
            if name is None:
                raise UcParseError(start.line, "no function name in signature")
            region = toks[:name_idx]
            kind_idx = -1
            for i in range(len(region) - 1, -1, -1):
                if region[i].kind == "ident" and region[i].text in KINDS:
                    kind = region[i].text
                    kind_idx = i
                    break
            return_type = None
            if kind:
                mods = [t.text for t in region[:kind_idx] if t.kind == "ident"]
                type_part = region[kind_idx + 1 :]
                if type_part:
                    ts = self._type_start(type_part)
                    if ts < len(type_part):
                        return_type = self._raw_toks(type_part[ts:]).strip()
                        # Record return type reference
                        self._record_type_reference(return_type)
                    # any idents between kind and the type are modifiers (rare)
                    mods += [t.text for t in type_part[:ts] if t.kind == "ident"]
            else:
                mods = [t.text for t in region if t.kind == "ident"]
            # Non-operator functions don't have operator_kind/operator_priority, but native_index may have been set
            if native_index is None:
                native_index = None
            operator_kind = None
            operator_priority = None

        self._advance_sig()  # '('
        params, close_paren = self._parse_params()

        signature = self._raw_span(start.line, start.col, close_paren.line, close_paren.col + 1)
        export = self._find_export_comment(comments)

        t = self._peek_sig(0)
        if t.kind == "op" and t.text == ";":
            self._advance_sig()
            return FunctionDecl(
                line=start.line, col=start.col, kind=kind, modifiers=mods,
                native_index=native_index, operator_kind=operator_kind, operator_priority=operator_priority,
                return_type=return_type, name=name, params=params,
                is_declaration=True, signature=signature,
                body_start=None, body_end=None, body_text=None,
                export_comment=export, leading_comments=comments,
            )
        if t.kind == "op" and t.text == "{":
            brace = self._advance_sig()
            close_b = self._skip_balanced_braces()
            body_text = "\n".join(self.lines[brace.line - 1 : close_b.line])
            locals_ = self._parse_locals(body_text, brace.line)
            return FunctionDecl(
                line=start.line, col=start.col, kind=kind, modifiers=mods,
                native_index=native_index, operator_kind=operator_kind, operator_priority=operator_priority,
                return_type=return_type, name=name, params=params,
                is_declaration=False, signature=signature,
                body_start=brace.line, body_end=close_b.line, body_text=body_text,
                export_comment=export, locals=locals_, leading_comments=comments,
            )
        raise UcParseError(t.line, f"expected '{{' or ';' after function signature, got {t.text!r}")

    def _parse_params(self) -> Tuple[List[Param], Tok]:
        params: List[Param] = []
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == ")":
                close = self._advance_sig()
                return params, close
            params.append(self._parse_param())
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == ",":
                self._advance_sig()
            elif t.kind == "op" and t.text == ")":
                continue
            else:
                raise UcParseError(t.line, f"expected ',' or ')' in parameter list, got {t.text!r}")

    def _parse_param(self) -> Param:
        start = self._peek_sig(0)
        toks, term = self._collect_until((",", ")"))
        if not toks:
            raise UcParseError(start.line, "empty parameter")
        if term is None:
            raise UcParseError(start.line, "unterminated parameter")

        # split on the first top-level '=' (default value)
        default = None
        decl = toks
        for i, t in enumerate(toks):
            if t.kind == "op" and t.text == "=":
                decl = toks[:i]
                default = self._raw_toks(toks[i + 1 :]).strip()
                break
        if not decl:
            raise UcParseError(start.line, "empty parameter declaration")

        name = None
        name_idx = -1
        for i in range(len(decl) - 1, -1, -1):
            if decl[i].kind == "ident":
                name = decl[i].text
                name_idx = i
                break
        if name is None:
            raise UcParseError(start.line, "parameter without name")

        region = decl[:name_idx]
        mods: List[str] = []
        j = 0
        while j < len(region) and region[j].kind == "ident" and region[j].text in PARAM_MODS:
            mods.append(region[j].text)
            j += 1
        rest = region[j:]
        ptype = ""
        if rest:
            ts = self._type_start(rest)
            if ts < len(rest):
                ptype = self._raw_toks(rest[ts:]).strip()
                # Record parameter type reference
                self._record_type_reference(ptype)
        # fixed-size array dim after the name, e.g. `name TrackControllerName[10]`
        dim = None
        k = name_idx + 1
        while k < len(decl):
            if decl[k].kind == "op" and decl[k].text == "[":
                dim_toks: List[Tok] = []
                k += 1
                while k < len(decl) and not (decl[k].kind == "op" and decl[k].text == "]"):
                    dim_toks.append(decl[k])
                    k += 1
                dim = self._raw_toks(dim_toks).strip()
                break
            break
        return Param(modifiers=mods, type=ptype, name=name, default=default, dim=dim, line=start.line)

    # ------------------------------------------------------------------ #
    # locals
    # ------------------------------------------------------------------ #

    def _parse_locals(self, body_text: str, body_line: int) -> List[LocalDecl]:
        result: List[LocalDecl] = []
        for idx, line in enumerate(body_text.split("\n")):
            m = _LOCAL_RE.match(line)
            if not m:
                continue
            line_no = body_line + idx
            raw = line.strip()
            decl: Optional[LocalDecl] = None
            try:
                toks = [t for t in tokenize(m.group(1) + ";") if t.kind not in ("comment", "newline")]
                mods, type_raw, names = self._parse_type_names(toks)
                decl = LocalDecl(
                    line=line_no, raw=raw, modifiers=mods,
                    type=type_raw or None, names=[v.name for v in names],
                )
            except UcParseError:
                decl = LocalDecl(line=line_no, raw=raw)
            result.append(decl)
        return result

    @staticmethod
    def _find_export_comment(comments: List[str]) -> Optional[str]:
        for c in comments:
            if _EXPORT_RE.match(c):
                return c
        return None

    # ------------------------------------------------------------------ #
    # class / interface
    # ------------------------------------------------------------------ #

    def _parse_header(self) -> ClassDecl:
        comments = self._collect_comments()
        start = self._peek_sig(0)
        if start.kind != "ident" or start.text not in ("class", "interface"):
            raise UcParseError(start.line, f"expected 'class' or 'interface', got {start.text!r}")
        kind = start.text
        self._advance_sig()
        name_tok = self._expect_ident()
        name = name_tok.text
        extends = None
        within = None
        mods: List[str] = []
        semi = None
        while True:
            t = self._peek_sig(0)
            if t.kind == "op" and t.text == ";":
                semi = self._advance_sig()
                break
            if t.kind == "eof":
                raise UcParseError(t.line, "class header not terminated by ';'")
            if t.kind == "ident" and t.text == "extends":
                self._advance_sig()
                parts = [self._expect_ident().text]
                while self._is_sig("op", "."):
                    self._advance_sig()
                    parts.append(self._expect_ident().text)
                extends = ".".join(parts)
                continue
            if t.kind == "ident" and t.text == "within":
                self._advance_sig()
                parts = [self._expect_ident().text]
                while self._is_sig("op", "."):
                    self._advance_sig()
                    parts.append(self._expect_ident().text)
                within = ".".join(parts)
                continue
            if t.kind == "ident":
                mod_start = self._advance_sig()
                if self._is_sig("op", "("):
                    cs = self._advance_sig()
                    ce = self._skip_balanced_paren()
                    mods.append(self._raw_span(mod_start.line, mod_start.col, ce.line, ce.col + 1))
                else:
                    mods.append(mod_start.text)
                continue
            # stray token in header (shouldn't happen) — skip it
            self._advance_sig()
        if semi is None:
            raise UcParseError(start.line, "class header not terminated by ';'")
        header_text = self._raw_span(start.line, start.col, semi.line, semi.col + 1)
        return ClassDecl(
            package=self.package, filename=self.filename, kind=kind, name=name,
            extends=extends, within=within, modifiers=mods, header_line=start.line,
            header_text=header_text, members=[], defaultproperties=None,
            errors=self.errors, leading_comments=comments,
        )

    # ------------------------------------------------------------------ #
    # top level
    # ------------------------------------------------------------------ #

    def _parse_member(self) -> Any:
        comments = self._collect_comments()
        t = self._peek_sig(0)
        if t.kind == "eof":
            return None  # trailing comments/blank lines at end of file
        if t.kind != "ident":
            raise UcParseError(t.line, f"unexpected top-level token {t.kind} {t.text!r}")
        w = t.text

        if w == "defaultproperties":
            return self._parse_defaultprops(comments)
        if w == "const":
            nxt = self._peek_sig(1)
            if nxt.kind == "ident" and (nxt.text in KINDS or nxt.text in FUNCTION_MODS):
                return self._parse_function_like(comments)
            return self._parse_const(comments)
        if w == "enum":
            return self._parse_enum(comments)
        if w == "struct":
            return self._parse_struct(comments)
        if w == "var":
            return self._parse_var(comments)
        if w == "replication":
            return self._parse_replication(comments)
        if w == "state":
            return self._parse_state(comments, auto=False)
        if w == "auto":
            if self._looks_like_state():
                return self._parse_state(comments, auto=True)
            raise UcParseError(t.line, f"unrecognized top-level declaration: {w!r}")
        if w in KINDS or w in FUNCTION_MODS:
            if w in FUNCTION_MODS and self._looks_like_state():
                return self._parse_state(comments, auto=False)
            return self._parse_function_like(comments)
        raise UcParseError(t.line, f"unrecognized top-level declaration: {w!r}")

    def _resync(self) -> None:
        """Consume to the next top-level ';' or balanced '{}' group."""
        depth = 0
        while True:
            t = self.peek()
            if t.kind == "eof":
                return
            if t.kind == "op":
                if t.text in ("{", "(", "["):
                    depth += 1
                elif t.text in ("}", ")", "]"):
                    if depth == 0 and t.text == "}":
                        self.advance()
                        return
                    depth = max(0, depth - 1)
                elif t.text == ";" and depth == 0:
                    self.advance()
                    return
            self.advance()

    def parse(self) -> ClassDecl:
        header = self._parse_header()
        self.current_class = header
        self.nested_type_stack = [header.name]
        members: List[Any] = []
        while self.peek().kind != "eof":
            try:
                m = self._parse_member()
                if m is not None:
                    members.append(m)
            except UcParseError as e:
                self.errors.append(ParseError(line=e.line, message=e.msg))
                self._resync()
        # defaultproperties, if present, is the last member
        defaultproperties = None
        if members and isinstance(members[-1], DefaultPropertiesBlock):
            defaultproperties = members[-1]
            members = members[:-1]
        header.members = members
        header.defaultproperties = defaultproperties
        header.errors = self.errors
        return header
