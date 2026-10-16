class TgDevice_Counter extends TgDevice
    native(ChampDarklord)
    hidecategories(Navigation);

var bool r_bInterruptAfterCounterAttack;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_bInterruptAfterCounterAttack;
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3C
    if((Current != none) && int(Current.r_eEquippedAt) == int(18))
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

event bool CanTriggerCounterAttack()
{
    return IsTimerActive('FirePreHitDelay') && !IsTimerActive('CounterDelay');
    //return ReturnValue;    
}

function CounterDelay()
{
    //return;    
}

simulated function UpdateOutroLockoutTime()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x4C
    if(FireMode != none)
    {
        m_fOutroLockoutTime = FireMode.GetCustomValue4();
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgDeviceFire FireMode;

        super.StartFiringLogic();
        FireMode = GetCurrentFire();
        // End:0x5A
        if(FireMode != none)
        {
            SetTimer(FireMode.GetCustomValue1(), false, 'CounterDelay');
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        ClearTimer('CounterDelay');
        //return;        
    }
    stop;    
}

defaultproperties
{
    r_bInterruptAfterCounterAttack=true
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PreHit
    m_bAlwaysStartCooldown=true
    m_bUsesOutroLockout=true
}