class TgDevice_PrincessFSupport extends TgDevice
    native(ChampPrincess)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var TgPawn_Princess m_CachedLian;

native function bool CanFiringBeLocked();  // Export UTgDevice_PrincessFSupport::execCanFiringBeLocked(FFrame&, void* const)

native function bool UsesCachedAim();  // Export UTgDevice_PrincessFSupport::execUsesCachedAim(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_PrincessFSupport::execGetTargetingAim(FFrame&, void* const)

simulated function bool HasCachedLian() { }

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }

defaultproperties
{
    m_bDisableLagCompensation=true
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
}
