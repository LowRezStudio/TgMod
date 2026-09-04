class TgDevice_DemonUlt extends TgDevice_Stim
    hidecategories(Navigation);

simulated event bool CanBeCanceled()
{
    return false;
    //return ReturnValue;    
}

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
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
        local TgPawn_Demon PawnOwner;
        local TgDevice_DemonInhand inhandDev;

        super.StartFiringLogic();
        PawnOwner = TgPawn_Demon(Owner);
        // End:0x159
        if(PawnOwner != none)
        {
            PawnOwner.r_bIsUltActive = true;
            inhandDev = TgDevice_DemonInhand(PawnOwner.GetDeviceByEqPoint(1));
            // End:0x159
            if(inhandDev != none)
            {
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
        local TgPawn_Demon PawnOwner;

        super.StopFiringLogic();
        PawnOwner = TgPawn_Demon(Owner);
        // End:0x56
        if(PawnOwner != none)
        {
            PawnOwner.r_bIsUltActive = false;
        }
        SetTimer(GetCurrentFire().GetCustomValue1(), false, 'TransitionOut');
        //return;        
    }
    stop;    
}
