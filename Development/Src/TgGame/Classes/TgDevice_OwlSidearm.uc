class TgDevice_OwlSidearm extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var float m_fQueueFireTime;
var const float m_fQueueFireTimeThreshold;

native function EnterTargetingMode();  // Export UTgDevice_OwlSidearm::execEnterTargetingMode(FFrame&, void* const)

native function bool CanFireIfLeftMouseDown();  // Export UTgDevice_OwlSidearm::execCanFireIfLeftMouseDown(FFrame&, void* const)

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController) { }

simulated function StopFire(byte FireModeNum) { }

simulated function bool CanEnterCombat() { }

simulated function float GetMinAccuracy() { }

simulated function float GetRecoilMultiplier() { }

state DeviceFiring {}

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
