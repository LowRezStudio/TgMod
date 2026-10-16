class TgDevice_CounterAttack extends TgDevice
    native(ChampDarklord)
    hidecategories(Navigation);

simulated state DeviceFiring
{
    simulated function StopFiringLogic()
    {
        local TgPawn PawnOwner;
        local TgDevice_Counter counterDevice;

        super.StopFiringLogic();
        PawnOwner = TgPawn(Owner);
        // End:0xDC
        if(PawnOwner != none)
        {
            counterDevice = TgDevice_Counter(PawnOwner.GetDeviceByEqPoint(16));
            // End:0xDC
            if((counterDevice != none) && counterDevice.r_bInterruptAfterCounterAttack)
            {
                counterDevice.InterruptFiring();
                counterDevice.StartCooldown();
            }
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bDisableLagCompensation=true
}