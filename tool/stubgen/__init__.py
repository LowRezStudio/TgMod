"""UnrealScript parser for UE Explorer-decompiled Paladins (UDK 2013) source.

Front end for the stub generator that will re-emit compile-able .uc files
into Development/Src/. This milestone only parses + reports; nothing is
written into the game source tree.
"""

from .model import (
    Node,
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
from .parser import Parser, UcParseError

__all__ = [
    "parse_source",
    "Parser",
    "UcParseError",
    "Node",
    "ClassDecl",
    "ConstDecl",
    "EnumDecl",
    "EnumMember",
    "VarDecl",
    "VarGroup",
    "Param",
    "LocalDecl",
    "FunctionDecl",
    "ReplicationBlock",
    "ReplicationRule",
    "StateDecl",
    "StructDecl",
    "DefaultPropertiesBlock",
    "RawStatement",
    "ParseError",
]


def parse_source(source, package="", filename="<string>"):
    """Parse UnrealScript source text into a ClassDecl."""
    return Parser(source, package=package, filename=filename).parse()
