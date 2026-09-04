// Connection and identity plumbing: proxy spawn, cheat-manager install,
// PRI setup, login URL helpers, and the client HUD scene locator.
// Champion/loadout data lives in TmChampions; ability HUD state in TmAbilityHud.
class Utils extends Object
    abstract;

static function TmProxyActor SetupProxy(TgPlayerController PC) {
    local TmProxyActor ProxyActor;

    ProxyActor = PC.Spawn(Class'TmCore.TmProxyActor', PC);
    if (ProxyActor != none) {
        ProxyActor.SetOwner(PC);

        return ProxyActor;
    } else {
        `LogError('TmCoreUtils', "Failed to spawn proxy actor");
        return none;
    }
}

// Single cheat-manager install seam. Two adapters call it: the server
// (player setup and reconnect, stock TgBattleCheatManager) and the client
// (the proxy's ClientAddCheats and the viewport, TmCheatManager).
// Re-installing the same class only re-initializes; a different class is
// replaced. bReinit also re-initializes an existing same-class manager.
static function TgBattleCheatManager InstallCheatManager(TgPlayerController PC, class<TgBattleCheatManager> CMClass, optional bool bReinit) {
    local TgBattleCheatManager CM;

    if (PC == none)
        return none;

    CM = TgBattleCheatManager(PC.CheatManager);
    if (CM != none && CM.Class == CMClass) {
        if (bReinit)
            CM.InitCheatManager();
        return CM;
    }

    PC.CheatClass = CMClass;
    CM = new (PC) CMClass;
    PC.CheatManager = CM;
    if (CM != none) {
        CM.InitCheatManager();
        `log("TmUtils: CheatManager installed: " @ string(CM.Name) @ ":" @ string(CM.Outer.Name));
    } else {
        `LogError('TmCoreUtils', "Failed to create CheatManager!");
    }
    return CM;
}

static function TgGfxScene FindSceneByClassName(TgGameHUD H, name ClassName) {
    local TgClientHUD CH;
    local UIGameMoviePlayer P;
    local TgGfxScene Found;
    local int i;

    if (H == none) {
        return none;
    }

    for (i = 0; i < H.m_SceneStack.Length; i++) {
        Found = FindSceneByClassWalk(H.m_SceneStack[i], ClassName);
        if (Found != none) {
            return Found;
        }
    }
    for (i = 0; i < H.m_PopupStack.Length; i++) {
        Found = FindSceneByClassWalk(H.m_PopupStack[i], ClassName);
        if (Found != none) {
            return Found;
        }
    }
    // All HUD scenes live on the movie player (UIHudCards/UIHudSkills/... are MovieScenes entries)
    CH = H;
    if (CH != none) {
        P = CH.m_pMovie;
        if (P != none) {
            for (i = 0; i < P.m_Scenes.Length; i++) {
                if (P.m_Scenes[i] != none && P.m_Scenes[i].Class.Name == ClassName) {
                    return P.m_Scenes[i];
                }
            }
        }
    }
    return none;
}

static function TgGfxScene FindSceneByClassWalk(TgGfxScene Scene, name ClassName) {
    local UIHud H;
    local UIGameMoviePlayer P;
    local TgGfxScene Found;
    local int i;

    if (Scene != none && Scene.Class.Name == ClassName) {
        return Scene;
    }

    H = UIHud(Scene);
    if (H == none) {
        return none;
    }

    for (i = 0; i < ArrayCount(H.m_mcSubscenes); i++) {
        if (H.m_mcSubscenes[i] != none) {
            if (H.m_mcSubscenes[i].Class.Name == ClassName) {
                return H.m_mcSubscenes[i];
            }
            Found = FindSceneByClassWalk(H.m_mcSubscenes[i], ClassName);
            if (Found != none) {
                return Found;
            }
        }
    }

    P = H.m_pMovie;
    if (P == none) {
        return none;
    }

    for (i = 0; i < P.m_Scenes.Length; i++) {
        if (P.m_Scenes[i] != none && P.m_Scenes[i].Class.Name == ClassName) {
            return P.m_Scenes[i];
        }
    }
    return none;
}

// "spec"/"spectator"/"3" all mean the spectator taskforce (10). The single
// mapping both Login's controller-class choice and GetTeam go through.
static function bool IsSpectatorTeam(string Team) {
    return Team ~= "spec" || Team ~= "spectator" || Team ~= "3";
}

static public function int GetTeam(string Team, int PlayerCount) {
    switch(Team)
    {
        case "1": return 1; break;
        case "2": return 2; break;
    }

    if (IsSpectatorTeam(Team))
        return 10;

    return (PlayerCount % 2 == 0) ? 1 : 2;
}

static function string DecodeURLParam(string encodedParam)
{
    local string decodedParam;
    decodedParam = encodedParam;

    decodedParam = Repl(decodedParam, "%spc", " ");
    decodedParam = Repl(decodedParam, "%qtm", "?");
    decodedParam = Repl(decodedParam, "%amp", "&");
    decodedParam = Repl(decodedParam, "%eql", "=");
    decodedParam = Repl(decodedParam, "%hsh", "#");
    decodedParam = Repl(decodedParam, "%prc", "%");

    return decodedParam;
}

// One place for "who is this player": the controller identity, the PRI and
// CachedPRI field copies, the spectator flag triple, and the taskforce.
// bSpectator forces the spectator presentation (name, taskforce 10, spec
// flags, no admin, no mount).
static function SetupPRI(TgRepInfo_Player PRI, string PlayerGuid, string PlayerName, int TaskForce, int MountId, bool bSpectator) {
    local TgPlayerController PC;

    PC = TgPlayerController(PRI.Owner);
    if (PC == none)
        return;

    PC.s_nPlayerId = int(PlayerGuid);
    PC.s_qwNetAccessFlags.A = 0xFFFFFFFF;
    PC.s_qwNetAccessFlags.B = 0xFFFFFFFF;

    if (bSpectator) {
        PlayerName = "spectator";
        TaskForce = 10;
        MountId = 0;
    }

    WritePRI(PRI, PC, PlayerName, TaskForce, MountId, bSpectator);
    WritePRI(PC.CachedPRI, PC, PlayerName, TaskForce, MountId, bSpectator);
}

// PRI and PC.CachedPRI carry the same fields; both copies go through here.
static function WritePRI(TgRepInfo_Player PRI, TgPlayerController PC, string PlayerName, int TaskForce, int MountId, bool bSpectator) {
    PRI.UniqueId.Uid.A = PC.s_nPlayerId;
    PRI.r_nPlayerId = PC.s_nPlayerId;
    PRI.PlayerName = PlayerName;

    if (!bSpectator)
        PRI.r_nMountSkinId = MountId;

    PRI.SetTaskForceNumber(TaskForce, true);

    PRI.bOnlySpectator = bSpectator;
    PRI.bIsSpectator = bSpectator;
    PRI.bOutOfLives = bSpectator;
    PRI.bReadyToPlay = true;
    PRI.bWaitingPlayer = false;
    PRI.bAdmin = !bSpectator;
}
