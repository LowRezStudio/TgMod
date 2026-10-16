class TgDeviceForm_SpaceTime extends TgDeviceForm;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    PlayBeamEffect(true);
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    PlayBeamEffect(false);
    //return;    
}

simulated function PlayBeamEffect(bool bUseBuildupBeam)
{
    local TgPawn_Astro pAstro;
    local Vector AimVector, endLocation;
    local TgSpecialFx pBuildupFX;
    local Emitter TracerBeamEmitter;
    local int I;

    pAstro = TgPawn_Astro(PawnOwner);
    // End:0xB9
    if(pAstro != none)
    {
        // End:0x8F
        if(pAstro.IsLocallyControlled())
        {
            AimVector = Vector(pAstro.Controller.Rotation);            
        }
        else
        {
            AimVector = Vector(pAstro.r_mUltimateAimRotation);
        }
    }
    // End:0x132
    if(bUseBuildupBeam)
    {
        pBuildupFX = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGet('Astro_Ult_Buildup', 0));        
    }
    else
    {
        pBuildupFX = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGet('Astro_Ult', 0));
    }
    // End:0x3B7
    if(pBuildupFX != none)
    {
        I = 0;
        J0x1B5:

        // End:0x3B7 [Loop If]
        if(I < pBuildupFX.c_PSCList.Length)
        {
            TracerBeamEmitter = PawnOwner.Spawn(Class'TgGame.TgEmitter', PawnOwner,, PawnOwner.Location, Rotator(AimVector),, true);
            pBuildupFX.SetPSCChannels(TracerBeamEmitter.ParticleSystemComponent);
            TracerBeamEmitter.SetTemplate(pBuildupFX.c_PSCList[I].c_PSCTemplate, true);
            endLocation = AimVector * ModeDatas[0].c_fMaxRange;
            endLocation += PawnOwner.Location;
            // End:0x3A9
            if(TracerBeamEmitter.ParticleSystemComponent != none)
            {
                TracerBeamEmitter.ParticleSystemComponent.SetVectorParameter('beamEnd', endLocation);
            }
            I++;
            // [Loop Continue]
            goto J0x1B5;
        }
    }
    //return;    
}
