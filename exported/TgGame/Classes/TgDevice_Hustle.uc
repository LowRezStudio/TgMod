class TgDevice_Hustle extends TgDevice
    native(ChampViktor)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier);

var private native const noexport Pointer VfTable_ITgDeviceInterface_MoveSpeedMultiplier;
var() float m_fMinSprintSpeedSq;
var() float m_fAllowableSprintAngle;
var() float m_fSprintFailSafetyTime;
var float m_fSprintFailTimeAccumulator;

// Export UTgDevice_Hustle::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

// Export UTgDevice_Hustle::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

// Export UTgDevice_Hustle::execIsDeviceFiringLockedForUI(FFrame&, void* const)
native function bool IsDeviceFiringLockedForUI();

// Export UTgDevice_Hustle::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

// Export UTgDevice_Hustle::execShouldInterruptLift(FFrame&, void* const)
native function bool ShouldInterruptLift();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x5D
    if(((Current != none) && Current.m_bHandDevice) && (IsFiring()) || IsTimerActive('FiringEndTransition'))
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

function OnCripple()
{
    super.OnCripple();
    InterruptFiring();
    //return;    
}

simulated event bool CanFiringBeCanceledByReactivation()
{
    return !IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated function bool InterceptSlotReleased(TgPlayerController TgController)
{
    return IsTimerActive('CancelSafetyTimer');
    //return ReturnValue;    
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanSprint()
{
    return ((Instigator != none) && VSizeSq2D(Instigator.Velocity) > m_fMinSprintSpeedSq) && (Normal2D(Instigator.Velocity) Dot Normal2D(Vector(Instigator.Rotation))) > m_fAllowableSprintAngle;
    //return ReturnValue;    
}

simulated function FiringEndTransition()
{
    //return;    
}

simulated function CancelSafetyTimer()
{
    //return;    
}

simulated function CompleteInterrupt()
{
    // End:0x33
    if((!CanBeCanceled() && !CanBeInterrupted()) || !IsFiring())
    {
        return;
    }
    // End:0x51
    if(int(Role) < int(ROLE_Authority))
    {
        ClientInterrupt();
    }
    InterruptFiring();
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
        // End:0x86
        case 10828:
            Dev.RegisterDelegate(1, AsynchronusInterrupt);
        // End:0x8E
        case 11041:
        // End:0x96
        case 11070:
        // End:0xD2
        case 15052:
            Dev.RegisterDelegate(2, AsynchronusInterrupt);
            return;
        // End:0x10E
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
        // End:0x86
        case 10828:
            Dev.UnregisterDelegate(1, AsynchronusInterrupt);
        // End:0x8E
        case 11041:
        // End:0x96
        case 11070:
        // End:0xD2
        case 15052:
            Dev.UnregisterDelegate(2, AsynchronusInterrupt);
            return;
        // End:0x10E
        case 11077:
            Dev.UnregisterDelegate(2, CompleteInterrupt);
            return;
        // End:0xFFFF
        default:
            //return;
            break;
    }    
}

simulated state DeviceFiring
{
    simulated function RestartFireLoop(bool bRefire)
    {
        ClearTimer('FiringEndTransition');
        SetTimer(0.5000000, false, 'CancelSafetyTimer');
        m_fSprintFailTimeAccumulator = 0.0000000;
        super.RestartFireLoop(bRefire);
        //return;        
    }

    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }

    simulated function Tick(float DeltaSeconds)
    {
        super(Actor).Tick(DeltaSeconds);
        // End:0x7E
        if(Instigator != none)
        {
            // End:0x7E
            if((Normal2D(Instigator.Acceleration) Dot Normal2D(Vector(Instigator.Rotation))) < m_fAllowableSprintAngle)
            {
                AsynchronusInterrupt();
            }
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        SetTimer(GetFiringPostHitDelay(), false, 'FiringEndTransition');
        ClearTimer('CancelSafetyTimer');
        super.EndState(NextStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fMinSprintSpeedSq=30000.0000000
    m_fAllowableSprintAngle=0.5000000
    m_fSprintFailSafetyTime=0.2500000
    m_nLinkedDeviceTypes[0]=10828
    m_nLinkedDeviceTypes[1]=11041
    m_nLinkedDeviceTypes[2]=11070
    m_nLinkedDeviceTypes[3]=15052
    m_nLinkedDeviceTypes[4]=11077
}