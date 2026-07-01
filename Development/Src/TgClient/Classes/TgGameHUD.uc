class TgGameHUD extends TgClientHUD
    transient
    native(GameUI)
    config(Game)
    hidecategories(Navigation);

// Export UTgGameHUD::execTestPrecache(FFrame&, void* const)
native exec function TestPrecache(int nBotId, int nSkinId, int nWeaponSkinId, int nHeadId, optional bool bAll = false);

// Export UTgGameHUD::execPrecacheClass(FFrame&, void* const)
native exec function PrecacheClass(string godName, optional string skinName, optional string weaponSkinName);
