# tool/stubgen — UnrealScript parser for the exported Paladins source

Front end for a planned **stub generator** that will re-emit compile-able `.uc`
files into `Development/Src/`. This stage is **parser + dry-run only** — nothing
is ever written into `Development/Src/`. `dumptree` writes model JSON to a
scratch dir you choose.

Input: the UE Explorer 0.57 decompiled source under `exported/<Package>/Classes/`
(CRLF, ASCII, one class/interface per file). All ~3900 files parse clean (0 errors).

## Usage (from the repo root)

    python3 -m tool.stubgen parse exported/TgGame/Classes/TgProj_Simulated.uc
    python3 -m tool.stubgen scan [--root exported] [--only TgGame] [--limit 200] [-v]
    python3 -m tool.stubgen dumptree --out /tmp/uc-model [--only Engine]

- `parse` — parse one file, print the model tree (line anchors, body spans).
- `scan` — parse the whole tree, per-package counts; exits nonzero on errors.
- `dumptree` — write `dataclasses.asdict()` JSON per class to a scratch dir.

Smoke test: `bash tool/stubgen/test_sample.sh`.

## Files

- `lexer.py` — tokenizer (idents, numbers, strings, `'name'` literals, `//`
  comments, ops). Note: `>>` is deliberately *not* merged so `array<array<int>>`
  parses; statement bodies are kept raw so the shift op never needs tokenizing.
- `model.py` — dataclasses; every node carries 1-based `(line, col)` anchors and
  raw body text, so later editing/re-emission has the original bytes.
- `parser.py` — recursive-descent parser. The interesting bit: function names,
  return types and var types are distinguished *structurally* (the name is the
  last identifier before `(`/`,`; the type is the type-reference before it), so
  modifier keyword lists are tiny. Handles `operator(24) bool ==(...)`,
  `native(242)`, `array<delegate<X>>`, fixed-size arrays, `replication`,
  `state`/`auto state`/`simulated state`, `structdefaultproperties`, `// Export`
  comments, and error recovery (one bad member never kills the file).
- `render.py` — tree printer for `parse` / dry runs.
- `cli.py` — argparse entry point.

## Model at a glance

`ClassDecl` → ordered `members` (ConstDecl, EnumDecl, StructDecl, VarGroup,
FunctionDecl, ReplicationBlock, StateDecl) + optional `DefaultPropertiesBlock`
+ `errors`. FunctionDecl carries `kind` (function/event/delegate/operator),
`modifiers`, `return_type`, `params` (type/name/default/dim), `signature`,
`body_start/body_end`, raw `body_text`, parsed `locals`, and the attached
`// Export …` comment. VarGroup carries `category`, `modifiers`, `type`, and a
list of `VarDecl` (name, `dim`, `init`). Statement-level body AST is a later
milestone — bodies are preserved raw meanwhile.

## Next milestone

Stub generation into `Development/Src/`: emit a compile-able `.uc` skeleton per
exported class (header + var/enum/struct decls + native function declarations),
so UDK can resolve the mod's references to game classes. See `CLAUDE.md` for the
build/bundle pipeline (`tool.nu`, `EditPackages=` in `UDKEngine.ini`).
