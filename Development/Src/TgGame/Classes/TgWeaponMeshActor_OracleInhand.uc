class TgWeaponMeshActor_OracleInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

const MAX_BEAM_SEGMENTS = 12;

const BEAM_FADE_START_DIST = 800.0f;

const BEAM_FADE_END_DIST = 3000.0f;

const BEAM_FADE_START_VALUE = 0.0f;

const BEAM_FADE_END_VALUE = 0.7f;

var Actor m_LastRestoreSoulTarget;

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
