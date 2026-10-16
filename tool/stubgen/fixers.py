"""Post-generation fixes that make the stub tree compile against stock UDK.

After `stub --all` overlays game stubs onto the stock UDK source, the game's
modifications (renamed functions, game-only types/vars, changed signatures)
break compilation. These fixers reconcile the stubs with the stock classes:

  * stock_overlay  — add game-only enums/structs the game added to stock classes
  * fix_interfaces — align interface implementations to stock interface sigs
  * fix_ancestors  — align parent overrides to the stock ancestor's signature
  * final_fixes    — targeted fixes (consts, exec replication, final overrides)

All read stock classes from ``Development/Src`` (the pristine UDK tree the stubs
are overlaid onto), so they run in place after stub generation.
"""
from __future__ import annotations

import os
import re
from typing import Dict, List, Optional, Tuple, Set

STOCK_ROOT = os.path.join("Development", "Src")
GAME_PKGS = ["AkAudio", "BattleClient", "BattleGame", "OnlineSubsystemMcts",
             "PlatformCommon", "TgClient", "TgGame"]

# --------------------------------------------------------------------------- #
# helpers
# --------------------------------------------------------------------------- #

def split_params(s: str) -> List[str]:
    return [p.strip() for p in s.split(",") if p.strip()]


def param_type(p: str) -> str:
    p2 = re.sub(r"\b(optional|out|const|coerce|init)\b", "", p).strip()
    p2 = re.sub(r"\s*=\s*[^,]+", "", p2).strip()
    toks = p2.split()
    return " ".join(toks[:-1]) if len(toks) >= 2 else (toks[0] if toks else "")


def strip_comments(src: str) -> str:
    out = []
    i = 0
    n = len(src)
    in_block = False
    while i < n:
        if in_block:
            j = src.find("*/", i)
            if j == -1:
                out.append(" " * (n - i))
                break
            out.append(" " * (j + 2 - i))
            i = j + 2
            in_block = False
            continue
        c = src[i]
        if c == "/" and i + 1 < n and src[i + 1] == "*":
            in_block = True
            out.append("  ")
            i += 2
            continue
        if c == "/" and i + 1 < n and src[i + 1] == "/":
            j = src.find("\n", i)
            j = j if j != -1 else n
            out.append(" " * (j - i))
            i = j
            continue
        out.append(c)
        i += 1
    return "".join(out)


def fn_parts(text: str) -> Optional[Tuple[str, str]]:
    """Return (name, rettype) from text before '(' (last token is the name)."""
    toks = text.strip().split()
    if not toks:
        return None
    return toks[-1], " ".join(toks[:-1])


# --------------------------------------------------------------------------- #
# 1. stock_overlay — add game-only types to stock classes
# --------------------------------------------------------------------------- #

_TYPE_MODS = {"native", "transient", "atomic", "immutable", "noexport", "export",
              "atomicwhencooked", "immutablewhencooked", "databinding", "const",
              "struct", "enum"}


def _extract_blocks(src: str) -> Dict[str, str]:
    src = re.sub(r"/\*.*?\*/", "", src, flags=re.S)
    out = {}
    depth = 0
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        if c == "{":
            depth += 1
            i += 1
            continue
        if c == "}":
            depth = max(0, depth - 1)
            i += 1
            continue
        if depth == 0 and (src.startswith("enum", i) or src.startswith("struct", i)):
            m = re.match(r"(enum|struct)\s+", src[i:])
            if m:
                j = i + m.end()
                b = src.find("{", j)
                if b != -1:
                    hdr = re.sub(r"\{[^{}]*\}", " ", src[j:b])
                    nm = [t for t in re.findall(r"[A-Za-z_]\w*", hdr) if t not in _TYPE_MODS]
                    name = nm[0] if nm else None
                    d2 = 0
                    k = b
                    while k < n:
                        if src[k] == "{":
                            d2 += 1
                        elif src[k] == "}":
                            d2 -= 1
                            if d2 == 0:
                                e2 = k + 1
                                while e2 < n and src[e2] == ";":
                                    e2 += 1
                                if name:
                                    out[name] = src[i:e2]
                                i = e2
                                break
                        k += 1
                    continue
        i += 1
    return out


