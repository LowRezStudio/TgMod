class TgWeaponMeshActor_AstroInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

simulated function Initialize1P(byte EquipPoint, int DeviceID, optional int MeshAsmId1P=-1) { }

simulated function Initialize3P(byte EquipPoint, int DeviceID) { }

simulated function PlayFireFx(int nEquipSlot, int nFireMode) { }

simulated function StopFireEffects(int nEquipSlot) { }

defaultproperties
{}
