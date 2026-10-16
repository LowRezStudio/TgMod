class TgDeviceForm_ShoulderBash extends TgDeviceForm
    native(ChampFlak)
    config(Engine);

var int moveAmount;

native function UpdateTargetingModeLocation(Vector NewLocation, Rotator NewRotation, optional float DistanceScale=1.0000000);  // Export UTgDeviceForm_ShoulderBash::execUpdateTargetingModeLocation(FFrame&, void* const)

native function bool UsesTargetingMode();  // Export UTgDeviceForm_ShoulderBash::execUsesTargetingMode(FFrame&, void* const)

simulated event EnterTargetingMode() { }

defaultproperties
{
    moveAmount=10
}
