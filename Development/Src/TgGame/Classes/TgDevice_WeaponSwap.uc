class TgDevice_WeaponSwap extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated event bool CanBeCanceled() { }

simulated event bool IsFunctionallyToggleDevice() { }

native function NotifyWeaponSwap(float fSwapTime);  // Export UTgDevice_WeaponSwap::execNotifyWeaponSwap(FFrame&, void* const)

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim) { }

simulated function FiringEndTransition() { }

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_WeaponSwap::execGetMoveSpeedMultiplier(FFrame&, void* const)

state DeviceFiring {}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert[0]=(KeyframeName="V10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetVert[1]=(KeyframeName="V100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetVert[2]=(KeyframeName="V150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftlowx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc150ftnull",Distance=2400.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang150ftnull",Distance=2400.0000000)
    m_nAimAssistPriorityWhileFiring=3
}
