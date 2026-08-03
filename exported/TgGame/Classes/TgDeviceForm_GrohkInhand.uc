class TgDeviceForm_GrohkInhand extends TgDeviceForm_ArcingBeam;

var TgSkelCon_Spinner m_SpinnerSkelControl;

function SetBeamFXForHit(bool DidHit)
{
    local float beamImpact, beamAlpha;
    local editinline array<editinline ParticleSystemComponent> FireLoopParticles;
    local editinline ParticleSystemComponent Particle;

    beamImpact = ((DidHit) ? 6.0000000 : 2.0000000);
    beamAlpha = ((DidHit) ? 1.0000000 : 0.2000000);
    // End:0x134
    if((PawnOwner != none) && PawnOwner.m_WeaponMesh != none)
    {
        PawnOwner.m_WeaponMesh.GetAllFireLoopParticleSystemComponents(FireLoopParticles);
        // End:0x133
        foreach FireLoopParticles(Particle)
        {
            Particle.SetFloatParameter('beamImpact', beamImpact);
            Particle.SetFloatParameter('beamAlpha', beamAlpha);            
        }        
    }
    //return;    
}

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp)
{
    super(TgDeviceForm).Cache1PAnimNodes(SkelComp);
    m_SpinnerSkelControl = none;
    // End:0x55
    if((SkelComp == none) || SkelComp.Animations == none)
    {
        return;
    }
    m_SpinnerSkelControl = TgSkelCon_Spinner(SkelComp.FindSkelControl('Spinner'));
    //return;    
}

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    // End:0x60
    if(m_SpinnerSkelControl != none)
    {
        m_SpinnerSkelControl.Spin(false);
    }
    //return;    
}

event StopFire(int nFireModeNum)
{
    super.StopFire(nFireModeNum);
    // End:0x42
    if(m_SpinnerSkelControl != none)
    {
        m_SpinnerSkelControl.Spin(true);
    }
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super(TgDeviceForm).Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    SetBeamFXForHit(bSuccessfulHit);
    //return;    
}
