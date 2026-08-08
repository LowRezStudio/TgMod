class TgWeaponMeshActor_GauntletInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgSpecialFx m_HyperBeamFX;
var Actor m_LastInhandTarget;

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate=false) { }

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot) { }

simulated function bool GetAccurateBeamTarget(out Vector HitLocation, int nEquipSlot) { }

simulated function PlayFireFx(int nEquipSlot, int nFireMode) { }

simulated function StopFireEffects(int nEquipSlot) { }

simulated function ActivateFireLoopFailed(bool bIsActive) { }

simulated function UpdateFireLoopBeamParams(bool bHasEndPoint, Vector HitLocation, optional int nEquipSlot=1) { }

simulated function SetBeamTangent(Vector HitLocation, optional int nEquipSlot=1) { }

defaultproperties
{}
