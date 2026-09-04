class TgDevice_SniperMode extends TgDevice_ToggleModeWithLockout
    native(ChampKinessa)
    hidecategories(Navigation);

var TgPawn_Kinessa m_CachedKinessaOwner;
var TgDevice_KinessaInhand m_CachedKinessaInhandDev;
var bool m_bIsZoomed;

// Export UTgDevice_SniperMode::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated function bool ShouldInterruptMount()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

simulated function RefreshZoomState(bool bZoomOn)
{
    local TgDeviceFire FireMode;
    local float NewFOV, speedMult, chargeDelay;

    // End:0x1F2
    if(bZoomOn)
    {
        FireMode = GetCurrentFire();
        // End:0x89
        if(FireMode != none)
        {
            NewFOV = FireMode.GetCustomValue1();
            speedMult = FireMode.GetCustomValue2() / 100.0000000;
        }
        NewFOV = ((NewFOV > float(0)) ? NewFOV : 20.0000000);
        // End:0xDF
        if(m_CachedKinessaOwner == none)
        {
            m_CachedKinessaOwner = TgPawn_Kinessa(Owner);
        }
        // End:0x1EF
        if(m_CachedKinessaOwner != none)
        {
            // End:0x161
            if(m_CachedKinessaInhandDev != none)
            {
                // End:0x161
                if(m_CachedKinessaInhandDev.GetCurrentFire() != none)
                {
                    chargeDelay = m_CachedKinessaInhandDev.GetCurrentFire().GetCustomValue1();
                }
            }
            m_CachedKinessaOwner.SetZoomState(true, ((speedMult > 0.0000000) ? speedMult : 1.0000000), ((chargeDelay > 0.0000000) ? chargeDelay : 1.0000000));
            m_CachedKinessaOwner.SetWeaponZoom(NewFOV);
        }        
    }
    else
    {
        // End:0x24F
        if(m_CachedKinessaOwner != none)
        {
            m_CachedKinessaOwner.SetZoomState(false, 1.0000000, 0.0000000);
            m_CachedKinessaOwner.SetWeaponZoom(0.0000000);
        }
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
    switch(Dev.m_nDeviceType)
    {
        // End:0xA4
        case 10828:
            Dev.RegisterDelegate(1, CompleteInterrupt);
            m_CachedKinessaInhandDev = TgDevice_KinessaInhand(Dev);
            return;
        // End:0xAC
        case 11070:
        // End:0xE8
        case 11041:
            Dev.RegisterDelegate(2, CompleteInterrupt);
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
    super(TgDevice_ToggleWithLockout).LinkedDeviceUnequipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x88
        case 10828:
            Dev.UnregisterDelegate(1, CompleteInterrupt);
            return;
        // End:0x90
        case 11070:
        // End:0xCC
        case 11041:
            Dev.UnregisterDelegate(2, CompleteInterrupt);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated function bool IsPlayerToggleZoomSet()
{
    local TgPawn TgP;
    local TgPlayerController TgPC;

    TgP = TgPawn(Instigator);
    // End:0x94
    if(TgP != none)
    {
        TgPC = TgPlayerController(TgP.Controller);
        // End:0x94
        if((TgPC != none) && TgPC.r_bToggleZoom == true)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function CompleteInterrupt()
{
    m_bIsZoomed = false;
    super(TgDevice_ToggleWithLockout).CompleteInterrupt();
    //return;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    // End:0x3E
    if(IsPlayerToggleZoomSet())
    {
        m_bIsZoomed = !m_bIsZoomed;
        // End:0x3E
        if(m_bIsZoomed == false)
        {
            StopFire();
        }
    }
    return super(TgDevice).InterceptSlotReleased(TgController);
    //return ReturnValue;    
}

simulated event bool IsFunctionallyToggleDevice()
{
    // End:0x0F
    if(IsPlayerToggleZoomSet())
    {
        return true;
    }
    return super(TgDevice).IsFunctionallyToggleDevice();
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    // End:0x0F
    if(IsPlayerToggleZoomSet())
    {
        return false;
    }
    return super(TgDevice).ShouldStopActionOnOffhandSlotReleased();
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        // End:0x42
        if(m_CachedKinessaInhandDev != none)
        {
            m_CachedKinessaInhandDev.m_AimVectorAssistMaxAssistanceDegrees = vect2d(0.0000000, 0.0000000);
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        RefreshZoomState(true);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0x61
        if(m_CachedKinessaInhandDev != none)
        {
            m_CachedKinessaInhandDev.m_AimVectorAssistMaxAssistanceDegrees = m_CachedKinessaInhandDev.Class.default.m_AimVectorAssistMaxAssistanceDegrees;
        }
        RefreshZoomState(false);
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=10828
    m_nLinkedDeviceTypes[3]=11041
    m_nLinkedDeviceTypes[4]=11070
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}