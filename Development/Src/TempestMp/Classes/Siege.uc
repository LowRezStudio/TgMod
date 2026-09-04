class Siege extends TgGame_Paladins_Siege;

var transient TgRepInfo_Game GRI;

// Raw login payload as sent by the launcher via connect URL options.
struct transient IncomingLoginData {
    var string PlayerGuid;
    var string PlayerName;
    var string ChampionName;
    var string Team;
};

// Login data bound to the exact PlayerController it was parsed for.
struct transient PendingLogin {
    var PlayerController PC;
    var IncomingLoginData Data;
};

// Champion choice persists across respawns.
struct transient ChampionAssignment {
    var int PlayerId;
    var string ChampionName;
};

// Per-client precache record; CachedBotIds dedups the RPCs.
struct transient ProxyPrecacheState {
    var TmProxyActor Proxy;
    var PlayerController OwnerPC;
    var array<int> CachedBotIds;
};

// Non-champion TestPrecache entries with fixed skin ids (horse mount, Ying illusion).
struct transient ExtraPrecacheInfo {
    var int BotId;
    var int SkinId;
    var int HeadId;
    var int WeaponSkinId;
};

var transient array<PendingLogin> PendingLogins;
var transient array<ChampionAssignment> ChampionAssignments;
var transient array<ProxyPrecacheState> PrecacheStates;
var transient array<ExtraPrecacheInfo> ExtraPrecaches;
var transient array<int> ChampionsToPrecache;

// Consumed within a single Login() call, never across events.
var transient class<PlayerController> NextControllerClass;
var transient string NextPlayerGuid;

event PreLogin(string Options, string Address, const UniqueNetId UniqueId, bool bSupportsAuth, out string ErrorMessage) {
    super.PreLogin(Options, Address, UniqueId, bSupportsAuth, ErrorMessage);
    if (ErrorMessage != "")
        return;

    if (ParseOption(Options, "playerguid") == "")
        `LogWarn('TmSiege', "Login from "$Address$" has no playerguid — identity tracking will be degraded");
}

// Parsed here because only Login() pairs a connection's options with its
// controller spawn. Signature must match runtime Engine.u GameInfo exactly
event PlayerController Login(string Portal, string Options, const UniqueNetID UniqueID, out string ErrorMessage, const optional UniqueNetId ConsoleUniqueId) {
    local PlayerController NewPC;
    local IncomingLoginData Data;

    if (`UTILS.IsSpectatorTeam(ParseOption(Options, "team")))
        NextControllerClass = Class'TmCore.TmSpectatorController';
    else
        NextControllerClass = Class'TgGame.TgPlayerController';
    NextPlayerGuid = ParseOption(Options, "playerguid");

    NewPC = super.Login(Portal, Options, UniqueID, ErrorMessage, ConsoleUniqueId);

    // Never leak into another connection's spawn.
    NextControllerClass = none;
    NextPlayerGuid = "";

    if (NewPC != none && ErrorMessage == "") {
        Data = BuildLoginData(Options);
        RegisterPendingLogin(NewPC, Data);
        `LogInfo('TmSiege', "Login queued: "$Data.PlayerName@"guid="$Data.PlayerGuid@"champ="$Data.ChampionName@"team="$Data.Team);
    }

    return NewPC;
}

function IncomingLoginData BuildLoginData(string Options) {
    local IncomingLoginData Data;

    Data.PlayerGuid = ParseOption(Options, "playerguid");
    Data.PlayerName = `UTILS.decodeURLParam(ParseOption(Options, "name"));
    Data.ChampionName = ParseOption(Options, "class");
    Data.Team = ParseOption(Options, "team");
    return Data;
}

function RegisterPendingLogin(PlayerController NewPC, IncomingLoginData Data) {
    local int i;

    PrunePendingLogins();

    // Retire stale entries so a reconnect replaces rather than coexists.
    for (i = PendingLogins.Length - 1; i >= 0; i--) {
        if (PendingLogins[i].PC == NewPC || (Data.PlayerGuid != "" && PendingLogins[i].Data.PlayerGuid == Data.PlayerGuid))
            PendingLogins.Remove(i, 1);
    }
    AddPendingLoginEntry(NewPC, Data);
}

