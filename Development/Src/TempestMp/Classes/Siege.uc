class Siege extends TgGame_Paladins_Siege;

var transient TgRepInfo_Game GRI;

struct transient IncomingLoginData {
    var string NetAddress;
    var int UniqueId;
    var string PlayerGuid;
    var string PlayerName;
    var string ChampionName;
    var string Team;
    var string Password;
    var string Horse;
    var array<string> Cards;
    var string Talent;
};

struct transient ServerParameters {
    var int MaxPlayers;
    var string Password;
    var string Map;
};

var transient array<TmProxyActor> ProxyActors;
var transient array<IncomingLoginData> IncomingLogins;
var transient ServerParameters ServerParams;
var transient class<PlayerController> NextControllerClass;
var transient string NextPlayerGuid;

var transient array<int> ChampionsToPrecache;
var transient string DesiredChampionName;
var transient ChampionInfo DesiredChampion;
var transient LoadoutInfo DesiredLoadout;

function PlayerController SpawnPlayerController(Vector SpawnLocation, Rotator SpawnRotation) {
    local PlayerController NewPC;

    if (NextControllerClass != none) {
        NewPC = Spawn(NextControllerClass,,, SpawnLocation, SpawnRotation);
        NextControllerClass = none;
        if (NextPlayerGuid != "" && TgPlayerController(NewPC) != none)
            TgPlayerController(NewPC).s_nPlayerId = `UTILS.ToInt(NextPlayerGuid);
        NextPlayerGuid = "";
        if (TmSpectatorController(NewPC) != none) {
            NewPC.PlayerReplicationInfo.bOnlySpectator = true;
            NewPC.PlayerReplicationInfo.bIsSpectator = true;
            NewPC.PlayerReplicationInfo.bOutOfLives = true;
        }
        return NewPC;
    }
    return super.SpawnPlayerController(SpawnLocation, SpawnRotation);
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

    PC = TgPlayerController(NewPlayer);
    if (PC == none)
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);

    if (DesiredChampion.BotId <= 0) {
        if (DesiredChampionName == "")
            DesiredChampionName = "Cassie";
        DesiredChampion = `UTILS.GetChampionByName(DesiredChampionName);
    }
    if (DesiredChampion.BotId <= 0) {
        `LogWarn('TmSiege', "Unknown champion '" @ DesiredChampionName @ "' — falling back to stock spawn");
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);
    }

    EnsureBotPrecache(DesiredChampion.BotId, DesiredChampion.SkinId, DesiredChampion.HeadId, DesiredChampion.WeaponSkinId);

    if (StartSpot == none)
        return super.SpawnDefaultPawnFor(NewPlayer, StartSpot);

    P = SpawnBotById(DesiredChampion.BotId, DesiredChampion.SkinId, DesiredChampion.HeadId, DesiredChampion.WeaponSkinId, StartSpot.Location, StartSpot.Rotation, none);
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

event PreLogin(string Options, string Address, const UniqueNetId UniqueId, bool bSupportsAuth, out string ErrorMessage) {
    local IncomingLoginData Data;
    local TgPlayerController PC;
    local string PlayerGuid;
    local int i, BotId;

    super.PreLogin(Options, Address, UniqueId, bSupportsAuth, ErrorMessage);

    Address = Repl(Address, ".", "");

    Data.NetAddress = Address;
    Data.PlayerGuid = ParseOption(Options, "playerguid");;
    Data.PlayerName = `UTILS.decodeURLParam(ParseOption(Options, "name"));
    Data.ChampionName = ParseOption(Options, "class");
    Data.Team = ParseOption(Options, "team");
    Data.password = ParseOption(Options, "password");
    Data.horse = ParseOption(Options, "horse");

    if (Data.PlayerGuid != "") {
        for (i = IncomingLogins.Length - 1; i >= 0; i--) {
            if (IncomingLogins[i].PlayerGuid == Data.PlayerGuid) {
                IncomingLogins.Remove(i, 1);
            }
        }
    }

    if (Data.Team ~= "spec" || Data.Team ~= "spectator" || Data.Team ~= "3")
        NextControllerClass = Class'TmCore.TmSpectatorController';
    else
        NextControllerClass = Class'TgGame.TgPlayerController';
    NextPlayerGuid = Data.PlayerGuid;

    BotId = `UTILS.GetChampionByName(Data.ChampionName).BotId;
    if (BotId > 0 && ChampionsToPrecache.Find(BotId) == -1) {
        ChampionsToPrecache.AddItem(BotId);
        `LogInfo('TmSiege', "Added '"$Data.ChampionName$"' to precache list");
    }

    IncomingLogins.AddItem(Data);
}

