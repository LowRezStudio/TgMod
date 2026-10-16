class TgDevice_AndroxusInhand extends TgDevice
    native(ChampAndroxus)
    hidecategories(Navigation);

struct native BurstShotAmmoInfo
{
    var int ClientRequestId;
    var byte nShotsRemaining;
    var bool bFirstInBurst;

    structdefaultproperties
    {
        ClientRequestId=0
        nShotsRemaining=0
        bFirstInBurst=false
    }
};

var bool m_bWantsAltFire;
var bool m_bFirstShotInBurst;
var bool m_bApplyLiftOff;
var int m_nShotsRemaining;
var array<BurstShotAmmoInfo> s_BurstShotAmmoQueue;

// Export UTgDevice_AndroxusInhand::execCanReload(FFrame&, void* const)
native function bool CanReload(optional bool bIsAutoReload = false);

// Export UTgDevice_AndroxusInhand::execGetAccuracy(FFrame&, void* const)
native function float GetAccuracy(optional int nMode = -1);

// Export UTgDevice_AndroxusInhand::execGetShotSpreadTendencyCurvesSet(FFrame&, void* const)
native function TgGameplayCurvesSet GetShotSpreadTendencyCurvesSet();

reliable server function ServerAltUse(bool bEnable)
{
    //return;    
}

simulated event SetAltFireSecondModeNow(bool bEnable)
{
    m_bWantsAltFire = bEnable;
    //return;    
}

simulated function FireAmmunition()
{
    local TgPawn_Androxus androxus;

    super.FireAmmunition();
    // End:0x84
    if(m_bApplyLiftOff)
    {
        androxus = TgPawn_Androxus(Instigator);
        // End:0x84
        if(androxus != none)
        {
            // End:0x84
            if((int(CurrentFireMode) == int(0)) || m_bFirstShotInBurst)
            {
                androxus.ApplyLiftOff();
            }
        }
    }
    m_nShotsRemaining = Max(m_nShotsRemaining - 1, 0);
    m_bFirstShotInBurst = false;
    //return;    
}

simulated function UpdateDesiredFireMode()
{
    // End:0x73
    if(m_bWantsAltFire || m_nShotsRemaining > 0)
    {
        // End:0x51
        if(m_nShotsRemaining == 0)
        {
            m_nShotsRemaining = Min(3, GetCurrentAmmoAmount());
            m_bFirstShotInBurst = true;
        }
        m_nDesiredFireMode = ((m_nShotsRemaining > 1) ? 2 : 1);        
    }
    else
    {
        m_nShotsRemaining = 0;
        m_nDesiredFireMode = 0;
    }
    //return;    
}

reliable server function ServerUpdateBurstShotsRemaining(byte nShotsRemaining, bool bFirstInBurst, int nClientRequestId)
{
    local BurstShotAmmoInfo AmmoInfo;

    // End:0x19
    if(m_CachedFireRequestId >= nClientRequestId)
    {
        return;
    }
    // End:0x37
    if(s_BurstShotAmmoQueue.Length > 32)
    {
        s_BurstShotAmmoQueue.Remove(0, 1);
    }
    AmmoInfo.ClientRequestId = nClientRequestId;
    AmmoInfo.nShotsRemaining = nShotsRemaining;
    AmmoInfo.bFirstInBurst = bFirstInBurst;
    s_BurstShotAmmoQueue.AddItem(AmmoInfo);
    //return;    
}

simulated function CallServerStartFire(AimData Aim, optional bool bPendingUpdate)
{
    // End:0x4E
    if(!bPendingDelete && int(m_nDesiredFireMode) > int(0))
    {
        ServerUpdateBurstShotsRemaining(byte(m_nShotsRemaining), m_bFirstShotInBurst, m_CachedFireRequestId);
    }
    super.CallServerStartFire(Aim);
    //return;    
}

