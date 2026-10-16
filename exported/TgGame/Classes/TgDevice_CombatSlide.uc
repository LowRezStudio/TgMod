class TgDevice_CombatSlide extends TgDevice_Charge
    native(ChampLex)
    hidecategories(Navigation);

var(Slide) int m_nEyeheightAdjustmentWhileSliding;
var float m_fEyeHeightSmoothFactor;

simulated event bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

// Export UTgDevice_CombatSlide::execShouldBlockReload(FFrame&, void* const)
native function bool ShouldBlockReload(TgDevice Dev, bool bIsAutoReload);

simulated event bool CanBeCanceled()
{
    local float firePostHitTime, fLockOutTime;
    local TgDeviceFire FireMode;

    // End:0xA9
    if(IsTimerActive('FirePostHitDelay'))
    {
        firePostHitTime = GetTimerCount('FirePostHitDelay');
        fLockOutTime = 0.5000000;
        FireMode = GetCurrentFire();
        // End:0x90
        if(FireMode != none)
        {
            fLockOutTime = FireMode.GetCustomValue3();
        }
        // End:0xA9
        if(firePostHitTime < fLockOutTime)
        {
            return false;
        }
    }
    return true;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event StartCharge()
    {
        local TgPawn_Character TgPC;
        local TgDeviceFire FireMode;

        super.StartCharge();
        // End:0x125
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            TgPC = TgPawn_Character(Instigator);
            // End:0x125
            if(TgPC != none)
            {
                // End:0x9B
                if(m_nEyeheightAdjustmentWhileSliding != 0)
                {
                    TgPC.BaseEyeHeight += float(m_nEyeheightAdjustmentWhileSliding);                    
                }
                else
                {
                    FireMode = GetCurrentFire();
                    // End:0xFD
                    if(FireMode != none)
                    {
                        TgPC.BaseEyeHeight += FireMode.GetCustomValue1();
                    }
                }
                TgPC.m_fEyeHeightSmoothFactor = m_fEyeHeightSmoothFactor;
            }
        }
        //return;        
    }

    simulated event EndCharge()
    {
        local TgPawn_Character TgPC;
        local TgDeviceFire FireMode;

        super.EndCharge();
        // End:0x13A
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            TgPC = TgPawn_Character(Instigator);
            // End:0x13A
            if(TgPC != none)
            {
                // End:0x9B
                if(m_nEyeheightAdjustmentWhileSliding != 0)
                {
                    TgPC.BaseEyeHeight -= float(m_nEyeheightAdjustmentWhileSliding);                    
                }
                else
                {
                    FireMode = GetCurrentFire();
                    // End:0xFD
                    if(FireMode != none)
                    {
                        TgPC.BaseEyeHeight -= FireMode.GetCustomValue1();
                    }
                }
                TgPC.m_fEyeHeightSmoothFactor = Class'TgGame.TgPawn'.default.m_fEyeHeightSmoothFactor;
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fEyeHeightSmoothFactor=4.0000000
    m_eChargeState=EChargeState.CHARGE_NoTurn_RotPawn
    m_bCanLeftClickCancel=false
    m_bForce3PViewWhileFiring=false
    m_bMustBeOnGroundToFire=true
}