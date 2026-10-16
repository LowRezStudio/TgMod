class TgDevice_OwlSidearm extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation);

var float m_fQueueFireTime;
var const float m_fQueueFireTimeThreshold;

// Export UTgDevice_OwlSidearm::execEnterTargetingMode(FFrame&, void* const)
native function EnterTargetingMode();

// Export UTgDevice_OwlSidearm::execCanFireIfLeftMouseDown(FFrame&, void* const)
native function bool CanFireIfLeftMouseDown();

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    // End:0x40
    if(IsFiring())
    {
        m_fQueueFireTime = WorldInfo.TimeSeconds + m_fQueueFireTimeThreshold;
    }
    return false;
    //return ReturnValue;    
}

simulated function StopFire()
{
    // End:0x2E
    if(m_fQueueFireTime > WorldInfo.TimeSeconds)
    {
        return;
    }
    super.StopFire();
    //return;    
}

simulated function bool CanEnterCombat()
{
    return true;
    //return ReturnValue;    
}

simulated function float GetMinAccuracy()
{
    return 1.0000000 - GetCurrentFire().GetCustomValue1();
    //return ReturnValue;    
}

simulated function float GetRecoilMultiplier()
{
    return GetCurrentFire().GetCustomValue2();
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        m_fQueueFireTime = -1.0000000;
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        local TgObject.EDeviceFailType failType;

        // End:0x72
        if(int(Role) < int(ROLE_Authority))
        {
            return (m_fQueueFireTime > WorldInfo.TimeSeconds) && CanDeviceFireNow(CurrentFireMode, Aim, LogDebugInfo(), failType);
        }
        return super.ShouldRefire(FireMode, Aim);
        //return ReturnValue;        
    }
    stop;    
}

defaultproperties
{
    m_fQueueFireTime=-1.0000000
    m_fQueueFireTimeThreshold=0.2500000
    m_bPostFireShouldInterruptStealth=false
    m_bReloadingShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_AccuracySettings=(bUsesAdvancedAccuracy=true,fMaxAccuracy=1.0000000,fMinAccuracy=0.7500000,fAccuracyLossPerShot=0.0500000,fAccuracyGainPerSec=0.5000000,fAccuracyGainDelay=0.1000000)
    m_RecoilSettings=(bUsesRecoil=true,fRecoilReductionPerSec=10.0000000,fRecoilCenterDelay=0.1000000,fRecoilSmoothRate=10.0000000)
}