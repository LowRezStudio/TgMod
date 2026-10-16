class TgDevice_Stealth extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation);

var bool m_bIsInCombat;
var bool m_bCanFireInCombat;

// Export UTgDevice_Stealth::execShouldInterruptStealth(FFrame&, void* const)
native function bool ShouldInterruptStealth();

// Export UTgDevice_Stealth::execCanFireWhileMounted(FFrame&, void* const)
native function bool CanFireWhileMounted();

// Export UTgDevice_Stealth::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated event bool StartFire()
{
    local bool bReturn;
    local TgPawn TgP;
    local TgPawn_Character TgPChar;
    local TgPawn TgPOwner;

    // End:0x63
    if(int(Role) == int(ROLE_Authority))
    {
        TgPOwner = TgPawn(Owner);
        // End:0x63
        if(TgPOwner != none)
        {
            TgPOwner.s_fDamageTakenDuringStealth = 0.0000000;
        }
    }
    bReturn = super.StartFire();
    TgP = TgPawn(Instigator);
    // End:0xE6
    if((TgP != none) && TgP.r_bCanStartStealthInCombat)
    {
        TgP.ExitCombat();
    }
    TgPChar = TgPawn_Character(Instigator);
    // End:0x130
    if(TgPChar != none)
    {
        TgPChar.RemoveStickyBombs();
    }
    return bReturn;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    local float firePostHitTime;

    // End:0x4A
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        // End:0x4A
        if(firePostHitTime > 0.5000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x20
    if((IsFiring()) && !CanBeCanceled())
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldCancelStealth()
{
    return false;
    //return ReturnValue;    
}

simulated function bool ShouldInterruptMount()
{
    return true;
    //return ReturnValue;    
}

simulated event bool ShouldMountCancelFiring()
{
    // End:0x0F
    if(CanFireWhileMounted())
    {
        return false;
    }
    return super.ShouldMountCancelFiring();
    //return ReturnValue;    
}

defaultproperties
{
    m_bCanFireInCombat=true
}