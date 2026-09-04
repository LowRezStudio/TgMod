class TgDevice_ImpalerArrow extends TgDevice
    native(ChampLongbow)
    hidecategories(Navigation);

var TgPawn_Longbow m_CachedLongbow;

// Export UTgDevice_ImpalerArrow::execShouldAltFireOnTick(FFrame&, void* const)
native function bool ShouldAltFireOnTick();

// Export UTgDevice_ImpalerArrow::execIsDeviceFiringForUI(FFrame&, void* const)
native function bool IsDeviceFiringForUI();

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

simulated event bool HasCachedLongbow()
{
    // End:0x38
    if(m_CachedLongbow == none)
    {
        m_CachedLongbow = TgPawn_Longbow(Instigator);
        return m_CachedLongbow != none;
    }
    return true;
    //return ReturnValue;    
}

simulated function FireAmmunition()
{
    super.FireAmmunition();
    // End:0x57
    if(HasCachedLongbow())
    {
        m_CachedLongbow.ToggleImpalerArrow(!m_CachedLongbow.r_bImpalerArrowIsActive);
    }
    //return;    
}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
}