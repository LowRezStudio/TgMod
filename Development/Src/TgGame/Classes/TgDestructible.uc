class TgDestructible extends SkeletalMeshActor
    native
    hidecategories(Navigation)
    config(Engine);

var repnotify TgEffectManager r_EffectManager;
var () int r_nMaxHealth;
var () bool m_bDisplayHealth;
var bool m_bDestroyed;
var transient bool m_bInitialized;
var (FogOfWar) bool m_bFogOfWarBlocker;
var (FogOfWar) bool m_bOneDirectional;
var () int m_nPhysicalType;
var () byte m_nTaskForce;
var repnotify int r_nHealth;
var repnotify int r_nActorInstanceId;

replication {
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_EffectManager, r_nActorInstanceId, r_nMaxHealth;
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nHealth;
}

native function bool IsFriendlyWithLocalPawn();  // Export UTgDestructible::execIsFriendlyWithLocalPawn(FFrame&, void* const)

native function ForceNetRelevant();  // Export UTgDestructible::execForceNetRelevant(FFrame&, void* const)

simulated function PostBeginPlay() { }

simulated event ReplicatedEvent(name VarName) { }

event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

simulated function DestroyIt(optional bool bSkipFx) { }

simulated function Destroyed() { }

simulated event bool CanApplyEffects() { }

defaultproperties
{}
