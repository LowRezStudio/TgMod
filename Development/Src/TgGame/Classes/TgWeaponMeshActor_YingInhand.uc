class TgWeaponMeshActor_YingInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool m_bHasFinishedBurst;

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint=true) { }

simulated function bool GetSimulatedBeamTarget(out Vector HitLocation, optional int nEquipSlot) { }

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime) { }

simulated function EndYingLoopingBeam() { }

defaultproperties
{}