function AddPendingLoginEntry(PlayerController NewPC, IncomingLoginData Data) {
    local PendingLogin Entry;
    Entry.PC = NewPC;
    Entry.Data = Data;
    PendingLogins.AddItem(Entry);
}

function PrunePendingLogins() {
    local int i;

    for (i = PendingLogins.Length - 1; i >= 0; i--) {
        if (PendingLogins[i].PC == none)
            PendingLogins.Remove(i, 1);
    }
}

function bool FindPendingLogin(PlayerController PC, out IncomingLoginData OutData) {
    local int i;

    for (i = 0; i < PendingLogins.Length; i++) {
        if (PendingLogins[i].PC == PC) {
            OutData = PendingLogins[i].Data;
            PendingLogins.Remove(i, 1);
            return true;
        }
    }
    return false;
}

function PlayerController SpawnPlayerController(Vector SpawnLocation, Rotator SpawnRotation) {
    local PlayerController NewPC;

    if (NextControllerClass != none) {
        NewPC = Spawn(NextControllerClass,,, SpawnLocation, SpawnRotation);
        if (NextPlayerGuid != "") {
            if (TgPlayerController(NewPC) != none)
                TgPlayerController(NewPC).s_nPlayerId = int(NextPlayerGuid);
        } else {
            `LogWarn('TmSiege', "Spawned controller without playerguid");
        }
        if (TmSpectatorController(NewPC) != none) {
            NewPC.PlayerReplicationInfo.bOnlySpectator = true;
            NewPC.PlayerReplicationInfo.bIsSpectator = true;
            NewPC.PlayerReplicationInfo.bOutOfLives = true;
        }
        return NewPC;
    }
    return super.SpawnPlayerController(SpawnLocation, SpawnRotation);
}

public event PostLogin(PlayerController NewPlayer) {
    local TgPlayerController TgPC;
    local TgRepInfo_Player PRI;
    local TmProxyActor ProxyActor;
    local IncomingLoginData LoginData;
    local ChampionInfo ChampInfo;
    local int Team;

    super.PostLogin(NewPlayer);

    if (!FindPendingLogin(NewPlayer, LoginData)) {
        // Shouldn't happen; degrade instead of leaving the player unconfigured.
        LoginData.PlayerName = "Player"$NewPlayer.PlayerReplicationInfo.PlayerID;
        LoginData.ChampionName = "Cassie";
        `LogWarn('TmSiege', "PostLogin without pending data for "$string(NewPlayer)$" — using defaults");
    }

    ProxyActor = `UTILS.SetupProxy(TgPlayerController(NewPlayer));
    if (ProxyActor == none) {
        `LogError('TmSiege', "Failed to spawn proxy actor for "$NewPlayer.PlayerReplicationInfo.PlayerName);
        return;
    }
    ProxyActor.ServerAddCheats();
    RegisterProxy(ProxyActor);

    // Fresh client needs everything currently in play.
    SendFullPrecache(ProxyActor);

    TgPC = TgPlayerController(NewPlayer);
    if (TmSpectatorController(NewPlayer) != none) {
        `UTILS.SetupPRI(TgRepInfo_Player(TmSpectatorController(NewPlayer).PlayerReplicationInfo), LoginData.PlayerGuid, "", 10, 0, true);
        SetupSpectator(TmSpectatorController(NewPlayer), ProxyActor);
        return;
    }

    Team = `UTILS.GetTeam(LoginData.Team, GetPlayerCount());
    PRI = TgRepInfo_Player(NewPlayer.PlayerReplicationInfo);
    `UTILS.SetupPRI(PRI, LoginData.PlayerGuid, LoginData.PlayerName, Team, 0, false);

    if (!AttemptReconnect(TgPC, ProxyActor, LoginData)) {
        ChampInfo = `CHAMPS.ResolveChampion(LoginData.ChampionName);
        BroadcastNewPrecache(ChampInfo.BotId);
        SetupPlayer(ProxyActor, TgPC, LoginData, Team, ChampInfo);
    }
}

