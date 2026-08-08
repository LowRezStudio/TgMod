class TgDevice_HuntersMark extends TgDevice
    native(ChampTyra)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function float GetConePullbackDistance();  // Export UTgDevice_HuntersMark::execGetConePullbackDistance(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_HuntersMark::execGetTargetingAim(FFrame&, void* const)

native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);  // Export UTgDevice_HuntersMark::execValidateReceivedAim(FFrame&, void* const)

simulated function ImpactInfo CalcWeaponFire(vector StartTrace, vector EndTrace, optional out array<ImpactInfo> ImpactList, optional vector Extent) { }
