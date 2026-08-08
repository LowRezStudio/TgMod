class TmSiege extends TgGame_Paladins_Siege;

var transient TgGame TgG;
var transient TgRepInfo_Game GRI;

struct transient IncomingLoginData
{
    var string NetAddress;
    var int UniqueId;
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
    var array<string> ChampionsToCache;
};

var transient array<IncomingLoginData> IncomingLogins;
var transient ServerParameters ServerOptions;

public event PostLogin(PlayerController NewPlayer)
{
    local TgPlayerController TgPC;
    local TmProxyActor ProxyActor;
    local TgSpectatorController TgSC;
    local TgPawn_Character TgP;
    local TgRepInfo_Player TgRPI;
    local TgInventoryManager InvMgr;
    local TgDevice_Mount MountDevice;
    local string Address;
    local int i;
    super.PostLogin(NewPlayer);
    TgPC = TgPlayerController(NewPlayer);
    TgRPI = TgRepInfo_Player(NewPlayer.PlayerReplicationInfo);

    ProxyActor = Class'Utils'.static.SetupProxy(TgPC);
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

    Class'Utils'.static.SetupPRI(TgG, TgRPI, 573885, "beboutom", 1, 0);
    Class'Utils'.static.SpawnPawn(self, TgPC, 2092, 12201, 13171, 15926, 0);
    
    TgP = TgPawn_Character(TgPC.Pawn);

    TgP.PostPawnSetupServer();

    MountDevice = TgDevice_Mount(TgP.GetDeviceByEqPoint(23));
    // End:0x190
    if(MountDevice != none)
    {
        MountDevice.SetAllowMountServerTimer();
        MountDevice.ClientStartMount();
    }
            
    ProxyActor.ClientConsoleCommand("setreadytoplay");


    }

public event PostBeginPlay()
{
    super.PostBeginPlay();
    TgG = TgGame(WorldInfo.Game);
    GRI = TgRepInfo_Game(WorldInfo.GRI);
}