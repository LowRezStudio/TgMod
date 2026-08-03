class TgDevice_Requip extends TgDevice
    native(ChampLex)
    hidecategories(Navigation);

var TgDevice m_InhandWeapon;

simulated event bool ShouldCooldownAfterFire()
{
    m_InhandWeapon = TgPawn(Owner).GetDeviceByEqPoint(1);
    // End:0x7B
    if(m_InhandWeapon.m_bAmmoWasGiven)
    {
        m_InhandWeapon.m_bAmmoWasGiven = false;
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}
