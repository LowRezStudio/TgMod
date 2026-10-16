class TgDevice_ShadowTravel extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation);

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

simulated function bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

// Export UTgDevice_ShadowTravel::execGetMoveSpeedMultiplier(FFrame&, void* const)
native function float GetMoveSpeedMultiplier();

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        local TgPawn_Oracle Oracle;
        local TgDevice inhand;

        Oracle = TgPawn_Oracle(Owner);
        // End:0x102
        if(Oracle != none)
        {
            inhand = Oracle.GetDeviceByEqPoint(1);
            // End:0x102
            if(inhand != none)
            {
                inhand.InterruptReload();
                inhand.ClientInterruptReload();
                inhand.SetAmmo(inhand.r_nMaxAmmoClipCount);
                Oracle.ForceUpdateAmmoAnim();
            }
        }
        super.FirePreHitDelay();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bUsesOutroLockout=true
    m_fEnterCombatDuration=1.0000000
}