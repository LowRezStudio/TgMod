class TgWeaponMeshActor_OwlInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgPawn_Owl m_CachedOwl;

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot)
{
    local name nmOldName;

    // End:0xE4
    if((((nEquipSlot == 1) && HasCachedOwl()) && !m_CachedOwl.IsInScope()) && m_CachedOwl.IsFirstPerson())
    {
        nmOldName = m_HitWallName;
        m_HitWallName = 'ProjectileExplosionHitWall_B';
        super.PlayInstantHitImpactEffects(HitLocation, bSuccessfulHit, HitActor, HitNormal, FireOrigin, nEquipSlot);
        m_HitWallName = nmOldName;
        return;
    }
    super.PlayInstantHitImpactEffects(HitLocation, bSuccessfulHit, HitActor, HitNormal, FireOrigin, nEquipSlot);
    //return;    
}

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot = 0)
{
    local name nmOldName;

    // End:0xC4
    if((((nEquipSlot == 1) && HasCachedOwl()) && !m_CachedOwl.IsInScope()) && m_CachedOwl.IsFirstPerson())
    {
        nmOldName = m_HitWallName;
        m_TracerName = 'TracerBeamB';
        super.PlayTracerEffects(endLocation, nEquipSlot);
        m_HitWallName = nmOldName;
        return;
    }
    super.PlayTracerEffects(endLocation, nEquipSlot);
    //return;    
}

simulated function bool HasCachedOwl()
{
    // End:0x38
    if(m_CachedOwl == none)
    {
        m_CachedOwl = TgPawn_Owl(m_OwningPawn);
        return m_CachedOwl != none;
    }
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_OwlInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
    m_fTracerLifetime=2.0000000
}