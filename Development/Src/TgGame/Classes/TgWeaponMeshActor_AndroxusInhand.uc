class TgWeaponMeshActor_AndroxusInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var bool m_bHasFinishedBurst;
var int m_nCachedFireMode;

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh) { }

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode) { }

simulated function StopFireEffects(int nEquipSlot) { }

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime) { }

defaultproperties
{}
