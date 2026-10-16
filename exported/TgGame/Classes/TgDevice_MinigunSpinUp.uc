class TgDevice_MinigunSpinUp extends TgDevice
    hidecategories(Navigation);

var TgDevice_RuckusInhand m_cachedRuckusInhand;

simulated function bool IsToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x38
    if(IsFiring())
    {
        // End:0x38
        if(int(Current.r_eEquippedAt) == int(23))
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function StartSpinningInhand()
{
    CacheRuckusInhand();
    // End:0x3A
    if(m_cachedRuckusInhand != none)
    {
        m_cachedRuckusInhand.m_bAltFireSpinning = true;
    }
    //return;    
}

simulated function StopSpinningInhand()
{
    CacheRuckusInhand();
    // End:0x3A
    if(m_cachedRuckusInhand != none)
    {
        m_cachedRuckusInhand.m_bAltFireSpinning = false;
    }
    //return;    
}

simulated function CacheRuckusInhand()
{
    local TgPawn_Character TgPC;

    // End:0x6D
    if(m_cachedRuckusInhand == none)
    {
        TgPC = TgPawn_Character(Instigator);
        // End:0x6D
        if(TgPC != none)
        {
            m_cachedRuckusInhand = TgDevice_RuckusInhand(TgPC.GetDeviceByEqPoint(1));
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        StartSpinningInhand();
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        StopSpinningInhand();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
}