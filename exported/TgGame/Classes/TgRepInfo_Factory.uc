class TgRepInfo_Factory extends ReplicationInfo
    native(Game)
    hidecategories(Navigation,Movement,Collision);

enum ReplicatedFactoryState
{
    RFS_None,                       // 0
    RFS_Vacant,                     // 1
    RFS_Spawned,                    // 2
    RFS_OwnedByTF1,                 // 3
    RFS_OwnedByTF2,                 // 4
    RFS_MAX                         // 5
};

var TgRepInfo_Factory.ReplicatedFactoryState s_FactoryState;
var TgRepInfo_Factory.ReplicatedFactoryState r_FactoryState[TgMapTeam];
var byte r_bVisibleOnMap[TgMapTeam];
var byte r_bRespawnVisible[TgMapTeam];
var TgObject.MinimapFactoryType r_MinimapType;
var repnotify TgActorFactory r_FactoryOwner;
var repnotify TgRepInfo_TaskForce r_TaskforceInfo;
var int r_nFactoryId;
var ReplicationInfo r_LastSpawnedRepInfo;
var repnotify float r_fRespawnDelay;
var repnotify float r_fRespawnTimer;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetInitial)
        r_FactoryOwner, r_MinimapType, 
        r_TaskforceInfo, r_nFactoryId;

    // Pos:0x020
    if(int(Role) == int(ROLE_Authority))
        r_FactoryState, r_LastSpawnedRepInfo, 
        r_bRespawnVisible, r_bVisibleOnMap, 
        r_fRespawnDelay, r_fRespawnTimer;
}

// Export UTgRepInfo_Factory::execUpdateMapVisibility(FFrame&, void* const)
native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);

// Export UTgRepInfo_Factory::execIsVisibleToLocalPlayer(FFrame&, void* const)
native function bool IsVisibleToLocalPlayer();

// Export UTgRepInfo_Factory::execGetRespawnElapsedPercent(FFrame&, void* const)
native function float GetRespawnElapsedPercent();

function InitFor(TgActorFactory Factory)
{
    local TgRepInfo_Game Game;

    Game = TgRepInfo_Game(WorldInfo.GRI);
    // End:0xBC
    if(Game != none)
    {
        r_TaskforceInfo = Game.GetTaskForce(int(Factory.s_nTaskForce), true);
        // End:0xBC
        if(r_TaskforceInfo != none)
        {
            r_TaskforceInfo.m_Factories.AddItem(self);
        }
    }
    r_MinimapType = Factory.m_MinimapType;
    r_nFactoryId = Factory.s_nFactoryId;
    r_FactoryOwner = Factory;
    //return;    
}

simulated function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    // End:0x46
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        SetTimer(0.5000000, true, 'UpdateInWorldIndicators');
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x4E
    if(VarName == 'r_TaskforceInfo')
    {
        // End:0x49
        if(r_TaskforceInfo != none)
        {
            r_TaskforceInfo.m_Factories.AddItem(self);
        }
        return;        
    }
    else
    {
        // End:0xAA
        if(VarName == 'r_FactoryOwner')
        {
            // End:0xA7
            if(r_FactoryOwner != none)
            {
                r_FactoryOwner.m_FRI = self;
                SetTimer(0.5000000, true, 'UpdateInWorldIndicators');
            }            
        }
        else
        {
            // End:0xF2
            if(VarName == 'r_fRespawnTimer')
            {
                // End:0xE8
                if(r_fRespawnTimer > float(0))
                {
                    StartRespawnTimer(r_fRespawnTimer);                    
                }
                else
                {
                    StopRespawnTimer();
                }
            }
        }
    }
    super(Actor).ReplicatedEvent(VarName);
    //return;    
}

simulated event Destroyed()
{
    // End:0x32
    if(r_TaskforceInfo != none)
    {
        r_TaskforceInfo.m_Factories.RemoveItem(self);
    }
    super(Actor).Destroyed();
    //return;    
}

simulated function UpdateInWorldIndicators()
{
    local TgPlayerController TgPC;
    local int LocalTeamIdx;
    local TgRepInfo_Player PRI;

    LocalTeamIdx = -1;
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0xE0
    if(TgPC != none)
    {
        PRI = TgRepInfo_Player(TgPC.PlayerReplicationInfo);
        // End:0xE0
        if((PRI != none) && PRI.r_TaskForce != none)
        {
            LocalTeamIdx = int(PRI.r_TaskForce.r_MapTeam);
        }
    }
    // End:0xF5
    if(LocalTeamIdx == -1)
    {
        return;
    }
    // End:0x292
    if(false)
    {
        // End:0x292
        if((((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && r_FactoryOwner != none) && r_FactoryOwner.m_WorldIconSprite != none) && r_FactoryOwner.m_WorldIconSprite.Sprite != none)
        {
            TgPC = TgPlayerController(GetALocalPlayerController());
            // End:0x292
            if(TgPC != none)
            {
                LocalTeamIdx = int(TgRepInfo_Player(TgPC.PlayerReplicationInfo).r_TaskForce.r_MapTeam);
                r_FactoryOwner.m_WorldIconSprite.SetHidden((int(r_FactoryState[LocalTeamIdx]) != int(2)) || !TgPC.m_bDetailedViewEnabled);
            }
        }
    }
    // End:0x34A
    if(TgBotFactory(r_FactoryOwner) != none)
    {
        // End:0x31D
        if((int(r_FactoryState[LocalTeamIdx]) == int(1)) && int(r_bRespawnVisible[LocalTeamIdx]) != int(0))
        {
            TgBotFactory(r_FactoryOwner).UpdateRespawnTimeIndicator(GetRespawnElapsedPercent());            
        }
        else
        {
            TgBotFactory(r_FactoryOwner).UpdateRespawnTimeIndicator(0.0000000);
        }
    }
    //return;    
}

simulated event StartRespawnTimer(float fSeconds)
{
    // End:0x4D
    if(int(Role) == int(ROLE_Authority))
    {
        r_fRespawnDelay = fSeconds;
        r_fRespawnTimer = fSeconds;
        SetTimer(5.0000000, true, 'UpdateRespawnTimer');
    }
    SetTimer(fSeconds, false, 'StopRespawnTimer');
    //return;    
}

function UpdateRespawnTimer()
{
    r_fRespawnTimer = GetRemainingTimeForTimer('StopRespawnTimer');
    //return;    
}

simulated event StopRespawnTimer()
{
    ClearTimer('UpdateRespawnTimer');
    ClearTimer('StopRespawnTimer');
    //return;    
}

defaultproperties
{
    r_bVisibleOnMap[0]=1
    r_bVisibleOnMap[1]=1
    r_bVisibleOnMap[2]=1
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    NetUpdateFrequency=2.0000000
}