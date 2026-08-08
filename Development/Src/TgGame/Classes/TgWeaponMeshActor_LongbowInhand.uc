class TgWeaponMeshActor_LongbowInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Longbow m_CachedLongbow;
var bool m_bPlayingPlantedFireSFX;
var bool m_bPlayingUltimateFireSFX;

simulated function bool HasCachedLongbow() { }

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function UsePlantedFireSounds(bool bShouldUse) { }

simulated function UseUltimateFireSounds(bool bShouldUse) { }

defaultproperties
{}
