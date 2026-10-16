class TgDeviceFire_Cylinder extends TgDeviceFire
    native(Devices)
    config(Engine)
    dependson(TgObject);

native function ImpactInfo CalcAoeFire(Actor DamageInstigator, AimData Aim, out array<ImpactInfo> ImpactList, optional bool bPredicting=false, optional float RewindTime=0.0000000);  // Export UTgDeviceFire_Cylinder::execCalcAoeFire(FFrame&, void* const)
