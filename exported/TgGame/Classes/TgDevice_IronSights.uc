class TgDevice_IronSights extends TgDevice_ToggleWithLockout
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var TgDevice_ViktorInhand m_CachedViktorInhand;
var bool m_bDelayMoveSpeedPenalty;
var bool m_bIsZoomed;
var TgDevice_Hustle m_CachedHustleDevice;

// Export UTgDevice_IronSights::execShouldAltFireOnTick(FFrame&, void* const)
native function bool ShouldAltFireOnTick();

// Export UTgDevice_IronSights::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_IronSights::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
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
        // End:0xA4
        case 10828:
            Dev.RegisterDelegate(1, CompleteInterrupt);
            m_CachedViktorInhand = TgDevice_ViktorInhand(Dev);
            return;
        // End:0xC8
        case 11070:
            m_CachedHustleDevice = TgDevice_Hustle(Dev);
        // End:0xD0
        case 11041:
        // End:0xD8
        case 15052:
        // End:0x114
        case 11077:
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
        // End:0x88
        case 10828:
            Dev.UnregisterDelegate(1, CompleteInterrupt);
            return;
        // End:0x90
        case 11041:
        // End:0x98
        case 11070:
        // End:0xA0
        case 15052:
        // End:0xDC
        case 11077:
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
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_nLinkedDeviceTypes[0]=11077
    m_nLinkedDeviceTypes[1]=10828
    m_nLinkedDeviceTypes[2]=11041
    m_nLinkedDeviceTypes[3]=11070
    m_nLinkedDeviceTypes[4]=15052
    m_nLinkedDeviceTypes[5]=11077
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=3
}