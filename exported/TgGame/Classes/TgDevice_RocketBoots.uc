class TgDevice_RocketBoots extends TgDevice_Charge
    native(ChampBarik)
    hidecategories(Navigation);

simulated function float GetChargeSpeed()
{
    local float CV1;
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x69
    if(FireMode != none)
    {
        CV1 = FireMode.GetCustomValue1();
        // End:0x69
        if(CV1 > 0.0000000)
        {
            return CV1;
        }
    }
    return super.GetChargeSpeed();
    //return ReturnValue;    
}

simulated event float GetChargeRange()
{
    local float CV1;
    local TgDeviceFire FireMode;
    local float fChargeTime;

    FireMode = GetCurrentFire();
    // End:0x88
    if(FireMode != none)
    {
        CV1 = FireMode.GetCustomValue1();
        // End:0x88
        if(CV1 > 0.0000000)
        {
            fChargeTime = GetChargeTime();
            return CV1 * fChargeTime;
        }
    }
    return super.GetChargeRange();
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
        if(firePostHitTime > 0.3000000)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    m_eChargeState=EChargeState.CHARGE_Turn
}