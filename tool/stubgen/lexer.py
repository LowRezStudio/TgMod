"""Tokenizer for decompiled UnrealScript.

Produces a flat token list with 1-based line/col anchors. Token kinds:
ident, number, string ("..."), name ('...'), op, comment (//), newline, eof.

Notes on the decompiled dialect:
- Line comments are `//`. There are no block comments in UE Explorer output.
- `Class'Engine.Controller'` and `enum'...'` type literals tokenize naturally
  as IDENT + NAME, which is fine because those appear in raw-preserved regions.
- `>>` is intentionally NOT merged into one token: `array<array<int>>` and
  `delegate<X> >` must lex as separate `>` ops so the parser can match generics.
  Statement bodies are kept raw, so the arithmetic `>>` is never reconstructed
  from tokens.
"""

from __future__ import annotations

from typing import List

_KINDS = {"ident", "number", "string", "name", "op", "comment", "newline", "eof"}

# Multi-char operators that are unambiguous in this dialect.
_MULTI_OPS = ("==", "!=", "<=", ">=", "&&", "||", "+=", "-=", "*=", "/=", "::", "++", "--")
_SINGLE_OPS = set(";(){}[],:=<>+-*/@?&|!#.%")


class Tok:
    __slots__ = ("kind", "text", "line", "col")

    def __init__(self, kind: str, text: str, line: int, col: int):
        assert kind in _KINDS, kind
        self.kind = kind
        self.text = text
        self.line = line
        self.col = col

    def __repr__(self) -> str:  # pragma: no cover - debug aid
        return f"Tok({self.kind},{self.text!r},{self.line}:{self.col})"


def tokenize(src: str) -> List[Tok]:
    toks: List[Tok] = []
    i = 0
    n = len(src)
    line = 1
    col = 1

    while i < n:
        c = src[i]

        if c == "\n":
            toks.append(Tok("newline", "\n", line, col))
            i += 1
            line += 1
            col = 1
            continue

        if c in " \t\r":
            i += 1
            col += 1
            continue

        if c == "/" and i + 1 < n and src[i + 1] == "/":
            j = i
            while j < n and src[j] != "\n":
                j += 1
            toks.append(Tok("comment", src[i:j], line, col))
            col += j - i
            i = j
            continue

        if c == '"':
            j = i + 1
            while j < n and src[j] != '"':
                if src[j] == "\\":
                    j += 1
                j += 1
            if j < n:
                j += 1  # closing quote
            toks.append(Tok("string", src[i:j], line, col))
            col += j - i
            i = j
            continue

        if c == "'":
            j = i + 1
            while j < n and src[j] != "'":
                if src[j] == "\\":
                    j += 1
                j += 1
            if j < n:
                j += 1
            toks.append(Tok("name", src[i:j], line, col))
            col += j - i
            i = j
            continue

        if c.isalpha() or c == "_":
            j = i + 1
            while j < n and (src[j].isalnum() or src[j] == "_"):
                j += 1
            toks.append(Tok("ident", src[i:j], line, col))
            col += j - i
            i = j
            continue

        if c.isdigit():
            j = i
            if src.startswith(("0x", "0X"), i):
                j = i + 2
                while j < n and (src[j] in "0123456789abcdefABCDEF"):
                    j += 1
            else:
                while j < n and (src[j].isdigit() or src[j] == "."):
                    j += 1
                # optional exponent (1.0e+10) — rare, but harmless to accept
                if j < n and src[j] in "eE":
                    k = j + 1
                    if k < n and src[k] in "+-":
                        k += 1
                    if k < n and src[k].isdigit():
                        while k < n and src[k].isdigit():
                            k += 1
                        j = k
            toks.append(Tok("number", src[i:j], line, col))
            col += j - i
            i = j
            continue

        if src.startswith(_MULTI_OPS, i):
            two = src[i : i + 2]
            toks.append(Tok("op", two, line, col))
            i += 2
            col += 2
            continue

        if c in _SINGLE_OPS:
            toks.append(Tok("op", c, line, col))
            i += 1
            col += 1
            continue

        # Unknown character — surface as an op token so the parser can report it.
        toks.append(Tok("op", c, line, col))
        i += 1
        col += 1

    toks.append(Tok("eof", "", line, col))
    return toks
