class TgEmitter_CameraEffect_DamageBase extends TgEmitter_CameraEffect
    abstract
    native(FX)
    hidecategories(Navigation)
    config(Engine);

enum EDamageEffectScreenLocation {
    DESL_Right,  // 0
    DESL_TopRight,  // 1
    DESL_Top,  // 2
    DESL_TopLeft,  // 3
    DESL_Left,  // 4
    DESL_BottomLeft,  // 5
    DESL_Bottom,  // 6
    DESL_BottomRight,  // 7
};

var const TgEmitter_CameraEffect_DamageBase.EDamageEffectScreenLocation ScreenLocation;

function SetDamageIntensity(float fDamageIntensity, bool bCritical) { }

simulated function Activate() { }

native function UpdateLocation(const out Vector CamLoc, const out Rotator CamRot, float CamFOVDeg);  // Export UTgEmitter_CameraEffect_DamageBase::execUpdateLocation(FFrame&, void* const)

defaultproperties
{}
