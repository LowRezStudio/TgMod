class TgWeaponMeshActor_ViktorInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Viktor m_CachedViktor;
var () float m_fWeaponZoomFOV;
var () float m_fWeaponFOVDefault;
var () float m_fDoFMultiplier;
var bool m_bPlayingADSFX;

simulated function Rotator ApplyRotationModifier(Rotator NewRotation) { }

simulated function bool HasCachedViktor() { }

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate=false) { }

simulated function UseADSFireSounds(bool bShouldUse) { }

defaultproperties
{}
