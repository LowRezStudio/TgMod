class TgDeviceFire_RepulsorField extends TgDeviceFire
    native(ChampRuckus);

// Export UTgDeviceFire_RepulsorField::execGetDamageRadius(FFrame&, void* const)
native function float GetDamageRadius();

// Export UTgDeviceFire_RepulsorField::execCalcWeaponModeFire(FFrame&, void* const)
native function WeaponFireResults CalcWeaponModeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional bool bNoBodyShotCheck = false, optional float RewindTime = 0.0000000, const optional out array<ImpactToValidate> ImpactsToValidate);
