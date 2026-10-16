class TgDevice_Scope extends TgDevice_ToggleWithLockout
    native(ChampOwl)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var bool m_bDelayMoveSpeedPenalty;
var bool m_bIsZoomed;

// Export UTgDevice_Scope::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x4A
    if(((IsFiring()) && Current != none) && Current.m_nDeviceType == 15205)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function StartFireDescopeTimer()
{
    m_bIsZoomed = false;
    // End:0x6D
    if(IsFiring())
    {
        // End:0x63
        if(!IsTimerActive('FirePreHitDelay'))
        {
            SetTimer(GetCurrentFire().GetCustomValue2(), false, 'FireDescopeTimer');            
        }
        else
        {
            FireDescopeTimer();
        }
    }
    //return;    
}

simulated function FireDescopeTimer()
{
    // End:0x1E
    if(int(Role) < int(ROLE_Authority))
    {
        ClientInterrupt();
    }
    InterruptFiring();
    //return;    
}

simulated event bool CanBeCanceled()
{
    return !IsTimerActive('FireDescopeTimer');
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return (IsFiring()) && !IsTimerActive('FireDescopeTimer');
    //return ReturnValue;    
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
        // End:0xBA
        case 10828:
            Dev.RegisterDelegate(1, CompleteInterrupt);
            Dev.RegisterDelegate(0, StartFireDescopeTimer);
            return;
        // End:0x14B
        case 11041:
            Dev.RegisterDelegate(2, CompleteInterrupt);
            // End:0x149
            if(Dev.IsA('TgDevice_OwlStealth'))
            {
                Dev.RegisterDelegate(3, CompleteInterrupt);
            }
            return;
        // End:0x187
        case 15052:
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
    super.LinkedDeviceUnequipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0xBA
        case 10828:
            Dev.UnregisterDelegate(1, CompleteInterrupt);
            Dev.UnregisterDelegate(0, StartFireDescopeTimer);
            return;
        // End:0x14B
        case 11041:
            Dev.UnregisterDelegate(2, CompleteInterrupt);
            // End:0x149
            if(Dev.IsA('TgDevice_OwlStealth'))
            {
                Dev.UnregisterDelegate(3, CompleteInterrupt);
            }
            return;
        // End:0x187
        case 15052:
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
    super.CompleteInterrupt();
    //return;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    local TgPawn_Owl TgP;

    TgP = TgPawn_Owl(Instigator);
    // End:0x81
    if((IsPlayerToggleZoomSet()) && TgP.m_bUseSecondWeapon == false)
    {
        m_bIsZoomed = !m_bIsZoomed;
        // End:0x81
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
    simulated function StartFiringLogic()
    {
        local TgPawn TgP;

        TgP = TgPawn(Instigator);
        // End:0x59
        if(TgP != none)
        {
            // End:0x59
            if(TgP.r_bIsJumping)
            {
                m_bDelayMoveSpeedPenalty = true;
            }
        }
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=11041
    m_nLinkedDeviceTypes[3]=15052
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz[0]=(KeyframeName="trackang10ftlowx",Distance=160.0000000)
    m_AimAssistKeyframesTrackingAngleHoriz[1]=(KeyframeName="BasicX",Distance=1600.0000000)
    m_nAimAssistPriorityWhileFiring=2
}