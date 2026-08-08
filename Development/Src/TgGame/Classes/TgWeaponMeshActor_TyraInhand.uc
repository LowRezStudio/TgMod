class TgWeaponMeshActor_TyraInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Tyra m_CachedTyra;
var () float m_fWeaponZoomFOV;
var () float m_fWeaponFOVDefault;
var () float m_fDoFMultiplier;

simulated function bool HasCachedTyra() { }

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate=false) { }

defaultproperties
{}
