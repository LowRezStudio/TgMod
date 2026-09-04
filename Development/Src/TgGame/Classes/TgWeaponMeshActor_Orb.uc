class TgWeaponMeshActor_Orb extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var () float m_fFireGlowFadeTime;
var float m_fRemainingGlowFadeTime;

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function StopFireEffects(int nEquipSlot) { }

simulated function Tick(float DeltaTime) { }

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot) { }

defaultproperties
{}
