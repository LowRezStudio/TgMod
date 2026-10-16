class TgDeploy_GeometryBarrierTank extends TgDeploy_Geometry
    native(ChampBarrierTank)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const IMPASSE_SIDE_WALL_SEGMENTS = 2;

var TgPawn_BarrierTank m_CachedInaraPawn;
var export editinline MeshComponent m_CenterMesh;
var export editinline MeshComponent m_LeftMeshes[2];
var export editinline MeshComponent m_RightMeshes[2];
var int m_WallMeshIDCenter;
var int m_WallMeshIDEndCap;
var repnotify bool r_bGrowthModeActivationSignal;
var bool m_bInGrowthMode;
var bool m_bDidInitialHit;
var repnotify bool r_bEarthenGuardActive;
var repnotify bool r_bHasAlpine;
var float m_fGrowStartTime;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && !bNetInitial) r_bEarthenGuardActive, r_bGrowthModeActivationSignal, r_bHasAlpine;
}

native function SpawnMeshSegments();  // Export UTgDeploy_GeometryBarrierTank::execSpawnMeshSegments(FFrame&, void* const)

native function InitializeMeshSegment(MeshComponent Mesh, float fOffset);  // Export UTgDeploy_GeometryBarrierTank::execInitializeMeshSegment(FFrame&, void* const)

native function SignalGrowthModeStart();  // Export UTgDeploy_GeometryBarrierTank::execSignalGrowthModeStart(FFrame&, void* const)

native function ToggleGrowthMode(bool bTurnOn);  // Export UTgDeploy_GeometryBarrierTank::execToggleGrowthMode(FFrame&, void* const)

native function PushBasedActors();  // Export UTgDeploy_GeometryBarrierTank::execPushBasedActors(FFrame&, void* const)

native function DoInitialHit();  // Export UTgDeploy_GeometryBarrierTank::execDoInitialHit(FFrame&, void* const)

native function PushOverlappingActors(float DeltaSeconds);  // Export UTgDeploy_GeometryBarrierTank::execPushOverlappingActors(FFrame&, void* const)

native function Vector GetSegmentWorldLocation(Vector vLocalLocation);  // Export UTgDeploy_GeometryBarrierTank::execGetSegmentWorldLocation(FFrame&, void* const)

native function bool HasCachedInaraPawn();  // Export UTgDeploy_GeometryBarrierTank::execHasCachedInaraPawn(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event AddBasedPawn(TgPawn basedPawn) { }

event RemoveBasedPawn(TgPawn basedPawn) { }

simulated event ActivateDisplayGroups(name DisplayGroup, bool bActivateIndependent, optional bool bTurnOn=true) { }

simulated function DeployComplete() { }

simulated event DestroyIt(optional bool bSkipFx) { }

defaultproperties
{}