public event PostBeginPlay() {
    local ExtraPrecacheInfo E;

    super.PostBeginPlay();
    GRI = TgRepInfo_Game(WorldInfo.GRI);

    if (GRI != none) {
        GRI.r_bKillCamEnabled = true;
        GRI.r_bAttackersKillCamEnabled = true;
        GRI.r_bDefendersKillCamEnabled = true;
        GRI.r_bBlockKillCam = false;
    }

    E.BotId = 2236; E.SkinId = 12612; // Horse
    ExtraPrecaches.AddItem(E);
    E.BotId = 2267; E.SkinId = 18656; E.HeadId = 18655; E.WeaponSkinId = 18657;  // Ying Illusion
    ExtraPrecaches.AddItem(E);
}

event Logout(Controller Exiting) {
    local int i, ExitingId;

    super.Logout(Exiting);

    ExitingId = -1;
    if (TgPlayerController(Exiting) != none)
        ExitingId = TgPlayerController(Exiting).s_nPlayerId;
    else if (TmSpectatorController(Exiting) != none)
        ExitingId = TmSpectatorController(Exiting).s_nPlayerId;

    for (i = PendingLogins.Length - 1; i >= 0; i--) {
        if (PendingLogins[i].PC == none || PendingLogins[i].PC == Exiting)
            PendingLogins.Remove(i, 1);
    }
    for (i = PrecacheStates.Length - 1; i >= 0; i--) {
        if (PrecacheStates[i].OwnerPC == none || PrecacheStates[i].OwnerPC == Exiting)
            PrecacheStates.Remove(i, 1);
    }
    for (i = ChampionAssignments.Length - 1; i >= 0; i--) {
        if (ChampionAssignments[i].PlayerId == ExitingId)
            ChampionAssignments.Remove(i, 1);
    }
}

function SetChampionAssignment(int PlayerId, string ChampionName) {
    local int i;

    if (PlayerId <= 0)
        return;

    for (i = 0; i < ChampionAssignments.Length; i++) {
        if (ChampionAssignments[i].PlayerId == PlayerId) {
            ChampionAssignments[i].ChampionName = ChampionName;
            return;
        }
    }
    AddChampionAssignment(PlayerId, ChampionName);
}

function AddChampionAssignment(int PlayerId, string ChampionName) {
    local ChampionAssignment A;
    A.PlayerId = PlayerId;
    A.ChampionName = ChampionName;
    ChampionAssignments.AddItem(A);
}

