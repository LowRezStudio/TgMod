class TgDeviceForm_HyperBeam extends TgDeviceForm_SpinnerWhileFiring;

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super(TgDeviceForm).Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    PlayTracerEffects(HitLocation);
    //return;    
}

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot = 0)
{
    local TgSpecialFx TracerFX;
    local Vector fireLoc, FireLocToHitLoc;
    local Rotator FireRot;
    local int I;
    local Emitter TracerBeamEmitter;

    // End:0x11C
    if(PawnOwner.IsFirstPerson())
    {
        TracerFX = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGet('Torvald_Ult', 0));
        // End:0x119
        if(TracerFX != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh1P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
        }        
    }
    else
    {
        TracerFX = TgSpecialFx(PawnOwner.m_WeaponMesh.m_WeaponMesh3P.FxGet('Torvald_Ult', 0));
        // End:0x20E
        if(TracerFX != none)
        {
            PawnOwner.m_WeaponMesh.m_WeaponMesh3P.GetSocketWorldLocationAndRotation(TracerFX.c_nmSocket, fireLoc, FireRot);
        }
    }
    // End:0x3FB
    if(TracerFX != none)
    {
        I = 0;
        J0x228:

        // End:0x3FB [Loop If]
        if(I < TracerFX.c_PSCList.Length)
        {
            FireLocToHitLoc = endLocation - fireLoc;
            TracerBeamEmitter = PawnOwner.Spawn(Class'TgGame.TgEmitter', PawnOwner,, fireLoc, Rotator(FireLocToHitLoc),, true);
            TracerFX.SetPSCChannels(TracerBeamEmitter.ParticleSystemComponent);
            TracerBeamEmitter.LifeSpan = 0.5000000;
            TracerBeamEmitter.SetTemplate(TracerFX.c_PSCList[I].c_PSCTemplate, true);
            // End:0x3ED
            if(TracerBeamEmitter.ParticleSystemComponent != none)
            {
                TracerBeamEmitter.ParticleSystemComponent.SetVectorParameter('beamEnd', endLocation);
            }
            I++;
            // [Loop Continue]
            goto J0x228;
        }
    }
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super(TgDeviceForm).StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    SetSpinnersActive(true);
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    SetSpinnersActive(false);
    //return;    
}

function SetSpinnersActive(bool bActive)
{
    super.SetSpinnersActive(bActive);
    SetSpinnersRotationSpeedState(((bActive) ? 2 : 0));
    //return;    
}

defaultproperties
{
    m_SpinnerName="Stones"
}