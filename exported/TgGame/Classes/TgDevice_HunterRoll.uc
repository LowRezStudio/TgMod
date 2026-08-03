class TgDevice_HunterRoll extends TgDevice_Charge
    hidecategories(Navigation);

var bool m_bRolledBackward;

simulated function Rotator GetChargeDirection()
{
    // End:0x96
    if((Instigator.Acceleration.X == float(0)) && Instigator.Acceleration.Y == float(0))
    {
        return Instigator.Rotation;        
    }
    else
    {
        return Rotator(Normal2D(Instigator.Acceleration));
    }
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated event StartCharge()
    {
        m_bRolledBackward = (Normal2D(Instigator.Acceleration) Dot Normal2D(Vector(Instigator.Rotation))) < -0.7000000;
        super.StartCharge();
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_bCanLeftClickCancel=false
    m_bPostFireShouldInterruptStealth=false
}