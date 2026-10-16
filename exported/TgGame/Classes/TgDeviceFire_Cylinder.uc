class TgDeviceFire_Cylinder extends TgDeviceFire
    native(Devices);

// Export UTgDeviceFire_Cylinder::execCalcAoeFire(FFrame&, void* const)
native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting = false, optional float RewindTime = 0.0000000);