public event PostLogin(PlayerController NewPlayer) {
    local TgPlayerController TgPC;
    local TgRepInfo_Player PRI;
    local TgRepInfo_Player SPRI;
    local TmProxyActor ProxyActor;
    local TgPawn_Character TgP;
    local TgRepInfo_Player TgRPI;
    local TgInventoryManager InvMgr;
    local TgDevice_Mount MountDevice;
    local IncomingLoginData LoginData;
    local ChampionInfo ChampInfo;
    local string Address;
    local int i, j, Team, LoginIndex, PlayerId;
    super.PostLogin(NewPlayer);

    Address = Repl(NewPlayer.GetPlayerNetworkAddress(), ".", "");

    LoginIndex = -1;
    TgPC = TgPlayerController(NewPlayer);
    if (TgPC != none)
        PlayerId = TgPC.s_nPlayerId;
    for (i = 0; i < IncomingLogins.Length; i++) {
        if (PlayerId > 0 && IncomingLogins[i].PlayerGuid != ""
            && `UTILS.ToInt(IncomingLogins[i].PlayerGuid) == PlayerId) {
            LoginIndex = i;
            break;
        }
    }
    if (LoginIndex == -1) {
        for (i = 0; i < IncomingLogins.Length; i++) {
            if (IncomingLogins[i].NetAddress == Address) {
                LoginIndex = i;
                break;
            }
        }
    }
    if (LoginIndex == -1 && IncomingLogins.Length > 0)
        LoginIndex = 0;   // FIFO fallback
    if (LoginIndex >= 0) {
        LoginData = IncomingLogins[LoginIndex];
        IncomingLogins.Remove(LoginIndex, 1);
    }

    TgRPI = TgRepInfo_Player(NewPlayer.PlayerReplicationInfo);

    ProxyActor = `UTILS.SetupProxy(TgPC);
    ProxyActors.AddItem(ProxyActor);

    // TODO: dupe CMs when reconnecting
    ProxyActor.ServerAddCheats();

    for (i = 0; i < ChampionsToPreCache.Length; i++) {
        ChampInfo = `UTILS.GetChampionByBotId(ChampionsToPreCache[i]);
        ProxyActor.ClientPrecacheClass(ChampInfo.Name);

        for (j = 0; j < ProxyActors.Length; j++) {
            ProxyActors[j].ClientTestPrecache(ChampInfo.BotId, ChampInfo.SkinId, ChampInfo.WeaponSkinId, ChampInfo.HeadId);
        }
    }

    // Horse
    ProxyActor.ClientTestPrecache(2236, 12612, 0, 0);
    // Ying Illusion
    ProxyActor.ClientTestPrecache(2267, 18656, 18655, 18657);

    PRI = TgRepInfo_Player(TgPlayerController(NewPlayer).PlayerReplicationInfo);
    SPRI = TgRepInfo_Player(TmSpectatorController(NewPlayer).PlayerReplicationInfo);

    Team = `UTILS.GetTeam(LoginData.Team, (self != none) ? GetPlayerCount() : 0);
    if (TmSpectatorController(NewPlayer) != none) {
        `UTILS.SetupSpecPRI(self, SPRI, LoginData.PlayerGuid);
        SetupSpectator(ProxyActor, TgPC, LoginData);
    } else {
        if (!AttemptReconnect(TgPC, ProxyActor, LoginData)) {
            `UTILS.SetupPRI(self, PRI, LoginData.PlayerGuid, LoginData.PlayerName, Team, 0);
            SetupPlayer(ProxyActor, TgPC, LoginData, Team);
        }
    }
}

function bool AttemptReconnect(TgPlayerController PC, TmProxyActor ProxyActor, IncomingLoginData LoginData) {
    local TgAIController_BehaviorGodDisconnected AI;
    local TgPawn P;
    local TgRepInfo_Player PRI;
    local int PlayerId, Team;

    PlayerId = `UTILS.ToInt(LoginData.PlayerGuid);
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
        `UTILS.SetupPRI(self, PRI, LoginData.PlayerGuid, LoginData.PlayerName, Team, 0);
        `UTILS.SetupCM(PC);

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

public event PostBeginPlay() {
    super.PostBeginPlay();
    GRI = TgRepInfo_Game(WorldInfo.GRI);

    if (GRI != none) {
        GRI.r_bKillCamEnabled = true;
        GRI.r_bAttackersKillCamEnabled = true;
        GRI.r_bDefendersKillCamEnabled = true;
        GRI.r_bBlockKillCam = false;
    }
}

function SetupPlayer(TmProxyActor ProxyActor, TgPlayerController PC, IncomingLoginData LoginData, int Team) {
    local TgRepInfo_Player PRI;
    local TgPawn_Character Pawn;

    `UTILS.SetupCM(PC);

    if (LoginData.ChampionName != "" && `UTILS.ChampionExists(LoginData.ChampionName)) {
        DesiredChampionName = LoginData.ChampionName;
    } else if (LoginData.ChampionName != "") {
        `LogWarn('TmSiege', "Unknown champion '" @ LoginData.ChampionName @ "' — defaulting to Cassie");
        DesiredChampionName = "Cassie";
    }

    if (DesiredChampionName == "")
        DesiredChampionName = "Cassie";

    DesiredChampion = `UTILS.GetChampionByName(DesiredChampionName);
    DesiredLoadout = `UTILS.GetLoadoutByBotId(DesiredChampion.BotId);

    PRI = TgRepInfo_Player(PC.PlayerReplicationInfo);
    `UTILS.ApplyChampionToPRI(PRI, DesiredChampion);

    RestartPlayer(PC);

    PC.r_bAutoPurchase = false;
    if (Role == ROLE_Authority) {
        PC.r_bAutoPurchase = false;
    }

    Pawn = TgPawn_Character(PC.Pawn);
    if (Pawn != none) {
        `UTILS.ApplyLoadoutToPawn(PC, Pawn, DesiredLoadout);
    }

    ProxyActor.ClientConsoleCommand("setreadytoplay");
}

function SetupSpectator(TmProxyActor ProxyActor, TgPlayerController PC, IncomingLoginData LoginData) {
    local TmSpectatorController SPC;
    local TgPawn TargetPawn;
    local TgPlayerController TargetPC;

    SPC = TmSpectatorController(PC);
    if (SPC == none)
        return;

    SPC.ForwardToSpectatingMatch();

    foreach WorldInfo.AllControllers(Class'TgGame.TgPlayerController', TargetPC) {
        if (TargetPC == PC)
            continue;
        TargetPawn = TgPawn(TargetPC.Pawn);
        if (TargetPawn != none && TargetPawn.IsAliveAndWell())
            break;
    }
    if (TargetPawn != none)
        SPC.SpectatorSetViewTarget(TargetPawn);

    ProxyActor.ClientConsoleCommand("setreadytoplay");
}