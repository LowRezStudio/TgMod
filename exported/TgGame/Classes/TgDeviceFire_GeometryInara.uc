class TgDeviceFire_GeometryInara extends TgDeviceFire;

simulated event float GetCooldownTime()
{
    local TgDevice_GeometryBarrierTank Dev;
    local float fCooldown, fHealthPercent;

    fCooldown = super.GetCooldownTime();
    Dev = TgDevice_GeometryBarrierTank(m_Owner);
    // End:0x153
    if((Dev != none) && Dev.r_fTremorsCooldownReduction > 0.0000000)
    {
        // End:0xCE
        if(Dev.r_Deployable != none)
        {
            fHealthPercent = Dev.r_Deployable.GetHealthPercent();            
        }
        else
        {
            fHealthPercent = Dev.m_fCachedWallHealthPercent;
        }
        // End:0x153
        if(fHealthPercent > 0.0000000)
        {
            fCooldown *= (1.0000000 - Dev.r_fTremorsCooldownReduction);
            fCooldown = FMax(fCooldown, 0.0000000);
        }
    }
    return fCooldown;
    //return ReturnValue;    
}

simulated event float GetMinCooldownTime()
{
    local TgDevice_GeometryBarrierTank Dev;
    local float fMinCooldown, fActualCooldown;

    fMinCooldown = super.GetMinCooldownTime();
    Dev = TgDevice_GeometryBarrierTank(m_Owner);
    // End:0x9B
    if((Dev != none) && Dev.r_fTremorsCooldownReduction > 0.0000000)
    {
        fActualCooldown = GetCooldownTime();
        fMinCooldown = FMin(fMinCooldown, fActualCooldown);
    }
    return fMinCooldown;
    //return ReturnValue;    
}
