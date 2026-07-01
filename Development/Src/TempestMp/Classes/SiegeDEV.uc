class SiegeDEV extends TgGame_Paladins_Siege;

var TgGame m_TgG;
var TgRepInfo_Game GRI;

var int m_nPlayerCount;
var array<TgPlayerController> m_Players;
var array<TgPawn> pendingMountPawns;

var array<TempestProxyActor> m_ProxyActors;

var ATempestLib TempestLib;

var Maps allMaps;
var string nextMap;
var bool isTravelling;

var AServerConfigData ServerConfig;

struct PendingLoginData
{
    var string netAddress;
    var int uniqueAddressId;
    var string playerName;
    var string championName;
    var string team;
    var string password;
    var string horse;
};

var array<PendingLoginData> pendingLogins;

struct ServerParameters {
    var int maxPlayers;
    var string password;
    var string mapName;
    var array<string> allowedChampions;
    var bool allowSpectators;
    var bool totalMayhem;
};

var ServerParameters sOptions;

var TgRepInfo_Player shouldAnimateYourNamePRI;
var PendingLoginData shouldAnimateYourNameData;

public event InitGame(String Options, out String ErrorMessage)
{
    super.InitGame(Options, ErrorMessage);

    TempestLib = self.Spawn(Class'ATempestLib', self);
    TempestLib.SetOwner(self);
    TempestLib.initTimer();

    sOptions.maxPlayers = TempestLib.toInt(ParseOption(Options, "maxplayers"));
    sOptions.password = ParseOption(Options, "serverpassword");
    sOptions.allowSpectators = HasOption(Options, "allowSpectators");
    sOptions.totalMayhem = HasOption(Options, "totalMayhem");
    if(sOptions.maxPlayers == 0)
        sOptions.maxPlayers = 10;

    ParseStringIntoArray(ParseOption(Options, "allowedChampions"), sOptions.allowedChampions, ",", true);
}

