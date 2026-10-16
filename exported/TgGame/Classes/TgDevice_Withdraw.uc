class TgDevice_Withdraw extends TgDevice_ChargeBackward
    native(ChampLongbow)
    hidecategories(Navigation);

// Export UTgDevice_Withdraw::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated event bool ShouldInterruptInhand()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        local TgPawn PawnOwner;
        local TgDevice plantedDev;

        PawnOwner = TgPawn(Owner);
        // End:0xA6
        if(PawnOwner != none)
        {
            plantedDev = PawnOwner.GetDeviceById(14988);
            // End:0xA6
            if(plantedDev != none)
            {
                plantedDev.InterruptFiring();
                plantedDev.ClientInterrupt();
            }
        }
        super.StartFiringLogic();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_bForce3PViewWhileFiring=false
}