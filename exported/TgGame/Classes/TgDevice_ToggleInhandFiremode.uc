class TgDevice_ToggleInhandFiremode extends TgDevice
    hidecategories(Navigation);

var TgDevice m_CachedInhand;

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3E
    if((Current != none) && Current.m_bHandDevice)
    {
        return IsFiring();
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldStopActionOnOffhandSlotReleased()
{
    return false;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    local int DesiredFireMode;

    super.FireAmmunition();
    // End:0x11B
    if((HasCachedInhand()) && m_CachedInhand.m_FireMode.Length >= 2)
    {
        // End:0x8E
        if(m_CachedInhand.m_IsPendingSetFireMode)
        {
            DesiredFireMode = int(m_CachedInhand.m_PendingFireMode);            
        }
        else
        {
            DesiredFireMode = int(m_CachedInhand.CurrentFireMode);
        }
        // End:0xF2
        if(++DesiredFireMode >= m_CachedInhand.m_FireMode.Length)
        {
            DesiredFireMode = 0;
        }
        m_CachedInhand.SetFireMode(DesiredFireMode);
    }
    //return;    
}

simulated function bool HasCachedInhand()
{
    local TgPawn PawnOwner;

    // End:0x64
    if(m_CachedInhand == none)
    {
        PawnOwner = TgPawn(Owner);
        // End:0x64
        if(PawnOwner != none)
        {
            m_CachedInhand = PawnOwner.GetDeviceByEqPoint(1);
        }
    }
    return m_CachedInhand != none;
    //return ReturnValue;    
}

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
}