class TgDevice_LongbowPlanted extends TgDevice_Stim
    hidecategories(Navigation);

var TgPawn_Longbow m_CachedLongbow;
var TgDevice_LongbowInhand m_CachedInhand;

simulated event bool CanBeCanceled()
{
    return IsTimerActive('FirePostHitDelay');
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x98
    if((Current != none) && Current.m_bHandDevice)
    {
        // End:0x69
        if(!IsTimerActive('FirePreHitDelay') && !IsTimerActive('TransitionOut'))
        {
            return false;
        }
        // End:0x98
        if(HasRemoteOwner() && GetRemainingTimeForTimer('FirePreHitDelay') < 0.1000000)
        {
            return false;
        }
    }
    // End:0xA7
    if(IsFiring())
    {
        return true;
    }
    // End:0xD0
    if(HasRemoteOwner())
    {
        return GetRemainingTimeForTimer('TransitionOut') > 0.1000000;
    }
    return IsTimerActive('TransitionOut');
    //return ReturnValue;    
}

simulated function TransitionOut()
{
    //return;    
}

simulated function bool HasCachedLongbow()
{
    // End:0x11
    if(m_CachedLongbow != none)
    {
        return true;
    }
    m_CachedLongbow = TgPawn_Longbow(Instigator);
    return m_CachedLongbow != none;
    //return ReturnValue;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super(TgDevice).LinkedDeviceEquipped(Dev);
    switch(Dev.m_nDeviceType)
    {
        // End:0x73
        case 10828:
            m_CachedInhand = TgDevice_LongbowInhand(Dev);
            // End:0x76
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

simulated function bool RequireMovementForAimAssist()
{
    return !NativeIsFiring();
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        // End:0xC0
        if(m_CachedInhand != none)
        {
            m_CachedInhand.AsynchronusInterrupt();
            m_CachedInhand.SetFireMode(1, true);
            m_CachedInhand.m_bIsFireHoldDevice = false;
            m_CachedInhand.SetFireHoldAmt(1.0000000);
            // End:0xC0
            if(HasCachedLongbow())
            {
                m_CachedLongbow.ClearImpalerArrow();
            }
        }
        super.BeginState(PreviousStateName);
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        // End:0xAB
        if(m_CachedInhand != none)
        {
            m_CachedInhand.AsynchronusInterrupt();
            m_CachedInhand.SetFireMode(0, true);
            m_CachedInhand.m_bIsFireHoldDevice = true;
            SetTimer(self.GetCurrentFire().GetCustomValue1(), false, 'TransitionOut');
        }
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
    m_nLinkedDeviceTypes[0]=10828
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_nAimAssistPriorityWhileFiring=2
}