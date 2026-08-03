class TgDevice_ChargeFernando extends TgDevice_Charge
    hidecategories(Navigation);

var float m_fCooldownReduction;

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

function AuthStartCooldown(optional int nMode = -1, optional float fCooldownTimeOverride = -1.0000000)
{
    super(TgDevice).AuthStartCooldown(nMode, GetCurrentFire().GetCooldownTime() * (1.0000000 - m_fCooldownReduction));
    m_fCooldownReduction = 0.0000000;
    //return;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x3B
    if((Current != none) && Current.r_nDeviceId == 11059)
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}
