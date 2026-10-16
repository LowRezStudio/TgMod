class TgDeploy_Bomb extends TgDeployable
    native(Deployable)
    placeable
    hidecategories(Navigation)
    config(Engine);

var float r_fPersistTime;
var () export editinline StaticMeshComponent m_CountdownIndicator;
var transient MaterialInstanceConstant m_CountdownIndicatorMIC;
var repnotify float r_fRadiusScale;

replication {
    if(bNetInitial && int(Role) == int(ENetRole.ROLE_Authority)) r_fPersistTime;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fRadiusScale;
}

simulated event ReplicatedEvent(name VarName) { }

simulated function PostBeginPlay() { }

function OnPersistTimerExpire() { }

simulated function ApplyHit(out array<ImpactInfo> ImpactList) { }

function int GetNumEnemyPlayersInList(out array<ImpactInfo> ImpactList) { }

simulated function Tick(float DeltaSeconds) { }

simulated event DestroyIt(optional bool bSkipFx) { }

event ScaleAbilityRadius() { }

simulated event ScaleAbilityFX() { }

defaultproperties
{}