def _find_last_type_end(lines: List[str]) -> Optional[int]:
    depth = 0
    in_block = False
    in_cpp = False
    cpp_d = 0
    last = None
    TYPE = re.compile(r"^\s*(enum|struct)\s+")
    i = 0
    n = len(lines)
    while i < n:
        l = lines[i]
        if in_block:
            if "*/" in l:
                in_block = False
            i += 1
            continue
        if "/*" in l:
            if "*/" not in l[l.index("/*") + 2:]:
                in_block = True
            i += 1
            continue
        s = l.strip()
        if in_cpp:
            cpp_d += l.count("{") - l.count("}")
            if cpp_d <= 0:
                in_cpp = False
            i += 1
            continue
        if s.startswith("cpptext"):
            in_cpp = True
            cpp_d = l.count("{") - l.count("}")
            i += 1
            continue
        if depth == 0 and TYPE.match(l):
            j = i
            d2 = 0
            while j < n:
                d2 += lines[j].count("{") - lines[j].count("}")
                if d2 <= 0 and "};" in lines[j]:
                    last = j
                    break
                j += 1
            i = j + 1
            continue
        depth += l.count("{") - l.count("}")
        i += 1
    return last


# (package, class) pairs where the game added types stubs reference
_STOCK_TYPE_TARGETS = [
    ("Engine", "Controller"),
    ("Engine", "ParticleSystem"),
    ("Core", "Object"),
    ("Engine", "AnimNodeBlendBase"),
    ("Engine", "GameInfo"),
    ("Engine", "OnlineSubsystem"),
]


def stock_overlay() -> None:
    for epkg, cname in _STOCK_TYPE_TARGETS:
        game_file = os.path.join("exported", epkg, "Classes", cname + ".uc")
        stock_file = os.path.join(STOCK_ROOT, epkg, "Classes", cname + ".uc")
        if not (os.path.exists(game_file) and os.path.exists(stock_file)):
            continue
        gt = _extract_blocks(open(game_file).read())
        st = _extract_blocks(open(stock_file).read())
        stock_src = open(stock_file).read()
        stock_names = set(re.findall(
            r"^\s*(?:enum|struct)\s+(?:[A-Za-z_]\w*\s+)*?([A-Za-z_]\w*)\s*\{", stock_src, re.M))
        stock_lower = {nm.lower() for nm in stock_names}
        to_add = [(nm, b) for nm, b in gt.items()
                  if nm not in st and nm.lower() not in stock_lower]
        if not to_add:
            continue
        lines = stock_src.split("\n")
        last = _find_last_type_end(lines)
        ins = (last + 1) if last is not None else len(lines)
        additions = "\n\n".join(b for _, b in to_add)
        new_lines = lines[:ins] + ["", additions] + lines[ins:]
        open(stock_file, "w").write("\n".join(new_lines))
        # remove case-duplicate structs from Core.Object (stock has qword/double/pointer)
        if cname == "Object":
            s = "\n".join(new_lines)
            for dup in ["QWord", "Double", "Pointer", "HatPointer"]:
                s = re.sub(r"struct " + dup + r"\s*\{[^}]*\};\n", "", s, flags=re.S)
            open(stock_file, "w").write(s)


# --------------------------------------------------------------------------- #
# 2. fix_interfaces — align implementations to stock interface signatures
# --------------------------------------------------------------------------- #

def _interface_fns() -> Dict[str, List[Tuple[str, List[str]]]]:
    out: Dict[str, List[Tuple[str, List[str]]]] = {}
    eng = os.path.join(STOCK_ROOT, "Engine", "Classes")
    if not os.path.isdir(eng):
        return out
    for fn in os.listdir(eng):
        if not fn.endswith("Interface.uc"):
            continue
        src = open(os.path.join(eng, fn), encoding="utf-8", errors="replace").read()
        clean = strip_comments(src)
        for m in re.finditer(r"\b(?:function|delegate)\s+([^()]*?)\(([^)]*)\)", clean):
            r = fn_parts(m.group(1))
            if not r:
                continue
            name, ret = r
            params = split_params(m.group(2))
            out.setdefault(name.lower(), []).append((ret, params))
    return out


