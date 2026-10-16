class TgDeviceForm_Transporter extends TgDeviceForm
    native(ChampKinessa)
    config(Engine)
    dependson(TgDevice, TgObject);

var TgSkeletalMeshActor c_TargetingModeMeshIndicator2;
var TgSpecialFx c_TargetingModeFx2;
var Vector c_TargetingModeFx2Location;
var int c_nTargetingModeFx2Id;

native function InitializeTargetingModeFX();  // Export UTgDeviceForm_Transporter::execInitializeTargetingModeFX(FFrame&, void* const)

native function UpdateTargetingMode2Location(Vector NewLocation, Rotator NewRotation, optional float DistanceScale=1.0000000);  // Export UTgDeviceForm_Transporter::execUpdateTargetingMode2Location(FFrame&, void* const)

native function UpdateTargetingModeStatus(TgDevice.ETargetingModeStatus Status, const out AimData Aim);  // Export UTgDeviceForm_Transporter::execUpdateTargetingModeStatus(FFrame&, void* const)

simulated event EnterTargetingMode() { }

simulated event ExitTargetingMode() { }

simulated function ShowReticle(bool bShow) { }

defaultproperties
{
    c_nTargetingModeFx2Id=7219
}
