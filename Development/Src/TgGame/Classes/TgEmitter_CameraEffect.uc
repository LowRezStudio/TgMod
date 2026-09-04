class TgEmitter_CameraEffect extends TgEmitter
    native(FX)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgSpecialFx);

var () protected float m_fDistFromCamera;
var () bool m_bShowOnlyIn1P;
var bool m_bIsIn1P;
var bool m_bIsCameraEffectActive;
var array<Fx_Sound> m_SoundList;

function Destroyed() { }

simulated function Activate() { }

simulated function Deactivate() { }

simulated event Reactivate() { }

simulated event SetCameraEffectActive(bool bActive) { }

simulated function SetSoundList(array<Fx_Sound> SoundList) { }

native simulated function PlaySounds();  // Export UTgEmitter_CameraEffect::execPlaySounds(FFrame&, void* const)

native simulated function StopSounds();  // Export UTgEmitter_CameraEffect::execStopSounds(FFrame&, void* const)

native function UpdateLocation(const out Vector CamLoc, const out Rotator CamRot, float CamFOVDeg);  // Export UTgEmitter_CameraEffect::execUpdateLocation(FFrame&, void* const)

defaultproperties
{}
