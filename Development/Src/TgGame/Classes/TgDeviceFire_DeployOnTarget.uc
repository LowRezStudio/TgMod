class TgDeviceFire_DeployOnTarget extends TgDeviceFire
    native(Devices)
    config(Engine);

var Actor m_TargetHit;
var bool m_bDeployAtFeet;

native function bool GetDeployLocationAndRotation(out Vector OutLocation, out Rotator OutRotation);  // Export UTgDeviceFire_DeployOnTarget::execGetDeployLocationAndRotation(FFrame&, void* const)

native function Actor GetDeployableBase();  // Export UTgDeviceFire_DeployOnTarget::execGetDeployableBase(FFrame&, void* const)