function ChampionInfo GetAssignedChampion(int PlayerId) {
    local int i;

    if (PlayerId > 0) {
        for (i = 0; i < ChampionAssignments.Length; i++) {
            if (ChampionAssignments[i].PlayerId == PlayerId)
                return `CHAMPS.ResolveChampion(ChampionAssignments[i].ChampionName);
        }
    }
    // Zero-struct: caller falls back to stock spawn.
    return `CHAMPS.EmptyChampion();
}

function SetupPlayer(TmProxyActor ProxyActor, TgPlayerController PC, IncomingLoginData LoginData, int Team, ChampionInfo Champ) {
    local TgRepInfo_Player PRI;
    local TgPawn_Character Pawn;

    SetChampionAssignment(int(LoginData.PlayerGuid), Champ.Name);

    `UTILS.InstallCheatManager(PC, Class'TgGame.TgBattleCheatManager');
    PRI = TgRepInfo_Player(PC.PlayerReplicationInfo);
    `CHAMPS.ApplyChampionToPRI(PRI, Champ);

    RestartPlayer(PC);

    PC.r_bAutoPurchase = false;
    Pawn = TgPawn_Character(PC.Pawn);
    if (Pawn != none) {
        `CHAMPS.ApplyLoadoutToPawn(PC, Pawn, `CHAMPS.GetLoadoutByBotId(Champ.BotId));
        // Remove mid air inaccuracy
        Pawn.m_bAirAccuracyPenalty = false;
    }

    ProxyActor.ClientConsoleCommand("setreadytoplay");
}

function bool AttemptReconnect(TgPlayerController PC, TmProxyActor ProxyActor, IncomingLoginData LoginData) {
    local TgAIController_BehaviorGodDisconnected AI;
    local TgPawn P;
    local TgRepInfo_Player PRI;
    local int PlayerId, Team;

    PlayerId = int(LoginData.PlayerGuid);
    if (PlayerId <= 0)
        return false;

    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGodDisconnected', AI) {
        if (AI.PlayerID != PlayerId)
            continue;

        P = TgPawn(AI.Pawn);
        if (P == none || !P.IsAliveAndWell()) {
            `LogInfo('TmSiege', "Reconnect: player id "$PlayerId$" — old pawn gone, discarding "$AI);
            AI.UnPossess();
            AI.Destroy();
            continue;
        }

        `LogInfo('TmSiege', "Reconnect: player id "$PlayerId$" taking back pawn "$P);

        Team = P.GetTaskForceNumber();
        if (Team <= 0 || Team >= 10)
            Team = 1;

        PRI = TgRepInfo_Player(PC.PlayerReplicationInfo);
        `UTILS.SetupPRI(PRI, LoginData.PlayerGuid, LoginData.PlayerName, Team, 0, false);
        `CHAMPS.ApplyChampionToPRI(PRI, `CHAMPS.GetChampionByBotId(P.r_nProfileId));
        SetChampionAssignment(PlayerId, `CHAMPS.GetChampionByPawnClass(P.r_nProfileId).Name);
        `UTILS.InstallCheatManager(PC, Class'TgGame.TgBattleCheatManager');

        AI.CopyPropertiesTo(PC);

        AI.UnPossess();
        AI.Destroy();

        PC.Possess(P, true);
        PC.GotoState('PlayerWalking');
        PC.AcknowledgePossession(P);
        P.PostPawnSetupServer();

        ProxyActor.ClientConsoleCommand("setreadytoplay");
        return true;
    }

    return false;
}

function SetupSpectator(TmSpectatorController SPC, TmProxyActor ProxyActor) {
    local TgPawn TargetPawn;
    local TgPlayerController TargetPC;

    if (SPC == none)
        return;

    SPC.ForwardToSpectatingMatch();

    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TargetPC) {
        if (TargetPC == SPC)
            continue;
        TargetPawn = TgPawn(TargetPC.Pawn);
        if (TargetPawn != none && TargetPawn.IsAliveAndWell())
            break;
    }
    if (TargetPawn != none)
        SPC.SpectatorSetViewTarget(TargetPawn);

    ProxyActor.ClientConsoleCommand("setreadytoplay");
    ProxyActor.ClientConsoleCommand("spectogglefirstperson");
}

function bool IsPlayerReadyToSpawn(TgPlayerController PC) {
      return PC != none && PC.PlayerReplicationInfo != none
          && TgRepInfo_Player(PC.PlayerReplicationInfo).r_TaskForce != none;
}

function RestartPlayer(Controller NewPlayer) {
    local TgPlayerController PC;
    PC = TgPlayerController(NewPlayer);
    if (PC == none)
        return;

    if ((PC != none) && PC.Player != none && !PC.PlayerReplicationInfo.bOnlySpectator) {
        NewPlayer.PlayerReplicationInfo.bReadyToPlay = false;
        PC.ClientSetReadyState(false);
        NewPlayer.GotoState('PlayerWaiting');
        if (!IsPlayerReadyToSpawn(PC)) {
            PlayerController(NewPlayer).ClientGotoState('Dead', 'Begin');
            return;
        }
    } else if (PC != none) {
        PC.ClientSetReadyState(false);
        if (PC.PlayerReplicationInfo.bOnlySpectator)
            return;
    }
    super(GameInfo).RestartPlayer(NewPlayer);
    if (PC.Pawn != none)
        TgPawn(PC.Pawn).PostPawnSetupServer();
}

function Pawn SpawnDefaultPawnFor(Controller NewPlayer, NavigationPoint StartSpot) {
    local TgPlayerController PC;
    local TgPawn P;
    local Controller OldCtrl;
    local ChampionInfo Champ;

    PC = TgPlayerController(NewPlayer);
    if (PC == none)
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);

    Champ = GetAssignedChampion(PC.s_nPlayerId);
    if (Champ.BotId <= 0) {
        `LogWarn('TmSiege', "No champion assignment for player id "$PC.s_nPlayerId$" — falling back to stock spawn");
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);
    }

    EnsureBotPrecache(Champ.BotId, Champ.SkinId, Champ.HeadId, Champ.WeaponSkinId);

    if (StartSpot == none)
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);

    P = SpawnBotById(Champ.BotId, Champ.SkinId, Champ.HeadId, Champ.WeaponSkinId, StartSpot.Location, StartSpot.Rotation, none);
    if (P != none) {
        OldCtrl = P.Controller;
        if (OldCtrl != none)
            OldCtrl.Destroy();
        P.r_bIsBot = false;
        return P;
    }

    // Fallback
    return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);
}

