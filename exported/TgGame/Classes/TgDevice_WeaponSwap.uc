class TgDevice_WeaponSwap extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0xC2
    if(((Current != none) && Current.IsAbility() || Current.m_bHandDevice) && (GetRemainingTimeForTimer('FirePreHitDelay') > ((HasRemoteOwner()) ? 0.1000000 : 0.0000000)) || GetRemainingTimeForTimer('FiringEndTransition') > ((HasRemoteOwner()) ? 0.1000000 : 0.0000000))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return super.CanBeCanceled() && !TgPawn(Instigator).AreAnyOtherOffhandsLockingFiring(self);
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    return true;
    //return ReturnValue;    
}

// Export UTgDevice_WeaponSwap::execNotifyWeaponSwap(FFrame&, void* const)
native function NotifyWeaponSwap(float fSwapTime);

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    super.HandleDeviceFormStartFire(nDeviceModeNum, GetFiringPreHitDelay(nDeviceModeNum), Aim);
    //return;    
}

simulated function FiringEndTransition()
{
    TgPawn_Owl(Instigator).FinishedWeaponSwap();
    //return;    
}

// Export UTgDevice_WeaponSwap::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        ClearTimer('FiringEndTransition');
        TgPawn_Owl(Instigator).SwapToSecondWeapon(true);
        NotifyWeaponSwap(GetFiringPreHitDelay(int(CurrentFireMode)));
        super.StartFiringLogic();
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        TgPawn_Owl(Instigator).FinishedWeaponSwap();
        ClearTimer('FirePostHitDelay');
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local float fTransitionTime;

        fTransitionTime = GetFiringPostHitDelay();
        SetTimer(fTransitionTime, false, 'FiringEndTransition');
        NotifyWeaponSwap(fTransitionTime);
        TgPawn_Owl(Instigator).SwapToSecondWeapon(false);
        // End:0x9D
        if(ShouldInterruptReloadOnFire())
        {
            TgPawn_Owl(Instigator).InterruptInhandReload();
        }
        TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, int(CurrentFireMode), fTransitionTime, none, GetCurrentAmmoAmount());
        // End:0x13A
        if(c_DeviceForm != none)
        {
            c_DeviceForm.StartFire(int(CurrentFireMode), fTransitionTime, none, GetCurrentAmmoAmount());
        }
        super.StopFiringLogic();
        //return;        
    }
    stop;    
}

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