simulated function CallServerRestartFireLoop(AimData Aim)
{
    // End:0x3C
    if(int(m_nDesiredFireMode) > int(0))
    {
        ServerUpdateBurstShotsRemaining(byte(m_nShotsRemaining), m_bFirstShotInBurst, m_CachedFireRequestId);
    }
    super.CallServerRestartFireLoop(Aim);
    //return;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    local float totalBurstTime;

    // End:0x36
    if(nDeviceModeNum == 0)
    {
        super.HandleDeviceFormStartFire(nDeviceModeNum, fRefireTime, Aim);
        return;
    }
    totalBurstTime = GetEstimatedTotalBurstTime(m_nShotsRemaining);
    TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, nDeviceModeNum, totalBurstTime, Aim.HitActor, GetCurrentAmmoAmount());
    // End:0x122
    if(c_DeviceForm != none)
    {
        c_DeviceForm.StartFire(nDeviceModeNum, totalBurstTime, Aim.HitActor, GetCurrentAmmoAmount());
    }
    //return;    
}

simulated function float GetEstimatedTotalBurstTime(int nShotsRemaining)
{
    return (FMax(0.0000000, float(nShotsRemaining - 1)) * (GetShortBulletRefireTime())) + (GetLongBulletRefireTime());
    //return ReturnValue;    
}

simulated function float GetLongBulletRefireTime()
{
    return GetRefireTime(1);
    //return ReturnValue;    
}

simulated function float GetShortBulletRefireTime()
{
    return GetRefireTime(2);
    //return ReturnValue;    
}

state DeviceFiring
{
    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        local TgObject.EDeviceFailType failType;
        local bool ret;

        ret = CanDeviceFireNow(CurrentFireMode, Aim, LogDebugInfo(), failType);
        return (super.ShouldRefire(FireMode, Aim) || int(failType) == int(15)) || ((((Instigator != none) && Instigator.IsLocallyControlled()) && m_nShotsRemaining > 0) && FireMode.m_bContinuousFire) && ret;
        //return ReturnValue;        
    }

    simulated function RestartFireLoop(bool bRefire)
    {
        local int nIndex;

        // End:0xDB
        if(HasRemoteOwner() && int(m_nDesiredFireMode) > int(0))
        {
            nIndex = s_BurstShotAmmoQueue.Find('ClientRequestId', m_CachedFireRequestId);
            // End:0xDB
            if(nIndex != -1)
            {
                m_nShotsRemaining = int(s_BurstShotAmmoQueue[nIndex].nShotsRemaining);
                m_bFirstShotInBurst = s_BurstShotAmmoQueue[nIndex].bFirstInBurst;
                s_BurstShotAmmoQueue.Remove(0, nIndex + 1);
            }
        }
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function StopFiringLogic()
    {
        m_nShotsRemaining = 0;
        super.StopFiringLogic();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x3D
        if(!m_IsPendingSetFireMode && int(CurrentFireMode) != int(0))
        {
            m_IsPendingSetFireMode = true;
            m_PendingFireMode = 0;
        }
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_AltFireType=EAltFireType.ALTFIRE_SecondMode
    m_ReticuleType=EReticuleType.RETICULE_Precise
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=17.5000000,Z=-12.5000000)
    m_WeaponMeshActorClass=Class'TgGame.TgWeaponMeshActor_AndroxusInhand'
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ft",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[0]=(KeyframeName="trackacc10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccHoriz[2]=(KeyframeName="trackacc200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[2]=(KeyframeName="trackang200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAccVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAccVert[1]=(KeyframeName="trackacc200ftnull",Distance=3200.0000000)
    m_AimAssistKeyframesTrackingAngleVert[0]=(KeyframeName="BasicY",Distance=1600.0000000)
    m_AimAssistKeyframesTrackingAngleVert[1]=(KeyframeName="trackang200ftnull",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Androxus.DeviceInhand'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'gp_forcefeedback.BasicForceFeedback'
}