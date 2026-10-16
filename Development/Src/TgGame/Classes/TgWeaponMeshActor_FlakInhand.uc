class TgWeaponMeshActor_FlakInhand extends TgWeaponMeshActor
    native(ChampFlak)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot) { }

defaultproperties
{}
