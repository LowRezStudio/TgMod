class TgWeaponMeshActor_YingInhandProj extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

simulated function InitializeForWeapon(byte EquipPoint, int DeviceID, optional bool bClearEquipPoint=true) { }

simulated function SetLoopingMuzzleEffects(bool bSetActive, optional int nEquipSlot=1) { }

defaultproperties
{}
