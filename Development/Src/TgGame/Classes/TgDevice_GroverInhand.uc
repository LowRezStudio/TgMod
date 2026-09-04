class TgDevice_GroverInhand extends TgDevice
    native(ChampGrover)
    hidecategories(Navigation)
    config(Engine);

var int m_nProjectilesRemaining;
var int m_nProjectileCount;
var float m_fMultiProjectileDelay;

simulated function FireNext() { }

state DeviceFiring {}

defaultproperties
{
    m_nProjectileCount=3
    m_fMultiProjectileDelay=0.1000000
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Wide
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
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'HeavyForceFeedback'
    m_ForceFeedbackStopReload=ForceFeedbackWaveform'StandardReload'
}
