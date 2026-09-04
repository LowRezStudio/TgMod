class TgDevice_BarrageFire extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation);

var int m_nChainedBarrageNum;
var TgDevice_Barrage m_BarrageDevice;

// Export UTgDevice_BarrageFire::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_BarrageFire::execGetConePullbackDistance(FFrame&, void* const)
native function float GetConePullbackDistance();

// Export UTgDevice_BarrageFire::execValidateReceivedAim(FFrame&, void* const)
native function AimData ValidateReceivedAim(float ClientMovementTimeStamp, AimData Aim);

// Export UTgDevice_BarrageFire::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_BarrageFire::execGetCurrentShotCost(FFrame&, void* const)
native function float GetCurrentShotCost();

// Export UTgDevice_BarrageFire::execUpdateUltChargePercent(FFrame&, void* const)
native function bool UpdateUltChargePercent();

simulated function ResetBarrage()
{
    m_nChainedBarrageNum = 3;
    bPendingFire = false;
    //return;    
}

simulated function bool InterceptLeftMousePressed(TgPlayerController TgController)
{
    local TgPawn_Character TgPC;

    // End:0x95
    if(m_BarrageDevice.IsTimerActive('FirePostHitDelay'))
    {
        // End:0x93
        if(!Use())
        {
            TgPC = TgPawn_Character(Instigator);
            // End:0x93
            if(TgPC != none)
            {
                TgPC.FxReactivateGroupSelf('ViktorBarrageFailure', 0);
            }
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool InterceptLeftMouseReleased(TgPlayerController TgController)
{
    // End:0x38
    if(m_BarrageDevice.IsTimerActive('FirePostHitDelay'))
    {
        StopFire();
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolOnStartFire()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldConsumePowerPoolAfterFire()
{
    return true;
    //return ReturnValue;    
}

simulated function CustomFire()
{
    local AimData Aim;

    UpdateIndex();
    GetCachedAim(Aim);
    TgPawn(Instigator).FlashFireNoSim(r_nDeviceInstanceId, int(CurrentFireMode), Aim.EndTrace, int(r_eEquippedAt), m_nSocketIndex, false, GetRefireTime());
    // End:0x107
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x107
        if(Aim.HitActor != none)
        {
            GetCurrentFire().DeployAtActor(Aim.HitActor);
        }
    }
    //return;    
}

simulated function HandleDeviceFormStartFire(int nDeviceModeNum, float fRefireTime, const out AimData Aim)
{
    TgPawn(Instigator).FlashStartFire(r_nDeviceInstanceId, nDeviceModeNum, fRefireTime, Aim.HitActor, m_nChainedBarrageNum);
    // End:0xCD
    if(c_DeviceForm != none)
    {
        c_DeviceForm.StartFire(nDeviceModeNum, fRefireTime, Aim.HitActor, m_nChainedBarrageNum);
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0xA4
        case 14351:
            m_BarrageDevice = TgDevice_Barrage(Dev);
            Dev.RegisterDelegate(2, ResetBarrage);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.r_nDeviceId)
    {
        // End:0x88
        case 14351:
            Dev.UnregisterDelegate(2, ResetBarrage);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        // End:0x50
        if(m_nChainedBarrageNum == 1)
        {
            m_BarrageDevice.SetTimer(GetRemainingTimeForTimer('FirePostHitDelay'), false, 'LastShotCancelTimer');
        }
        //return;        
    }

    simulated function FirePostHitDelay()
    {
        m_nChainedBarrageNum -= 1;
        super.FirePostHitDelay();
        //return;        
    }

    simulated function bool ShouldRefire(TgDeviceFire FireMode, const out AimData Aim)
    {
        local TgObject.EDeviceFailType failType;

        return (bPendingFire || s_nNumClientRefires > s_nNumServerRefires) && CanDeviceFireNow(CurrentFireMode, Aim, LogDebugInfo(), failType);
        //return ReturnValue;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14351
}