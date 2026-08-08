class TgDeploy_Reversal extends TgDeploy_Shield
    native(ChampAndroxus)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var int m_nLargeMeshID;
var export editinline MeshComponent m_SmallMesh;
var export editinline MeshComponent m_LargeMesh;
var repnotify float r_fVengeanceDamage;
var repnotify float r_fAccumulatedDamage;
var repnotify float r_fMinimumDamage;
var TgPawn m_CachedPawnOwner;
var TgDeviceForm_Reversal m_ReversalForm;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fAccumulatedDamage, r_fMinimumDamage, r_fVengeanceDamage;
}

native function MitigateHealthDamage(TgPawn pInstigator, TgEffectDamage Effect, ImpactInfo Impact, out float NewValue, out float fPercReduction);  // Export UTgDeploy_Reversal::execMitigateHealthDamage(FFrame&, void* const)

native function ScaleFXByDamage();  // Export UTgDeploy_Reversal::execScaleFXByDamage(FFrame&, void* const)

native function SendDamageToDevice();  // Export UTgDeploy_Reversal::execSendDamageToDevice(FFrame&, void* const)

native function ToggleLargeMesh();  // Export UTgDeploy_Reversal::execToggleLargeMesh(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

simulated event DestroyIt(optional bool bSkipFx) { }

event TakeDamage(int DamageAmount, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser) { }

defaultproperties
{}
