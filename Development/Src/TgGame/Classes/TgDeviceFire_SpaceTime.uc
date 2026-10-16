class TgDeviceFire_SpaceTime extends TgDeviceFire_WorldLOSOnly
    native(ChampAstro)
    config(Engine)
    dependson(TgDevice, TgDeviceFire, TgObject);

native function WeaponFireResults CalcActorEncroachmentTargetingFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);  // Export UTgDeviceFire_SpaceTime::execCalcActorEncroachmentTargetingFire(FFrame&, void* const)

defaultproperties
{
    m_bUseAccurateEncroachment=true
    m_bUseTargetingEncroachmentActor=true
    m_bEnchroachmentFireLOSCheck=false
    m_nTargetingEncroachmentActorOverride=8086
}
