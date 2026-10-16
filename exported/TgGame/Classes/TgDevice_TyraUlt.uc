class TgDevice_TyraUlt extends TgDevice_Stim
    hidecategories(Navigation);

simulated event bool CanBeCanceled()
{
    return IsTimerActive('FirePostHitDelay');
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x49
    if(HasRemoteOwner())
    {
        return (GetRemainingTimeForTimer('FirePreHitDelay') > 0.1000000) || GetRemainingTimeForTimer('TransitionOut') > 0.1000000;
    }
    return IsTimerActive('FirePreHitDelay') || IsTimerActive('TransitionOut');
    //return ReturnValue;    
}

simulated function TransitionOut()
{
    //return;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn PawnOwner;
        local TgDevice_TyraInhand inhandDev;

        super.StartFiringLogic();
        PawnOwner = TgPawn(Owner);
        // End:0x159
        if(PawnOwner != none)
        {
            inhandDev = TgDevice_TyraInhand(PawnOwner.GetDeviceByEqPoint(1));
            // End:0x159
            if(inhandDev != none)
            {
                inhandDev.m_bUltIsActive = true;
                // End:0xF9
                if(inhandDev.IsReloading())
                {
                    inhandDev.InterruptReload();
                    inhandDev.ClientInterruptReload();
                }
                // End:0x159
                if(inhandDev.IsFiring())
                {
                    inhandDev.InterruptFiring();
                    inhandDev.ClientInterrupt();
                }
            }
        }
        //return;        
    }

    simulated function StopFiringLogic()
    {
        local TgPawn PawnOwner;
        local TgDevice_TyraInhand inhandDev;

        super.StopFiringLogic();
        PawnOwner = TgPawn(Owner);
        // End:0x98
        if(PawnOwner != none)
        {
            inhandDev = TgDevice_TyraInhand(PawnOwner.GetDeviceByEqPoint(1));
            // End:0x98
            if(inhandDev != none)
            {
                inhandDev.m_bUltIsActive = false;
            }
        }
        SetTimer(GetCurrentFire().GetCustomValue1(), false, 'TransitionOut');
        //return;        
    }
    stop;    
}
