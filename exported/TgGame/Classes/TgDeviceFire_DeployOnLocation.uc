class TgDeviceFire_DeployOnLocation extends TgDeviceFire
    native(Devices);

var Vector m_TargetLocation;

// Export UTgDeviceFire_DeployOnLocation::execGetDeployLocationAndRotation(FFrame&, void* const)
native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);
