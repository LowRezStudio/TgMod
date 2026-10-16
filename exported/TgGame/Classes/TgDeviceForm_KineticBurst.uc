class TgDeviceForm_KineticBurst extends TgDeviceForm
    native(ChampFlak);

var float RampUpTime;
var float RampDownTime;
var MaterialInstanceConstant GlowMIC;

// Export UTgDeviceForm_KineticBurst::execHasCachedMIC(FFrame&, void* const)
native function bool HasCachedMIC();

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining)
{
    local TgPawn_Flak pFlak;

    super.StartFire(nFireMode, fRefireTime, Target, nAmmoRemaining);
    pFlak = TgPawn_Flak(PawnOwner);
    // End:0xB1
    if(pFlak != none)
    {
        pFlak.ClearTimer('RampUpTimer');
        pFlak.SetTimer(RampUpTime, false, 'RampUpTimer');
    }
    //return;    
}

event Cooldown(int nFireModeNum)
{
    local TgPawn_Flak pFlak;

    super.Cooldown(nFireModeNum);
    pFlak = TgPawn_Flak(PawnOwner);
    // End:0x93
    if(pFlak != none)
    {
        pFlak.ClearTimer('RampDownTimer');
        pFlak.SetTimer(RampDownTime, false, 'RampDownTimer');
    }
    //return;    
}

defaultproperties
{
    RampUpTime=1.0000000
    RampDownTime=0.5000000
}