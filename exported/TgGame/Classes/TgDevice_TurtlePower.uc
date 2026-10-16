class TgDevice_TurtlePower extends TgDevice_Toggle
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x5D
    if((Current != none) && Current.r_nDeviceId == 14844)
    {
        return (IsFiring()) || IsTimerActive('OutroLockoutTime');
    }
    return (IsTimerActive('FirePreHitDelay') || IsTimerActive('CancelSafetyPeriodTimer')) || IsTimerActive('OutroLockoutTime');
    //return ReturnValue;    
}

function CancelSafetyPeriodTimer()
{
    //return;    
}

simulated event bool CanBeCanceled()
{
    // End:0x32
    if(IsTimerActive('FirePostHitDelay'))
    {
        // End:0x32
        if(!IsTimerActive('CancelSafetyPeriodTimer'))
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated function InterruptOtherAbilities()
{
    local TgPawn PawnOwner;
    local TgDevice Dev;
    local int I;

    PawnOwner = TgPawn(Owner);
    // End:0x115
    if(PawnOwner != none)
    {
        I = 0;
        J0x36:

        // End:0x115 [Loop If]
        if(I < 33)
        {
            Dev = PawnOwner.GetDeviceByEqPoint(I);
            // End:0x107
            if(((Dev != none) && Dev != self) && Dev.IsAbility() || int(Dev.r_eEquippedAt) == int(16))
            {
                Dev.InterruptFiring();
            }
            I++;
            // [Loop Continue]
            goto J0x36;
        }
    }
    //return;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        // End:0x3C
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            SetTimer(0.5000000, false, 'CancelSafetyPeriodTimer');
        }
        super.FirePreHitDelay();
        //return;        
    }

    simulated function StartFiringLogic()
    {
        local TgPawn_Makoa makoaOwner;

        InterruptOtherAbilities();
        super.StartFiringLogic();
        makoaOwner = TgPawn_Makoa(Instigator);
        // End:0x5F
        if(makoaOwner != none)
        {
            makoaOwner.PlayAncientRageEffects(true);
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn_Makoa makoaOwner;

        super.StopFiringLogic();
        makoaOwner = TgPawn_Makoa(Instigator);
        // End:0x55
        if(makoaOwner != none)
        {
            makoaOwner.PlayAncientRageEffects(false);
        }
        // End:0x92
        if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
        {
            ClearTimer('CancelSafetyPeriodTimer');
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_DeviceTimerBarType=DeviceTimerBarType.DTBT_PostHit
    m_bUsesOutroLockout=true
    m_fOutroLockoutTime=0.6000000
}