def fix_interfaces() -> None:
    ifns = _interface_fns()
    fn_re = re.compile(r"\b(function|delegate)\s+([^()]*?)\(([^)]*)\)")
    for pkg in GAME_PKGS:
        d = os.path.join("Development", "Src", pkg, "Classes")
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith(".uc"):
                continue
            path = os.path.join(d, fn)
            src = open(path, encoding="utf-8", errors="replace").read()
            if "implements(" not in src:
                continue
            clean = strip_comments(src)
            edits = []
            for m in fn_re.finditer(clean):
                kw0, pre, params_txt = m.group(1), m.group(2), m.group(3)
                r = fn_parts(pre)
                if not r:
                    continue
                name, my_ret = r
                key = name.lower()
                if key not in ifns:
                    continue
                my_params = [param_type(p) for p in split_params(params_txt)]
                target = None
                for iret, iparams in ifns[key]:
                    ipt = [param_type(p) for p in iparams]
                    if iret != my_ret or ipt != my_params:
                        target = (iret, iparams)
                        break
                if target is None:
                    continue
                iret, iparams = target
                toks = pre.strip().split()
                parts = [kw0]
                for t in toks[:-1]:
                    if t in ("native", "event", "reliable", "unreliable", "simulated",
                             "final", "static", "exec", "server", "client", "singular"):
                        parts.append(t)
                if iret:
                    parts.append(iret)
                parts.append(name)
                new_sig = " ".join(parts) + f"({', '.join(iparams)})"
                edits.append((m.start(), m.end(), new_sig))
            if edits:
                for s, e, r in sorted(edits, reverse=True):
                    src = src[:s] + r + src[e:]
                open(path, "w", encoding="utf-8").write(src)


# --------------------------------------------------------------------------- #
# 3. fix_ancestors — align parent overrides to stock ancestor signatures
# --------------------------------------------------------------------------- #

def _load_stock_classes() -> Dict[str, Tuple[str, Dict[str, Set[Tuple[str, Tuple]]]]]:
    classes: Dict[str, Tuple[str, Dict[str, Set[Tuple[str, Tuple]]]]] = {}
    for pkg in os.listdir(STOCK_ROOT):
        d = os.path.join(STOCK_ROOT, pkg, "Classes")
        if not os.path.isdir(d):
            continue
        for fn in os.listdir(d):
            if not fn.endswith(".uc"):
                continue
            src = open(os.path.join(d, fn), encoding="utf-8", errors="replace").read()
            clean = strip_comments(src)
            cm = re.search(r"\bclass\s+([A-Za-z_]\w*)\s+extends\s+([A-Za-z_]\w*)", clean)
            if not cm:
                continue
            fns: Dict[str, Set[Tuple[str, Tuple]]] = {}
            for m in re.finditer(r"\b(?:function|delegate|event)\s+([^()]*?)\(([^)]*)\)", clean):
                r = fn_parts(m.group(1))
                if not r:
                    continue
                name, ret = r
                params = split_params(m.group(2))
                fns.setdefault(name.lower(), set()).add((ret, tuple(params)))
            classes[cm.group(1)] = (cm.group(2), fns)
    return classes


def _resolve_ancestors(extends: str, classes: Dict) -> Set[str]:
    seen = set()
    out = set()
    cur = extends
    while cur:
        if cur in seen:
            break
        seen.add(cur)
        info = classes.get(cur)
        if not info:
            break
        out.add(cur)
        cur = info[0]
    return out


