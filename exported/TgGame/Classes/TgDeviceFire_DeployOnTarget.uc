class TgDeviceFire_DeployOnTarget extends TgDeviceFire
    native(Devices);

var Actor m_TargetHit;
var bool m_bDeployAtFeet;

// Export UTgDeviceFire_DeployOnTarget::execGetDeployLocationAndRotation(FFrame&, void* const)
native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);

// Export UTgDeviceFire_DeployOnTarget::execGetDeployableBase(FFrame&, void* const)
native function Actor GetDeployableBase();