function RegisterProxy(TmProxyActor ProxyActor) {
    local ProxyPrecacheState Cache;

    PruneProxies();

    Cache.Proxy = ProxyActor;
    Cache.OwnerPC = PlayerController(ProxyActor.Owner);
    PrecacheStates.AddItem(Cache);
}

function PruneProxies() {
    local int i;

    for (i = PrecacheStates.Length - 1; i >= 0; i--) {
        if (PrecacheStates[i].Proxy == none || PrecacheStates[i].OwnerPC == none)
            PrecacheStates.Remove(i, 1);
    }
}

function int FindProxyIndex(TmProxyActor ProxyActor) {
    local int i;

    for (i = 0; i < PrecacheStates.Length; i++) {
        if (PrecacheStates[i].Proxy == ProxyActor)
            return i;
    }
    return -1;
}

// Everything currently in play plus extras.
function SendFullPrecache(TmProxyActor ProxyActor) {
    local int Idx, i;

    Idx = FindProxyIndex(ProxyActor);
    if (Idx < 0)
        return;

    for (i = 0; i < ChampionsToPrecache.Length; i++)
        PushPrecache(Idx, ChampionsToPrecache[i]);

    for (i = 0; i < ExtraPrecaches.Length; i++)
        PushPrecache(Idx, ExtraPrecaches[i].BotId);
}

// Send a new champion only to clients that don't have it yet.
function BroadcastNewPrecache(int BotId) {
    local int i;

    if (BotId <= 0)
        return;

    if (ChampionsToPrecache.Find(BotId) == INDEX_NONE)
        ChampionsToPrecache.AddItem(BotId);

    PruneProxies();
    for (i = 0; i < PrecacheStates.Length; i++)
        PushPrecache(i, BotId);
}

function PushPrecache(int Idx, int BotId) {
    local ProxyPrecacheState Cache;
    local ChampionInfo C;
    local int j;

    if (Idx < 0 || Idx >= PrecacheStates.Length || BotId <= 0)
        return;
    Cache = PrecacheStates[Idx];

    if (Cache.Proxy == none)
        return;
    if (Cache.CachedBotIds.Find(BotId) != INDEX_NONE)
        return;   // already sent to this client

    Cache.CachedBotIds.AddItem(BotId);

    C = `CHAMPS.GetChampionByBotId(BotId);
    if (C.BotId > 0) {
        Cache.Proxy.ClientPrecacheClass(C.Name);
        Cache.Proxy.ClientTestPrecache(C.BotId, C.SkinId, C.WeaponSkinId, C.HeadId);
    } else {
        // Fixed-id extra (horse, illusion clone): send its exact skin ids.
        for (j = 0; j < ExtraPrecaches.Length; j++) {
            if (ExtraPrecaches[j].BotId == BotId) {
                Cache.Proxy.ClientTestPrecache(ExtraPrecaches[j].BotId, ExtraPrecaches[j].SkinId, ExtraPrecaches[j].WeaponSkinId, ExtraPrecaches[j].HeadId);
                break;
            }
        }
    }

    // Structs copy by value, write back.
    PrecacheStates[Idx] = Cache;
}
