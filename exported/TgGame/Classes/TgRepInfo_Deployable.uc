class TgRepInfo_Deployable extends ReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision);

var int r_nHealthCurrent;
var int r_nHealthMaximum;
var float r_fDeployMaxHealthPCT;
var int r_nDeployableId;
var int r_nUniqueDeployableId;
var float r_fLifespanInitial;
var repnotify float r_fLifespanSync;
var repnotify TgDeployable r_DeployableOwner;
var repnotify TgRepInfo_Player r_InstigatorInfo;
var repnotify TgRepInfo_TaskForce r_TaskforceInfo;
var repnotify bool r_bOwnedByTaskforce;
var bool c_bReceivedOwner;
var bool r_bMinimapOnlyOwnerSee;
var bool r_bInDestroyedState;
var bool c_bShowHUDLifespanTimer;
var Vector r_ApproxLocation;
var TG_HUD_INFO c_HudInfo;
var byte r_bVisibleOnMap[TgMapTeam];
var TgObject.DeployableOverlayIcon r_eDeployableOverlayIcon;
var TgObject.DeployableOverlayState r_eDeployableOverlayState;
var float r_fVisionRange;
var int r_nDeployableOverlayDisplayMask;
var float r_fDeployableOverlayEnemyViewDist;
var float c_fBarragePercent;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_ApproxLocation, r_DeployableOwner, 
        r_InstigatorInfo, r_TaskforceInfo, 
        r_bInDestroyedState, r_bMinimapOnlyOwnerSee, 
        r_bOwnedByTaskforce, r_bVisibleOnMap, 
        r_eDeployableOverlayIcon, r_eDeployableOverlayState, 
        r_fDeployableOverlayEnemyViewDist, r_fLifespanInitial, 
        r_fLifespanSync, r_fVisionRange, 
        r_nDeployableOverlayDisplayMask, r_nHealthCurrent, 
        r_nHealthMaximum;

    // Pos:0x020
    if(bNetInitial && int(Role) == int(ROLE_Authority))
        r_fDeployMaxHealthPCT, r_nDeployableId, 
        r_nUniqueDeployableId;
}

// Export UTgRepInfo_Deployable::execGetTaskForce(FFrame&, void* const)
native function TgRepInfo_TaskForce GetTaskForce();

// Export UTgRepInfo_Deployable::execSetTaskForce(FFrame&, void* const)
native function SetTaskForce(TgRepInfo_TaskForce tf);

// Export UTgRepInfo_Deployable::execGetCurrentLocation(FFrame&, void* const)
native function Vector GetCurrentLocation();

// Export UTgRepInfo_Deployable::execGetCurrentHealth(FFrame&, void* const)
native function int GetCurrentHealth();

// Export UTgRepInfo_Deployable::execGetCurrentMaxHealth(FFrame&, void* const)
native function int GetCurrentMaxHealth();

// Export UTgRepInfo_Deployable::execGetLifespan(FFrame&, void* const)
native function float GetLifespan();

// Export UTgRepInfo_Deployable::execGetMaxLifespan(FFrame&, void* const)
native function float GetMaxLifespan();

// Export UTgRepInfo_Deployable::execUpdateMapVisibility(FFrame&, void* const)
native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);

// Export UTgRepInfo_Deployable::execIsVisibleToAnEnemyTeam(FFrame&, void* const)
native function bool IsVisibleToAnEnemyTeam();

// Export UTgRepInfo_Deployable::execIsVisibleToMapTeam(FFrame&, void* const)
native function bool IsVisibleToMapTeam(TgObject.TgMapTeam MAPTEAM);

// Export UTgRepInfo_Deployable::execIsVisibleToPlayer(FFrame&, void* const)
native function bool IsVisibleToPlayer(TgRepInfo_Player PRI);

// Export UTgRepInfo_Deployable::execIsVisibleToLocalPlayer(FFrame&, void* const)
native function bool IsVisibleToLocalPlayer();

