class Siege extends TgGame_Paladins_Siege;

var transient TgGame TgG;
var transient TgRepInfo_Game GRI;

struct transient IncomingLoginData {
    var string NetAddress;
    var int UniqueId;
    var int PlayerGuid;
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
var transient ServerParameters ServerOptions;

var transient array<int> ChampionsToPrecache;
var transient string DesiredChampionName;
var transient ChampionInfo DesiredChampion;
var transient LoadoutInfo DesiredLoadout;

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
        `LogWarn('TempestMp', "Unknown champion '" @ DesiredChampionName @ "' — falling back to stock spawn");
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
    local int i, PlayerGuid;
    
    super.PreLogin(Options, Address, UniqueId, bSupportsAuth, ErrorMessage);

    Address = Repl(Address, ".", "");

    PlayerGuid = (((`UTILS.ToInt(Address) % 1000000) + ((int(WorldInfo.TimeSeconds * 10000) % 10000000) * 1000)) / (Len(Address) * 10));
    `if(`isdefined(RANDOM_PLAYER_ID))
        `LogInfo('TmSiege', "RANDOM_PLAYER_ID is set!");
        PlayerGuid = PlayerGuid + Rand(10000);
    `endif

    PlayerGuid = int(Abs(PlayerGuid));
    `log(PlayerGuid);

    for (i = 0; i < IncomingLogins.Length; i++) {
        if (IncomingLogins[i].NetAddress == Address) {
            IncomingLogins.Remove(i, 1);
        }
    }

    Data.NetAddress = Address;
    Data.PlayerGuid = PlayerGuid;
    Data.PlayerName = `UTILS.decodeURLParam(ParseOption(Options, "name"));
    Data.ChampionName = ParseOption(Options, "class");
    Data.Team = ParseOption(Options, "team");
    Data.password = ParseOption(Options, "password");
    Data.horse = ParseOption(Options, "horse");

    ChampionsToPrecache.AddItem(`UTILS.GetChampionByName(Data.ChampionName).BotId);
    `LogInfo('TmSiege', "Added '"$Data.ChampionName$"' to precache list");
    
    IncomingLogins.AddItem(Data);
}

function TaskforceWin(int nTaskForce, TgGame_PaladinsExtended.EVictoryType VictoryType) {
    super.TaskforceWin(nTaskForce, VictoryType);
}

public event PostLogin(PlayerController NewPlayer) {
    local TgPlayerController TgPC;
    local TmProxyActor ProxyActor;
    local TgPawn_Character TgP;
    local TgRepInfo_Player TgRPI;
    local TgInventoryManager InvMgr;
    local TgDevice_Mount MountDevice;
    local IncomingLoginData LoginData;
    local TgGame_Battle BattleGame;
    local ChampionInfo ChampInfo;
    local string Address;
    local int i, j, Team;
    super.PostLogin(NewPlayer);

    Address = Repl(NewPlayer.GetPlayerNetworkAddress(), ".", "");
    
    for (i = 0; i < IncomingLogins.Length; i++) {
        if (IncomingLogins[i].NetAddress == Address) {
            LoginData = IncomingLogins[i];
        }
    }

    TgPC = TgPlayerController(NewPlayer);
    TgRPI = TgRepInfo_Player(NewPlayer.PlayerReplicationInfo);

    ProxyActor = `UTILS.SetupProxy(TgPC);
    ProxyActors.AddItem(ProxyActor);

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

    BattleGame = TgGame_Battle(WorldInfo.Game);
    Team = `UTILS.GetTeam(LoginData.Team, (BattleGame != none) ? BattleGame.GetPlayerCount() : 0);
    if (Team == 10) {
        SetupSpectator(ProxyActor, TgPC, LoginData);
    } else {
        SetupPlayer(ProxyActor, TgPC, LoginData, Team);
    }
}

public event PostBeginPlay() {
    super.PostBeginPlay();
    TgG = TgGame(WorldInfo.Game);
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
        `LogWarn('TempestMp', "Unknown champion '" @ LoginData.ChampionName @ "' — defaulting to Cassie");
        DesiredChampionName = "Cassie";
    }

    if (DesiredChampionName == "")
        DesiredChampionName = "Cassie";

    DesiredChampion = `UTILS.GetChampionByName(DesiredChampionName);
    DesiredLoadout = `UTILS.GetLoadoutByBotId(DesiredChampion.BotId);

    PRI = TgRepInfo_Player(PC.PlayerReplicationInfo);
    `UTILS.SetupPRI(TgG, PRI, LoginData.PlayerGuid, LoginData.PlayerName, Team, 0);
    `UTILS.ApplyChampionToPRI(PRI, DesiredChampion);

    RestartPlayer(PC);

    Pawn = TgPawn_Character(PC.Pawn);
    if (Pawn != none) {
        `UTILS.ApplyLoadoutToPawn(PC, Pawn, DesiredLoadout);
    }

    ProxyActor.ClientConsoleCommand("setreadytoplay");
}

function SetupSpectator(TmProxyActor ProxyActor, TgPlayerController PC, IncomingLoginData LoginData) {
    local TmSpectatorController SPC;
    local TgRepInfo_Player PRI;

    `LogInfo('TempestMp', "SetupSpectator ENTER: PC=" @ PC @ "PC.Player=" @ (PC != none ? PC.Player : none) @ "PC.PlayerIsNetConnection=" @ (PC != none && PC.Player != none && NetConnection(PC.Player) != none));

    PC.CheatClass = Class'TgGame.TgBattleCheatManager';
    if(PC.CheatManager == none) {
        PC.CheatManager = new (PC) Class'TgGame.TgBattleCheatManager';
        if(PC.CheatManager != none)
        {
            PC.CheatManager.InitCheatManager();
            `log((("TempestProxyActor: CheatManager successfully created and initialized : " @ string(PC.CheatManager.Name)) @ ":") @ string(PC.CheatManager.Outer.Name));
        }
        else
        {
            `log("TempestProxyActor: Failed to create CheatManager!");
        }
    }

    SPC = Spawn(Class'TmCore.TmSpectatorController');

    PRI = TgRepInfo_Player(SPC.PlayerReplicationInfo);

    PC.Player.SwitchController(SPC);

    `UTILS.SetupPRI(TgG, PRI, LoginData.PlayerGuid, LoginData.PlayerName, 10, 0);
    
    SPC.ForwardToSpectatingMatch();

    //`UTILS.SpawnPawn(self, PC, 2092, 12201, 13171, 15926, 0);

    ProxyActor.ClientConsoleCommand("setreadytoplay");
}