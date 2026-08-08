class TgDeviceFire_DeployOnLocation extends TgDeviceFire
    native(Devices)
    config(Engine);

var Vector m_TargetLocation;

native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);  // Export UTgDeviceFire_DeployOnLocation::execGetDeployLocationAndRotation(FFrame&, void* const)
