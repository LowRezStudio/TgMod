class TgDeploy_ShieldFernando extends TgDeploy_Shield
    native(ChampFernando)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var int m_nLargeShieldMeshID;
var export editinline MeshComponent m_SmallMesh;
var export editinline MeshComponent m_LargeMesh;
var repnotify int r_nToweringBarrierHealth;
var repnotify int r_nAegisBonusHealth;
var bool m_bHasHeatTransfer;
var bool m_bHasRattle;
var TgPawn_Fernando m_CachedFernandoOwner;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_nAegisBonusHealth, r_nToweringBarrierHealth;
}

native function ToggleLargeMesh();  // Export UTgDeploy_ShieldFernando::execToggleLargeMesh(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

defaultproperties
{}