def fix_ancestors() -> None:
    classes = _load_stock_classes()
    # add game stub classes so extends chains resolve through them
    for pkg in GAME_PKGS:
        d = os.path.join("Development", "Src", pkg, "Classes")
        if not os.path.isdir(d):
            continue
        for fn in os.listdir(d):
            if not fn.endswith(".uc"):
                continue
            s = open(os.path.join(d, fn), encoding="utf-8", errors="replace").read()
            cm = re.search(r"\bclass\s+([A-Za-z_]\w*)\s+extends\s+([A-Za-z_]\w*)", strip_comments(s))
            if cm and cm.group(1) not in classes:
                classes[cm.group(1)] = (cm.group(2), {})
    FN = re.compile(r"\b(function|delegate|event)\s+([^()]*?)\(([^)]*)\)")
    for pkg in GAME_PKGS:
        d = os.path.join("Development", "Src", pkg, "Classes")
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith(".uc"):
                continue
            path = os.path.join(d, fn)
            src = open(path, encoding="utf-8", errors="replace").read()
            clean = strip_comments(src)
            cm = re.search(r"\bclass\s+([A-Za-z_]\w*)\s+extends\s+([A-Za-z_]\w*)", clean)
            if not cm:
                continue
            anc = _resolve_ancestors(cm.group(2), classes)
            anc_sigs: Dict[str, Set[Tuple[str, Tuple]]] = {}
            for aname in anc:
                _, afns = classes.get(aname, (None, {}))
                for k, v in afns.items():
                    anc_sigs.setdefault(k, set()).update(v)
            if not anc_sigs:
                continue
            edits = []
            for m in FN.finditer(clean):
                kw0, pre, params_txt = m.group(1), m.group(2), m.group(3)
                r = fn_parts(pre)
                if not r:
                    continue
                name, my_ret = r
                key = name.lower()
                if key not in anc_sigs:
                    continue
                my_params = [param_type(p) for p in split_params(params_txt)]
                target = None
                for sret, sparams in anc_sigs[key]:
                    spt = [param_type(p) for p in sparams]
                    if sret != my_ret or spt != my_params:
                        target = (sret, sparams)
                        break
                if target is None:
                    continue
                sret, sparams = target
                toks = pre.strip().split()
                parts = [kw0]
                # modifiers from stock rettype
                for t in sret.split():
                    if t in ("native", "event", "reliable", "unreliable", "simulated",
                             "final", "static", "exec", "server", "client", "singular"):
                        parts.append(t)
                # rettype (last token of sret)
                sret_toks = [t for t in sret.split()
                             if t not in ("native", "event", "reliable", "unreliable",
                                          "simulated", "final", "static", "exec",
                                          "server", "client", "singular")]
                if sret_toks:
                    parts.append(" ".join(sret_toks))
                parts.append(name)
                new_sig = " ".join(parts) + f"({', '.join(sparams)})"
                edits.append((m.start(), m.end(), new_sig))
            if edits:
                for s, e, r in sorted(edits, reverse=True):
                    src = src[:s] + r + src[e:]
                open(path, "w", encoding="utf-8").write(src)


# --------------------------------------------------------------------------- #
# 4. final_fixes — targeted fixes
# --------------------------------------------------------------------------- #

def _patch_gfile(fname: str, replacements: List[Tuple[str, str]]) -> None:
    for pkg in GAME_PKGS:
        p = os.path.join("Development", "Src", pkg, "Classes", fname)
        if not os.path.exists(p):
            continue
        s = open(p).read()
        for old, new in replacements:
            if old in s:
                s = s.replace(old, new)
        open(p, "w").write(s)


def _denativize(fname: str) -> None:
    for pkg in GAME_PKGS:
        p = os.path.join("Development", "Src", pkg, "Classes", fname)
        if not os.path.exists(p):
            continue
        s = open(p).read()
        s = re.sub(r"(^class\s+\S+\s+extends\s+\S+\n)(\s+)\bnative(\([^)]*\))?\n", r"\1", s)
        s = re.sub(r"\bnative\([^)]*\)\s+", "", s)
        s = re.sub(r"\bnative\s+(?=(?:exec\s+|simulated\s+|event\s+)?(?:function|event))", "", s)
        s = re.sub(r"\bnative\s+(?=const|transient|repnotify|config|noimport|editconst|pointer|map)", "", s)
        s = re.sub(r"\bvar\s+native\s+", "var ", s)
        open(p, "w").write(s)


