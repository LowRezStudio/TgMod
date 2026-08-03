class TgDevice_CassieInhand extends TgDevice
    hidecategories(Navigation);

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_AlternateDevice
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=12.0000000,Y=1.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=15.0000000,Y=7.0000000,Z=-13.0000000)
    m_fAltFireLockOutTime=0.0000000
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.BasicForceFeedback'
}