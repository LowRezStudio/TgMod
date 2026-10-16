class TgDevice_Whirl extends TgDevice_Charge
    hidecategories(Navigation);

simulated function Rotator GetChargeDirection()
{
    return Instigator.Rotation;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event StartCharge()
    {
        local TgPawn_Darklord darklord;

        darklord = TgPawn_Darklord(Instigator);
        // End:0x4C
        if(darklord != none)
        {
            darklord.m_bUseWhirlZoom = true;
        }
        super.StartCharge();
        //return;        
    }

    simulated event EndCharge()
    {
        local TgPawn_Darklord darklord;

        darklord = TgPawn_Darklord(Instigator);
        // End:0x4C
        if(darklord != none)
        {
            darklord.m_bUseWhirlZoom = false;
        }
        super.EndCharge();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bCanLeftClickCancel=false
}