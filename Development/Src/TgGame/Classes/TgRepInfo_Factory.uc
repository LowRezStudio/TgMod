class TgRepInfo_Factory extends ReplicationInfo
    native(Game)
    hidecategories(Navigation,Movement,Collision)
    config(Engine)
    dependson(TgObject);

enum ReplicatedFactoryState {
    RFS_None,  // 0
    RFS_Vacant,  // 1
    RFS_Spawned,  // 2
    RFS_OwnedByTF1,  // 3
    RFS_OwnedByTF2,  // 4
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

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_FactoryOwner, r_MinimapType, r_TaskforceInfo, r_nFactoryId;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_FactoryState, r_LastSpawnedRepInfo, r_bRespawnVisible, r_bVisibleOnMap, r_fRespawnDelay, r_fRespawnTimer;
}

native function UpdateMapVisibility(TgObject.TgMapTeam MAPTEAM, byte bVisible, float fVisionRange, bool bDetected);  // Export UTgRepInfo_Factory::execUpdateMapVisibility(FFrame&, void* const)

native function bool IsVisibleToLocalPlayer();  // Export UTgRepInfo_Factory::execIsVisibleToLocalPlayer(FFrame&, void* const)

native function float GetRespawnElapsedPercent();  // Export UTgRepInfo_Factory::execGetRespawnElapsedPercent(FFrame&, void* const)

function InitFor(TgActorFactory Factory) { }

simulated function PostBeginPlay() { }

simulated event ReplicatedEvent(name VarName) { }

simulated event Destroyed() { }

simulated function UpdateInWorldIndicators() { }

simulated event StartRespawnTimer(float fSeconds) { }

function UpdateRespawnTimer() { }

simulated event StopRespawnTimer() { }

defaultproperties
{
    r_bVisibleOnMap[0]=1
    r_bVisibleOnMap[1]=1
    r_bVisibleOnMap[2]=1
    TickGroup=TG_DuringAsyncWork
    NetUpdateFrequency=2.0000000
}
