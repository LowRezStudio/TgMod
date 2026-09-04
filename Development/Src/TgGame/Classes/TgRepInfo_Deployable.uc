class TgRepInfo_Deployable extends ReplicationInfo
    native(Game)
    nativereplication
    hidecategories(Navigation,Movement,Collision)
    config(Engine)
    dependson(TgObject);

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

replication {
    if(bNetDirty && int(Role) == int(ENetRole.ROLE_Authority)) r_ApproxLocation, r_DeployableOwner, r_InstigatorInfo, r_TaskforceInfo, r_bInDestroyedState, r_bMinimapOnlyOwnerSee, r_bOwnedByTaskforce, r_bVisibleOnMap, r_eDeployableOverlayIcon, r_eDeployableOverlayState, r_fDeployableOverlayEnemyViewDist, r_fLifespanInitial, r_fLifespanSync, r_fVisionRange, r_nDeployableOverlayDisplayMask, r_nHealthCurrent, r_nHealthMaximum;
    if(bNetInitial && int(Role) == int(ENetRole.ROLE_Authority)) r_fDeployMaxHealthPCT, r_nDeployableId, r_nUniqueDeployableId;
}

native function TgRepInfo_TaskForce GetTaskForce();  // Export UTgRepInfo_Deployable::execGetTaskForce(FFrame&, void* const)

native function SetTaskForce(TgRepInfo_TaskForce tf);  // Export UTgRepInfo_Deployable::execSetTaskForce(FFrame&, void* const)

native function Vector GetCurrentLocation();  // Export UTgRepInfo_Deployable::execGetCurrentLocation(FFrame&, void* const)

native function int GetCurrentHealth();  // Export UTgRepInfo_Deployable::execGetCurrentHealth(FFrame&, void* const)

native function int GetCurrentMaxHealth();  // Export UTgRepInfo_Deployable::execGetCurrentMaxHealth(FFrame&, void* const)

native function float GetLifespan();  // Export UTgRepInfo_Deployable::execGetLifespan(FFrame&, void* const)

native function float GetMaxLifespan();  // Export UTgRepInfo_Deployable::execGetMaxLifespan(FFrame&, void* const)

native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);  // Export UTgRepInfo_Deployable::execUpdateMapVisibility(FFrame&, void* const)

native function bool IsVisibleToAnEnemyTeam();  // Export UTgRepInfo_Deployable::execIsVisibleToAnEnemyTeam(FFrame&, void* const)

native function bool IsVisibleToMapTeam(TgObject.TgMapTeam MAPTEAM);  // Export UTgRepInfo_Deployable::execIsVisibleToMapTeam(FFrame&, void* const)

native function bool IsVisibleToPlayer(TgRepInfo_Player PRI);  // Export UTgRepInfo_Deployable::execIsVisibleToPlayer(FFrame&, void* const)

native function bool IsVisibleToLocalPlayer();  // Export UTgRepInfo_Deployable::execIsVisibleToLocalPlayer(FFrame&, void* const)

native function CheckNotifyGroupChanged();  // Export UTgRepInfo_Deployable::execCheckNotifyGroupChanged(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated event Destroyed() { }

simulated event ReplicatedEvent(name VarName) { }

simulated function ReceivedDeployableOwner() { }

function UpdateDeployableLocation() { }

function StartLifespanTimer(float fTime) { }

function SyncLifespanTimer() { }

simulated function UpdateLifespanTimer() { }

simulated function LifespanTimer() { }

simulated event SetHUDOverlayDisplayMask(int dodm) { }

simulated event SetHUDOverlayIcon(TgObject.DeployableOverlayIcon doi) { }

simulated event SetHUDOverlayState(TgObject.DeployableOverlayState dos) { }

simulated event SetHUDOverlayEnemyViewDist(float enemyViewDist) { }

defaultproperties
{
    r_fDeployMaxHealthPCT=1.0000000
    r_fDeployableOverlayEnemyViewDist=1600.0000000
    TickGroup=TG_DuringAsyncWork
    NetUpdateFrequency=1.0000000
    BotRankId=10678
}