def final_fixes() -> None:
    # TG_PAWN_PROPERTIES const (native const referenced in array sizes)
    p = os.path.join("Development", "Src", "TgGame", "Classes", "TgPawn.uc")
    s = open(p).read()
    if "const TG_PAWN_PROPERTIES" not in s:
        lines = s.split("\n")
        for i, l in enumerate(lines):
            if l.strip().startswith("class "):
                j = i
                while j < len(lines) and ";" not in lines[j]:
                    j += 1
                lines.insert(j + 1, "\nconst TG_PAWN_PROPERTIES = 8;")
                break
        open(p, "w").write("\n".join(lines))

    # final overrides the game can't override (stock parent is `final`)
    for fn in ["TgAnimNodeSlot.uc", "TgPlayerCamera.uc"]:
        for pkg in GAME_PKGS:
            p = os.path.join("Development", "Src", pkg, "Classes", fn)
            if not os.path.exists(p):
                continue
            s = open(p).read()
            s = re.sub(r"\n?native function StopCustomAnim\(float BlendOutTime\);  // Export UTgAnimNodeSlot::execStopCustomAnim[^\n]*", "", s)
            s = re.sub(r"\n?function FillCameraCache\(const out TPOV NewPOV\) \{ \}", "", s)
            open(p, "w").write(s)

    # native classes whose stock parent is non-native -> de-nativize
    _denativize("TgSpectatorController.uc")
    _denativize("TgDemoRecSpectator.uc")
    _denativize("TgDemoRecSpectator_Debug.uc")
    _patch_gfile("TgKAssetSpawnable.uc", [(
        "class TgKAssetSpawnable extends KAssetSpawnable\n    native\n",
        "class TgKAssetSpawnable extends KAssetSpawnable\n")])

    # specifier fixes (static/return type)
    _patch_gfile("TgSavedMove.uc", [(
        "function EDoubleClickDir SetFlags(byte Flags, PlayerController PC) { }",
        "static function EDoubleClickDir SetFlags(byte Flags, PlayerController PC) { }")])
    for fn in ["TgSeqAct_PlayAnnouncement.uc", "TgSeqAct_PlayCameraAnim.uc",
               "TgSeqEvent_TutorialEvent.uc"]:
        _patch_gfile(fn, [("event int GetObjClassVersion() { }",
                           "static event int GetObjClassVersion() { }")])
    _patch_gfile("TgPickupFactory_Item.uc", [(
        "function string GetLocalString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2) { }",
        "static function string GetLocalString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2) { }")])

    # replication conditions
    _patch_gfile("TgPlayerController.uc", [
        ("reliable server function ServerUse() { }",
         "unreliable server function ServerUse() { }"),
        ("reliable client simulated exec function HideMeshes(bool bHide1PMesh, bool bHide3PMesh) { }",
         "exec function HideMeshes(bool bHide1PMesh, bool bHide3PMesh) { }")])
    _patch_gfile("TgInventoryManager.uc", [(
        "simulated function SetCurrentWeapon(Weapon DesiredWeapon) { }",
        "reliable client function SetCurrentWeapon(Weapon DesiredWeapon) { }")])

    # TgLobbyHUD needs a local delegate for `delegate<OnMeshUpdated>`
    p = os.path.join("Development", "Src", "TgClient", "Classes", "TgLobbyHUD.uc")
    if os.path.exists(p):
        s = open(p).read()
        if "delegate OnMeshUpdated" not in s:
            lines = s.split("\n")
            hdr_end = None
            for i, l in enumerate(lines):
                if "class TgLobbyHUD" in l:
                    j = i
                    while j < len(lines) and ";" not in lines[j]:
                        j += 1
                    hdr_end = j
                    break
            fn_pat = re.compile(
                r"^(native|exec|reliable|unreliable|event|function|simulated|final|static|"
                r"private|protected|singular|latent|operator|delegate|preoperator|postoperator)\b")
            ins = None
            for i in range(hdr_end + 1, len(lines)):
                if fn_pat.match(lines[i].strip()):
                    ins = i
                    break
            if ins is None:
                ins = len(lines)
            lines.insert(ins, "\ndelegate OnMeshUpdated();")
            open(p, "w").write("\n".join(lines))


def run_all() -> None:
    stock_overlay()
    fix_interfaces()
    fix_ancestors()
    final_fixes()
