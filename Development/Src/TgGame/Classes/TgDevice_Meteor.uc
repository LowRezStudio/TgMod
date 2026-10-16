class TgDevice_Meteor extends TgDevice
    native(Devices)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function TgPawn_LanePusher GetAnActiveLanePusher();  // Export UTgDevice_Meteor::execGetAnActiveLanePusher(FFrame&, void* const)

native function TgChaosCapturePoint GetAnActiveCapturePoint();  // Export UTgDevice_Meteor::execGetAnActiveCapturePoint(FFrame&, void* const)

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Meteor::execGetTargetingAim(FFrame&, void* const)

native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);  // Export UTgDevice_Meteor::execCanDeviceFireNow(FFrame&, void* const)

defaultproperties
{
    r_OverrideUsesTargetingModeAsFalse=true
}
