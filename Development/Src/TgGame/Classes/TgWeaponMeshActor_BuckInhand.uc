class TgWeaponMeshActor_BuckInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var array<TgAnimBlendByProgressiveReload> m_PawnMeshProgressiveReloadNodes;
var array<TgAnimBlendByProgressiveReload> m_ProgressiveReloadNodes;

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh) { }

simulated function FixUpReferencesToPawnMesh(SkeletalMeshComponent PawnMesh) { }

simulated event PlayReload(int nEquipPoint, float ReloadTime, int AmmoRemainingInClip, optional int ReloadType=0) { }

defaultproperties
{}
