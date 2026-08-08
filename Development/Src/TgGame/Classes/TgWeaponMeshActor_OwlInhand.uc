class TgWeaponMeshActor_OwlInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Owl m_CachedOwl;

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot) { }

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot=0) { }

simulated function bool HasCachedOwl() { }

defaultproperties
{}
