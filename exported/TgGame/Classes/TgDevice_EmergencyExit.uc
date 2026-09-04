class TgDevice_EmergencyExit extends TgDevice
    native(ChampSkye)
    hidecategories(Navigation);

simulated event bool StartFire()
{
    // End:0x40
    if(int(TgPawn(Owner).r_eIsStealthed) == int(0))
    {
        return super.StartFire();        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
