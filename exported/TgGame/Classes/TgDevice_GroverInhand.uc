class TgDevice_GroverInhand extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation);

var int m_nProjectilesRemaining;
var int m_nProjectileCount;
var float m_fMultiProjectileDelay;

simulated function FireNext()
{
    local TgPawn TgP;
    local Projectile Proj;

    TgP = TgPawn(Owner);
    // End:0x105
    if(TgP != none)
    {
        // End:0x105
        if(m_nProjectilesRemaining > 0)
        {
            Proj = ProjectileFire();
            // End:0xA9
            if((Proj != none) && TgProjectile(Proj) != none)
            {
                TgP.ProjectileOnFire(TgProjectile(Proj));
            }
            // End:0xDD
            if(TgProjectile(Proj) != none)
            {
                UpdateActiveProjectiles(TgProjectile(Proj));
            }
            // End:0x105
            if(--m_nProjectilesRemaining > 0)
            {
                SetTimer(m_fMultiProjectileDelay, false, 'FireNext');
            }
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x6A
        if(m_nProjectileCount > 0)
        {
            ClearTimer('FireNext');
            m_nProjectilesRemaining += (m_nProjectileCount - 1);
            // End:0x6A
            if(m_nProjectilesRemaining > 1)
            {
                SetTimer(m_fMultiProjectileDelay, false, 'FireNext');
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nProjectileCount=3
    m_fMultiProjectileDelay=0.1000000
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Wide
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=12.0000000,Y=1.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=15.0000000,Y=1.0000000,Z=-9.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.HeavyForceFeedback'
    m_ForceFeedbackStopReload=ForceFeedbackWaveform'gp_forcefeedback.StandardReload'
}