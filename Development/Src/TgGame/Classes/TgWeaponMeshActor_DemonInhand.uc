class TgWeaponMeshActor_DemonInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Demon m_CachedDemon;
var () float m_fWeaponZoomFOV;
var () float m_fWeaponFOVDefault;
var () float m_fDoFMultiplier;

simulated function bool HasCachedDemon() { }

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate=false) { }

defaultproperties
{}