event PreLogin(string Options, string Address, const UniqueNetId UniqueId, bool bSupportsAuth, out string ErrorMessage)
{
    local PendingLoginData Data;
    local int i, uniqueAddressId;
    
    super.PreLogin(Options, Address, UniqueId, bSupportsAuth, ErrorMessage);
    
    Address = Repl(Address, ".", "");

    uniqueAddressId = (((TempestLib.toInt(Address) % 1000000) + ((int(WorldInfo.TimeSeconds * 10000) % 10000000) * 1000)) / (Len(Address) * 10)) + Rand(10000);
    uniqueAddressId = int(Abs(uniqueAddressId));
    `log(uniqueAddressId);

    for (i = 0; i < pendingLogins.Length; i++) {
        if (pendingLogins[i].NetAddress == Address) {
            pendingLogins.Remove(i, 1);
        }
    }

    Data.NetAddress = Address;
    Data.uniqueAddressId = uniqueAddressId;
    Data.PlayerName = TempestLib.decodeURLParam(ParseOption(Options, "name"));
    Data.ChampionName = ParseOption(Options, "class");
    Data.Team = ParseOption(Options, "team");
    Data.password = ParseOption(Options, "password");
    Data.horse = ParseOption(Options, "horse");
    
    pendingLogins.AddItem(Data);
    if(Data.team == "spec") {
        PlayerControllerClass = class'TempestSpectatorController';
    } else {
        PlayerControllerClass = class'TgGame.TgPlayerController';
    }
}

public event PostLogin(PlayerController NewPlayer)
{
    local TgPlayerController TgPC;
    local TempestSpectatorController TgSpec;
    local TgPawn_Character TgP;
    local TempestProxyActor ProxyActor;
    local TempestProxyActor ProxyActorS;
    local TgRepInfo_Player TgRPI;
    local TgInventoryManager InvMgr;
    local PendingLoginData Data;
    local ChampionData SelectedChampion;
    local TgDevice_Mount MountDevice;
    local string Address;
    local int i;
    super.PostLogin(NewPlayer);
    
    Address = Repl(NewPlayer.GetPlayerNetworkAddress(), ".", "");
    
    for (i = 0; i < pendingLogins.Length; i++) {
        if (pendingLogins[i].NetAddress == Address) {
            Data = pendingLogins[i];
        }
    }

    TgPC = TgPlayerController(NewPlayer);
    TgRPI = TgRepInfo_Player(NewPlayer.PlayerReplicationInfo);

    ProxyActor = Class'TempestUtils'.static.SetupProxy(TgPC);
    ProxyActor.ServerAddCheats();
    
    TgPC.CheatClass = Class'TgGame.TgBattleCheatManager';
    // End:0x34A
    if(TgPC.CheatManager == none)
    {
        TgPC.CheatManager = new (TgPC) Class'TgGame.TgBattleCheatManager';
        // End:0x314
        if(TgPC.CheatManager != none)
        {
            TgPC.CheatManager.InitCheatManager();
            LogInternal((("TempestProxyActor: CheatManager successfully created and initialized : " @ string(TgPC.CheatManager.Name)) @ ":") @ string(TgPC.CheatManager.Outer.Name));            
        }
        else
        {
            LogInternal("TempestProxyActor: Failed to create CheatManager!");
        }
    }

    m_nPlayerCount++;
    
    if (hasLoginBeenRejected(NewPlayer, Data))
        return;
    
    m_ProxyActors.AddItem(ProxyActor);
    
    for (i = 0; i < sOptions.allowedChampions.Length; i++) {
        ProxyActor.ClientPrecacheClass(sOptions.allowedChampions[i]);
    }

    // the horse
    ProxyActor.ClientTestPrecache(2236, 12612, 0, 0, true);
    ProxyActor.ClientTestPrecache(2236, 12616, 0, 0, true);
    ProxyActor.ClientTestPrecache(2236, 16526, 0, 0, true);

    ProxyActor.ClientTestPrecache(2267, 18656, 18655, 18657, true);

    SelectedChampion = setChampion(Data);
    SelectedChampion.mountId = getHorse(Data);
    SelectedChampion.sprayId = getSpray(Data);

    SelectedChampion = setBelgianYing(Data, SelectedChampion);

    checkShouldAnimateYourName(Data, TgRPI);

    Class'TempestUtils'.static.SetupPRI(m_TgG, TgRPI, Data.uniqueAddressId, Data.playerName, getTeam(Data), SelectedChampion.mountId, getTitle(Data));
    
    TgSpec = TempestSpectatorController(NewPlayer);
    if (TgSpec != none) {
        LogInternal("found TempestSpectatorController");
        TgSpec.ReceivedPlayer();
        TgSpec.PostBeginPlay();
        TgSpec.ForwardToSpectatingMatch();
        ProxyActor.ClientConsoleCommand("setreadytoplay");
        return;
    }
    
    Class'TempestUtils'.static.SpawnPawn(self, TgPC, SelectedChampion.BotId, SelectedChampion.SkinId, SelectedChampion.DeviceSkinId, SelectedChampion.HeadId, SelectedChampion.mountId);
    
    //NewPlayer.Player.SwitchController(TgPC);
    TgP = TgPawn_Character(TgPC.Pawn);

    if (Role == Role_Authority) {
        TgP.m_bAirAccuracyPenalty = false;
        InvMgr = TgInventoryManager(TgP.InvManager);

        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card1), 19, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card2), 20, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card3), 21, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card4), 22, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card5), 5, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.Talent), 25, , true, );
        
        InvMgr.AddDevice(SelectedChampion.sprayId, 17, , true, );
    }

    TgP.PostPawnSetupServer();
    if(sOptions.TotalMayhem) {
        TgRPI.UpdateHealth(TgP.Health, TgP.GetMaxHealth() * 2);
    }

    MountDevice = TgDevice_Mount(TgP.GetDeviceByEqPoint(23));
    // End:0x190
    if(MountDevice != none)
    {
        MountDevice.SetAllowMountServerTimer();
        MountDevice.ClientStartMount();
    }
            
    ProxyActor.ClientConsoleCommand("setreadytoplay");

    setTimer(5, true, 'killcontroller');
    
}

public function Logout(Controller Exiting) {
    local int i;
    super.Logout(Exiting);

    m_nPlayerCount--;
    if(!isTravelling) {
        for (i = 0; i < m_ProxyActors.Length; i++) {
            if (m_ProxyActors[i].Owner == Exiting) {
                m_ProxyActors.Remove(i, 1);
            }
        }
        setTimer(0.25, false, 'removeBots');
    }
}

public event PreBeginPlay() {
    super.PreBeginPlay();
    m_TgG = TgGame(WorldInfo.Game);

    allMaps = new class'Maps';
    allMaps.loadMaps();

    m_nPlayerCount = 0;
}

private function debugKillcam() {
    local TgPlayerController TgPC;
    local TgPawn Pawn;
    GRI.r_bAttackersKillCamEnabled = true;
    GRI.r_bDefendersKillCamEnabled = true;
    `log(string(WorldInfo.IsRecordingTimelapse()) @ string(WorldInfo.IsPlayingTimelapse()));
    `log(GameplayEventsWriter);
    foreach AllActors(class'TgPlayerController', TgPC) {
        if(TgPC.Pawn != none) {
            Pawn = TgPawn(TgPC.Pawn);
            `log("CHECK FOR" @ Pawn.Name);
            TgPC.bForcedTimelapseRequested = true;
            `log(string(TgPC.CanPlayKillCam(false)));
            if((TgPC.r_fServerTimeStamp - Pawn.r_fReconnectTime) < 30.0) {
                `log("TIMESTAMP < 30 IS CAUSING THE FALSE");
            }
            if(GRI == none) {
                `log("GRI NONE IS CAUSING THE FALSE");
            }
            if(!GRI.r_bKillCamEnabled) {
                `log("KILLCAMENABLED IS CAUSING THE FALSE");
            }
            if(GRI.r_bBlockKillCam) {
                `log("BLOCKKILLCAM IS CAUSING THE FALSE");
            }
            if(GRI.r_AttackingTaskForce == none) {
                `log("GRI ATTACKING TASKFORCE NONE IS CAUSING THE FALSE");
            }
            if(!GRI.r_bAttackersKillCamEnabled) {
                `log("GRI ATTACKERS KILLCAM IS CAUSING THE FALSE");
            }
            if(!GRI.r_bDefendersKillCamEnabled) {
                `log("GRI DEFENDERS KILLCAM IS CAUSING THE FALSE");
            }
            if(!(TgPC.m_nKillCamTargetId >= 0)) {
                `log("KILLCAM TARGET ID IS CAUSING THE FALSE");
            }
            if(GRI.r_AttackingTaskForce.GetTeamNum() != TgPC.GetTaskForceNumber()) {
                `log("GET TEAM NUM NONE IS CAUSING THE FALSE");
            }
            `log("");
            `log("");
            `log("");
        } 
    }
}

public function ScoreKill(Controller Killer, Controller Other)
{
    local TgPlayerController TgPCKiller;
    local TgPlayerController TgPCKilled;
    local TgPawn killerPawn;
    local TgPawn killedPawn;
    super.ScoreKill(Killer, Other);

    TgPCKiller = TgPlayerController(Killer);
    TgPCKilled = TgPlayerController(Other);

    killerPawn = TgPawn(TgPCKiller.Pawn);
    KilledPawn = TgPawn(TgPCKilled.Pawn);

    `log("FIRED SCOREKILL" @ killerPawn.Name);
    `log("KILLER PAWNID" @ killerPawn.r_nPawnId);
    `log("KILLER OWNER" @ killerPawn.r_Owner.Name);
    TgPCKilled.SetKillCamTarget(KillerPawn);
    TgPCKilled.ClientSetKillCamTarget(killerPawn.r_nPawnId, killerPawn.r_nPawnId);
    `log("TG PC KILLED" @ TgPCKilled.m_nKillCamTargetId @ TgPCKilled.m_nKillCamTargetBackupId);
    `log("TG PC KILLER" @ TgPCKiller.m_nKillCamTargetId @ TgPCKiller.m_nKillCamTargetBackupId);
    `log("KillCamViewTarget" @ TgPCKilled.GetBestKillCamTarget().Name);
    //TgPCKilled.StartTimelapsePlayback(-7.5000000, -3.0000000, false);
    //TgPCKilled.ControllerPreTimeLapse();
    TgPCKilled.StartTimelapse();
    //KilledPawn.PreTimeLapse(false);
}

public event PostBeginPlay() {
    super.PostBeginPlay();

    m_TgG = TgGame(WorldInfo.Game);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
    isTravelling = false;

    if(Role == Role_Authority) {
        ServerConfig = new class'AServerConfigData';
        ServerConfig.InitializeConfig();
    }
    if(sOptions.TotalMayhem) {
        SetTimer(1, true, 'runTotalMayhem');
        m_fBaseRespawnTime = 1;
        m_fDefenseRespawnIncrease = 0;
        m_fAttackRespawnIncrease = 0;
        m_bCanPurchaseItemsAnywhere = true;
    }

}

private function killcontroller() {
    local TgPlayerController TgPC;
    local TempestSpectatorController TgSC;
    local TgRepInfo_Player TgRPI;
    local Vector CamLoc;
    local Rotator CamRot;

    foreach AllActors(class'TempestSpectatorController', TgSC) {
        TgRPI = TgRepInfo_Player(TgSC.PlayerReplicationInfo);
        LogInternal("Found spectator: " @ TgRPI.PlayerName);

        TgRPI.UpdateSpectatorUI();

        // Destroy old controller — PRI already transferred via SwitchController
        //TgPC.Destroy();

        break;
    }
}

private function removeBots() {
    local TgAIController_BehaviorGod TgAI;
    foreach AllActors(class'TgAIController_BehaviorGod', TgAI) {
        if(TgAI != none) {
            TgAI.Pawn.Suicide();
            TgAI.Pawn.Destroy();
            TgAI.PlayerReplicationInfo.Destroy();
            TgAI.Destroy();
        }
    }
}

public function TaskforceWin(Int nTaskForce, EVictoryType VictoryType) {
    local TgPlayerController TgPC;
    local int rmap;
    local array<MapData> ValidMaps;
    local int i;
    local string Gamemode;
    Gamemode = "Siege";

    super.TaskforceWin(nTaskForce, VictoryType);

    isTravelling = true;

    for(i = 0; i < allMaps.MapDatabase.Length; i++) {
        if(allMaps.MapDatabase[i].MapGamemodes.Find(Gamemode) != INDEX_NONE) {
            ValidMaps.AddItem(allMaps.MapDatabase[i]);
        }
    }

    if(ValidMaps.Length > 0) {
        rmap = rand(ValidMaps.Length);
        nextMap = ValidMaps[rmap].MapName;

        foreach AllActors(class'TgPlayerController', TgPC) {
            TgPC.ClientMessage("The server will soon restart and your game will close.", , 15);
            TgPC.ClientMessage("The next Map will be:" @ ValidMaps[rmap].MapReadableName, , 15);
        }
    } else {
        rmap = rand(allMaps.MapDatabase.Length);
        nextMap = allMaps.MapDatabase[rmap].MapName;

        foreach AllActors(class'TgPlayerController', TgPC) {
            TgPC.ClientMessage("The server will soon restart and your game will close.", , 15);
            TgPC.ClientMessage("The next Map will be:" @ allMaps.MapDatabase[rmap].MapReadableName, , 15);
        }
    }

    SetTimer(6, false, 'proceedEndGame');
}

private event proceedEndGame() {
    local TempestProxyActor ProxyActor;
    foreach m_ProxyActors(ProxyActor) {
        ProxyActor.ClientConsoleCommand("quit");
    }
    if(Role ==  ROLE_Authority) {     
        foreach m_ProxyActors(ProxyActor) {
            m_ProxyActors.RemoveItem(ProxyActor);
        }
        switchMap();
    }
}

private event runTotalMayhem() {
    local TgPlayerController TgPC;
    local TgPawn_Character Pawn;
    foreach AllActors(class'TgPlayerController', TgPC) {
        Pawn = TgPawn_Character(TgPC.Pawn);
        if(TgPC != none && Pawn != none) {
            reduceCooldownAndBoostUltCharge(Pawn);
        }
    }
}

private function reduceCooldownAndBoostUltCharge(TgPawn_Character Pawn) {
    local float ultChargeMount, cdRatio, CD, NewCD, BaseCD;
    ultChargeMount = 2.5f;
    cdRatio = 0.2f;
    if(Pawn.MySpawnGatesAreOpen() && Pawn.ShouldRecharge()) Pawn.SetProperty(2, Pawn.GetEnergy() + ultChargeMount);
    
    if(Pawn.GetDeviceByEqPoint(3).GetCooldownRemaining() > 0) {
        BaseCD = Pawn.GetDeviceByEqPoint(3).GetCooldownTime();
        CD = Pawn.GetDeviceByEqPoint(3).GetCooldownRemaining();

        NewCD = CD - (BaseCD * cdRatio);
        if(NewCD < 0) NewCD = 0;
        Pawn.GetDeviceByEqPoint(3).ResetCooldown(0, NewCD);
    }

    if(Pawn.GetDeviceByEqPoint(4).GetCooldownRemaining() > 0) {
        BaseCD = Pawn.GetDeviceByEqPoint(4).GetCooldownTime();
        CD = Pawn.GetDeviceByEqPoint(4).GetCooldownRemaining();

        NewCD = CD - (BaseCD * cdRatio);
        if(NewCD < 0) NewCD = 0;
        Pawn.GetDeviceByEqPoint(4).ResetCooldown(0, NewCD);
    }

    if(Pawn.GetDeviceByEqPoint(16).GetCooldownRemaining() > 0) {
        BaseCD = Pawn.GetDeviceByEqPoint(16).GetCooldownTime();
        CD = Pawn.GetDeviceByEqPoint(16).GetCooldownRemaining();

        NewCD = CD - (BaseCD * cdRatio);
        if(NewCD < 0) NewCD = 0;
        Pawn.GetDeviceByEqPoint(16).ResetCooldown(0, NewCD);
    }        
}

private function bool hasLoginBeenRejected(PlayerController NewPlayer, PendingLoginData data) {
    if(isTravelling) {
        m_TgG.RejectLogin(NewPlayer.Player, "ff");
        m_nPlayerCount--;
        `log("A player (" $ Data.playerName $ ")" @ "has been forced to disconnect due to: The server is restarting.");
        return true;
    }

    if(sOptions.password != "") {
        if(Data.password != sOptions.password) {
            m_TgG.RejectLogin(NewPlayer.Player, "ff");
            m_nPlayerCount--;
            `log("A player (" $ Data.playerName $ ")" @ "has been forced to disconnect due to: Wrong password.");
            return true;
        }
    }
    /*
    if(!sOptions.allowSpectators && (Data.team == "spec" || Data.team == "spectator")) {
        m_TgG.RejectLogin(NewPlayer.Player, "ff");
        m_nPlayerCount--;
        `log("A player (" $ Data.playerName $ ")" @ "has been forced to disconnect due to: The server doesn't allow spectators.");
        return true;
    }
*/
    if(m_nPlayerCount > maxPlayers) {
        m_TgG.RejectLogin(NewPlayer.Player, "ff");
        m_nPlayerCount--;
        `log("A player (" $ Data.playerName $ ")" @ "has been forced to disconnect due to: The server is full.");
        return true;
    }
    return false;
}

private function ChampionData setChampion(PendingLoginData Data) {
    local int randChamp;
    local string incomingName;
    local ChampionData selectedChampion;
    
    incomingName = Locs(Data.ChampionName);
    
    if (isChampionAllowed(incomingName)) {
        selectedChampion = findChampionByNameOrAlias(incomingName);
        return selectedChampion;
    }
    
    randChamp = Rand(sOptions.allowedChampions.Length);
    selectedChampion = findChampionByNameOrAlias(Locs(sOptions.allowedChampions[randChamp]));
    return selectedChampion;
}

private function bool isChampionAllowed(string championName) {
    local int i, j;
    
    for (i = 0; i < ServerConfig.Champion.Length; i++) {
        if (sOptions.allowedChampions.Find(Locs(ServerConfig.Champion[i].name)) != INDEX_NONE) {
            if (Locs(ServerConfig.Champion[i].name) == championName) {
                return true;
            }
            
            for (j = 0; j < ServerConfig.Champion[i].aliases.Length; j++) {
                if (Locs(ServerConfig.Champion[i].aliases[j]) == championName) {
                    return true;
                }
            }
        }
    }
    return false;
}

private function ChampionData findChampionByNameOrAlias(string championName) {
    local int i, j;
    local ChampionData emptyChampion;
    
    for (i = 0; i < ServerConfig.Champion.Length; i++) {
        if (Locs(ServerConfig.Champion[i].name) == championName) {
            return ServerConfig.Champion[i];
        }
        
        for (j = 0; j < ServerConfig.Champion[i].aliases.Length; j++) {
            if (Locs(ServerConfig.Champion[i].aliases[j]) == championName) {
                return ServerConfig.Champion[i];
            }
        }
    }
    
    return emptyChampion;
}

private function switchMap() {
    ProcessServerTravel(nextMap, true);
    //removeBots();  
}

public function int getTeam(PendingLoginData Data) {
    switch(Data.Team)
    {
        case "1": return 1; break;
        case "2": return 2; break;
        case "spec": return 3; break;
        case "spectator": return 3; break;
    }
    
    return (m_nPlayerCount % 2 == 0) ? 1 : 2;
}

public function int getHorse(PendingLoginData Data) {
    // Special Belgian Treatement
    if(Data.netAddress == "2625572168") return 16526;
    
    switch(Data.horse)
    {
        case "1": return 12616; break;
        case "2": return 12612; break;
    }

    return 12616;
}

public function int getSpray(PendingLoginData Data) {
    // Special Belgian Treatement
    if(Data.netAddress == "2625572168") return 16457; 

    return 15587;
}

public function int getTitle(PendingLoginData Data) {
    // Special Belgian Treatement
    if(Data.netAddress == "2625572168") return 16936; 

    return 0;
}

public function ChampionData setBelgianYing(PendingLoginData Data, ChampionData SelectedChampion) {
    // Special Belgian Treatement
    if(Data.netAddress == "262038383" && (Data.championName == "ying" || Data.championName == "bestwaifu")) {
        SelectedChampion.BotId = 2267;
        SelectedChampion.SkinId = 18656;
        SelectedChampion.DeviceSkinId = 18655;
        SelectedChampion.HeadId = 18657;
    }
    return SelectedChampion;
}

public function checkShouldAnimateYourName(PendingLoginData Data, TgRepInfo_Player PRI) {
    // Special Belgian Treatement
    if(Data.netAddress == "2625572168") {
        shouldAnimateYourNamePRI = PRI;
        shouldAnimateYourNameData = Data;
    }
}

function animateYourName() {
    `log(WorldInfo.TimeSeconds);
    if(shouldAnimateYourNamePRI != none) shouldAnimateYourNamePRI.PlayerName = TempestLib.UpdateAnimatedName(shouldAnimateYourNameData.playerName);
}

public function initServerCheatManager(TgPlayerController TgPC) {
    TgPC.CheatClass = Class'TgBattleCheatManager';
    if(TgPC.CheatManager == none) {
        TgPC.CheatManager = new (TgPC) Class'TgBattleCheatManager';
        if(TgPC.CheatManager != none) {
            TgPC.CheatManager.InitCheatManager();
            `Log((("TempestProxyActor: CheatManager successfully created and initialized : " @ string(TgPC.CheatManager.Name)) @ ":") @ string(TgPC.CheatManager.Outer.Name));                
        } else {
            `Log("TempestProxyActor: Failed to create CheatManager!");
        }
    }
}