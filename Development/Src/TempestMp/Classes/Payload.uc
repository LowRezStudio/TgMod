class Payload extends TgGame_Paladins_Payload
    config(Game);

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
}

public event PostLogin(PlayerController NewPlayer)
{
    local TgPlayerController TgPC;
    local TempestProxyActor ProxyActor;
    local TgRepInfo_Player TgRPI;
    local TgInventoryManager InvMgr;
    local PendingLoginData Data;
    local ChampionData SelectedChampion;
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

    ProxyActor.ClientTestPrecache(2273, 18656, 18655, 18657, true);

    SelectedChampion = setChampion(Data);
    SelectedChampion.mountId = getHorse(Data);
    SelectedChampion.sprayId = getSpray(Data);

    SelectedChampion = setBelgianYing(Data, SelectedChampion);

    checkShouldAnimateYourName(Data, TgRPI);

    Class'TempestUtils'.static.SetupPRI(m_TgG, TgRPI, Data.uniqueAddressId, Data.playerName, getTeam(Data), SelectedChampion.mountId, getTitle(Data));
    Class'TempestUtils'.static.SpawnPawn(self, TgPC, SelectedChampion.BotId, SelectedChampion.SkinId, SelectedChampion.DeviceSkinId, SelectedChampion.HeadId, SelectedChampion.mountId);
    
    if (Role == Role_Authority) {
        TgPawn(TgPC.Pawn).m_bAirAccuracyPenalty = false;
        InvMgr = TgInventoryManager(TgPawn(TgPC.Pawn).InvManager);

        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card1), 19, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card2), 20, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card3), 21, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card4), 22, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.card5), 5, , true, );
        InvMgr.AddDevice(TgPC.GetDeviceIdByName(SelectedChampion.Talent), 25, , true, );
        
        InvMgr.AddDevice(SelectedChampion.sprayId, 17, , true, );

    }
    
    ProxyActor.ClientConsoleCommand("setreadytoplay");
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
    }

    setTimer(1, true, 'animateYourName');
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
    Gamemode = "Payload";

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
    local TgPawn Pawn;
    foreach AllActors(class'TgPlayerController', TgPC) {
        Pawn = TgPawn(TgPC.Pawn);
        if(TgPC != none && Pawn != none) {
            reduceCooldownAndBoostUltCharge(Pawn);
        }
    }
}

private function reduceCooldownAndBoostUltCharge(TgPawn Pawn) {
    local float ultChargeMount, cdRatio, CD, NewCD;
    ultChargeMount = 2.5f;
    cdRatio = 0.2f;
    if(Pawn.MySpawnGatesAreOpen() && Pawn.ShouldRecharge()) Pawn.SetProperty(2, Pawn.GetEnergy() + ultChargeMount);
    
    if(Pawn.GetDeviceByEqPoint(3).GetCooldownRemaining() > 0) {
        CD = Pawn.GetDeviceByEqPoint(3).GetCooldownRemaining();

        NewCD = CD - (Pawn.GetDeviceByEqPoint(3).GetCooldownTime() * cdRatio);
        if(NewCD < 0) NewCD = 0;
        Pawn.GetDeviceByEqPoint(3).ResetCooldown(0, NewCD);
    }

    if(Pawn.GetDeviceByEqPoint(4).GetCooldownRemaining() > 0) {
        CD = Pawn.GetDeviceByEqPoint(4).GetCooldownRemaining();
        NewCD = CD - (Pawn.GetDeviceByEqPoint(4).GetCooldownTime() * cdRatio);
        if(NewCD < 0) NewCD = 0;
        Pawn.GetDeviceByEqPoint(4).ResetCooldown(0, NewCD);
    }

    if(Pawn.GetDeviceByEqPoint(16).GetCooldownRemaining() > 0) {
        CD = Pawn.GetDeviceByEqPoint(16).GetCooldownRemaining();
        NewCD = CD - (Pawn.GetDeviceByEqPoint(16).GetCooldownTime() * cdRatio);
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

    if(!sOptions.allowSpectators && (Data.team == "spec" || Data.team == "spectator")) {
        m_TgG.RejectLogin(NewPlayer.Player, "ff");
        m_nPlayerCount--;
        `log("A player (" $ Data.playerName $ ")" @ "has been forced to disconnect due to: The server doesn't allow spectators.");
        return true;
    }

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
    if(Data.netAddress == "2625572168" && (Data.championName == "ying" || Data.championName == "bestwaifu")) {
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
    if(shouldAnimateYourNamePRI != none) shouldAnimateYourNamePRI.PlayerName = TempestLib.UpdateAnimatedName(shouldAnimateYourNameData.playerName); // or use original name
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

state GameRunning
{
    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {       
        tg();
        return super.FindPlayerStart(Player, InTeam, incomingName);
    }

    function PointCaptured(int nTaskForce, optional bool bSuppressPointsForCapture)
    {
        super.PointCaptured(nTaskForce, bSuppressPointsForCapture);
    }

    stop;    
}

state AttackDefend
{
    function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
    }

    function float GetPayloadStartingDuration()
    {     
        return super.GetPayloadStartingDuration();
    }

    function float GetOvertimeDuration()
    {       
        return super.GetOvertimeDuration();
    }

    function bool OvertimePreventsPayloadExpiring()
    {       
        return super.OvertimePreventsPayloadExpiring();
    }

    function TgChaosCapturePoint GetCapturePointToSpawnSiegeEngineAt()
    {       
        return super.GetCapturePointToSpawnSiegeEngineAt();
    }

    function NavigationPoint FindPlayerStart(Controller Player, optional byte InTeam, optional string IncomingName)
    {      
        tg1();
        return super.FindPlayerStart(Player, InTeam, incomingName);
    }

    function Tick(float DeltaTime)
    {      
        super.Tick(DeltaTime);
    }
    stop;
}


private function tg() {
    local TgPlayerController TgPC;
        foreach AllActors(class'TgPlayerController', TgPC ) {
            TgPC.ClientMessage("The payload de bite pipi caca prout has spawned");
            `log(TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_nPawnId @ TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_nProfileId);

        }
}

private function tg1() {
    local TgPlayerController TgPC;
        foreach AllActors(class'TgPlayerController', TgPC ) {
            TgPC.ClientMessage("The payload de bite pipi caca prout has spawned 1");
            `log(TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_nPawnId @ TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_nProfileId);
        }
}