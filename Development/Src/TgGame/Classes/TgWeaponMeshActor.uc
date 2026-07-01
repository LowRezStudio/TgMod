class TgWeaponMeshActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

// Export UTgWeaponMeshActor::execGetMeshAsmIds(FFrame&, void* const)
native static function GetMeshAsmIds(int DeviceID, out int MeshId1P, out int MeshId3P);