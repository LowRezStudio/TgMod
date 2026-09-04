class TgWeaponMeshActor_RuckusInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var export editinline TgMuzzleFlash m_SecondaryMuzzleFlashLight;

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint=true) { }

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function StopFireEffects(int nEquipSlot) { }

simulated function OverrideTracerFireLoc(out Vector fireLoc) { }

defaultproperties
{}
