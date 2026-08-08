class TgDeviceFire_HyperBeam extends TgDeviceFire_WorldLOSOnly
    native(ChampGauntlet)
    config(Engine)
    dependson(TgDevice, TgDeviceFire, TgObject);

native function WeaponFireResults CalcActorEncroachmentTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);  // Export UTgDeviceFire_HyperBeam::execCalcActorEncroachmentTargetingFire(FFrame&, void* const)

defaultproperties
{
    m_bUseTargetingEncroachmentActor=true
    m_nTargetingEncroachmentActorOverride=6824
    m_vActorEncroachmentBaseScale=(X=35.0000000,Y=1.0000000,Z=1.0000000)
}
