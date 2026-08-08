class PComInputLightingEffect extends Object
    native
    config(Game);

struct PComInputLightingPreset {
    var () name PresetName;
    var () InterpCurveLinearColor Curve;
    var () LinearColor ColorTint;
    var () int LoopCount;
    var () float PlaybackRate;
    var () float BlendInTime;
    var () int Priority;
    structdefaultproperties {}
};

struct PComActiveInputLightingPreset {
    var int LoopCount;
    var float CurrentTime;
    var float PlaybackRate;
    structdefaultproperties {}
};

var config bool bAllowLogitechSdk;
var transient bool bLogitechSdkInitialized;
var transient bool bLatchedSystemSettingsSdkAllowed;
var config array<config PComInputLightingPreset> Presets;
var native transient Map_Mirror PresetsMap;
var transient array<PComActiveInputLightingPreset> ActivePresets;
var transient LinearColor BlendFromColor;
var transient float BlendPercent;

native function TryEnableSystem();  // Export UPComInputLightingEffect::execTryEnableSystem(FFrame&, void* const)

native function DisableSystem();  // Export UPComInputLightingEffect::execDisableSystem(FFrame&, void* const)

native function PlayPreset(name InPresetName, optional bool bUseOverrideStartTime=false, optional float OverrideStartTime=0.0000000);  // Export UPComInputLightingEffect::execPlayPreset(FFrame&, void* const)

native function StopPreset(name InPresetName);  // Export UPComInputLightingEffect::execStopPreset(FFrame&, void* const)

native function SetCurrentTime(name InPresetName, float CurrentTime);  // Export UPComInputLightingEffect::execSetCurrentTime(FFrame&, void* const)

native function bool IsLogitechSdkVersionValid();  // Export UPComInputLightingEffect::execIsLogitechSdkVersionValid(FFrame&, void* const)

defaultproperties
{
    BlendFromColor=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
}