// Export UTgRepInfo_Deployable::execCheckNotifyGroupChanged(FFrame&, void* const)
native function CheckNotifyGroupChanged();

simulated event PostBeginPlay()
{
    local TgRepInfo_Game Game;

    Game = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x60
    if(Game != none)
    {
        Game.AddDRI(self);
    }
    UpdateDeployableLocation();
    SetTimer(0.5000000, true, 'UpdateDeployableLocation');
    //return;    
}

simulated event Destroyed()
{
    local TgRepInfo_Game Game;

    Game = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x60
    if(Game != none)
    {
        Game.RemoveDRI(self);
    }
    // End:0x8F
    if(r_InstigatorInfo != none)
    {
        r_InstigatorInfo.RemoveMinion(self);
    }
    super(Actor).Destroyed();
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x52
    if(VarName == 'r_InstigatorInfo')
    {
        // End:0x46
        if(r_InstigatorInfo != none)
        {
            r_InstigatorInfo.AddMinion(self);
        }
        CheckNotifyGroupChanged();
        return;
    }
    // End:0x8E
    if((VarName == 'r_TaskforceInfo') || VarName == 'r_bOwnedByTaskforce')
    {
        CheckNotifyGroupChanged();
        return;
    }
    // End:0xB1
    if(VarName == 'r_DeployableOwner')
    {
        ReceivedDeployableOwner();
        return;
    }
    // End:0xD2
    if(VarName == 'r_fLifespanSync')
    {
        UpdateLifespanTimer();
    }
    super(Actor).ReplicatedEvent(VarName);
    //return;    
}

simulated function ReceivedDeployableOwner()
{
    // End:0x4B
    if(!c_bReceivedOwner && r_DeployableOwner != none)
    {
        r_DeployableOwner.NotifyGroupChanged();
        c_bReceivedOwner = true;
    }
    //return;    
}

function UpdateDeployableLocation()
{
    // End:0x29
    if(r_DeployableOwner == none)
    {
        r_ApproxLocation = vect(0.0000000, 0.0000000, 0.0000000);        
    }
    else
    {
        r_ApproxLocation = r_DeployableOwner.Location;
    }
    //return;    
}

function StartLifespanTimer(float fTime)
{
    r_fLifespanInitial = fTime;
    SetTimer(r_fLifespanInitial, false, 'LifespanTimer');
    SetTimer(5.0000000, true, 'SyncLifespanTimer');
    SyncLifespanTimer();
    //return;    
}

function SyncLifespanTimer()
{
    r_fLifespanSync = GetRemainingTimeForTimer('LifespanTimer');
    //return;    
}

simulated function UpdateLifespanTimer()
{
    // End:0x53
    if(int(Role) == int(ROLE_SimulatedProxy))
    {
        // End:0x3F
        if(r_fLifespanSync > float(0))
        {
            SetTimer(r_fLifespanSync, false, 'LifespanTimer');            
        }
        else
        {
            ClearTimer('LifespanTimer');
        }
    }
    //return;    
}

simulated function LifespanTimer()
{
    //return;    
}

simulated event SetHUDOverlayDisplayMask(int dodm)
{
    r_nDeployableOverlayDisplayMask = dodm;
    bNetDirty = true;
    //return;    
}

simulated event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi)
{
    r_eDeployableOverlayIcon = doi;
    bNetDirty = true;
    //return;    
}

simulated event SetHUDOverlayState(TgObject.DeployableOverlayState dos)
{
    r_eDeployableOverlayState = dos;
    bNetDirty = true;
    //return;    
}

simulated event SetHUDOverlayEnemyViewDist(float enemyViewDist)
{
    r_fDeployableOverlayEnemyViewDist = enemyViewDist;
    bNetDirty = true;
    //return;    
}

defaultproperties
{
    r_fDeployMaxHealthPCT=1.0000000
    r_fDeployableOverlayEnemyViewDist=1600.0000000
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    NetUpdateFrequency=1.0000000
    BotRankId=10678
}