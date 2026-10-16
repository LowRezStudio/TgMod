class TgWeaponMeshActor_FlakInhand extends TgWeaponMeshActor
    native(ChampFlak)
    notplaceable
    hidecategories(Navigation);

simulated function PlayInstantHitImpactEffects(Vector HitLocation, bool bSuccessfulHit, Actor HitActor, Vector HitNormal, Vector FireOrigin, int nEquipSlot)
{
    local TgSpecialFx ImpactFx;
    local TgPawn HitPawn;
    local TraceHitInfo HitInfo;
    local float DistanceToHit, DecalRotation;

    // End:0x121
    if(bSuccessfulHit)
    {
        HitPawn = TgPawn(HitActor);
        // End:0xC1
        if((HitPawn != none) && HitPawn.IsGod())
        {
            HitPawn.CheckHitInfo(HitInfo, HitPawn.Mesh, Normal(HitLocation - FireOrigin), HitLocation);
        }
        ImpactFx = GetMeshFx(m_HitTargetName, nEquipSlot);
        // End:0x11E
        if(ImpactFx != none)
        {
            ImpactFx.PlaySoundAt(HitLocation);
        }        
    }
    else
    {
        // End:0x274
        if((HitActor != none) && HitActor.bWorldGeometry)
        {
            ImpactFx = GetMeshFx(m_HitWallName, nEquipSlot);
            // End:0x274
            if(ImpactFx != none)
            {
                DecalRotation = ImpactFx.CalculateOrientedDecalRotation(HitLocation, HitNormal, Normal(HitLocation - FireOrigin));
                DistanceToHit = VSize(HitLocation - FireOrigin);
                ImpactFx.SpawnDecalAt(HitLocation, -HitNormal, DecalRotation, DistanceToHit / (40.0000000 * float(16)));
                ImpactFx.PlaySoundAt(HitLocation);
            }
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_FlakInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}