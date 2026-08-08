class TgDeploy_BlackHole extends TgDeployable
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

var repnotify float r_fRadiusScale;
var float m_fMaxPullSpeed;
var float m_fMinPullSpeed;
var float m_fDistanceWithMaxSpeed;
var float m_fEventHorizonDistance;
var float m_fInnerRadius;
var array<Actor> m_ActorsInRange;
var TgPawn m_CachedPawnOwner;
var TgRepInfo_TaskForce m_CachedEnemyTaskForce;
var bool r_bPullActive;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusScale;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetDirty) r_bPullActive;
}

native function ApplyPullEffects(TgPawn Target, float DeltaTime);  // Export UTgDeploy_BlackHole::execApplyPullEffects(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event ClearAllTouched() { }

simulated event Destroyed() { }

defaultproperties
{}
