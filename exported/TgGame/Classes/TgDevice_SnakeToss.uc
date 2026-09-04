class TgDevice_SnakeToss extends TgDevice
    native(ChampMalDamba)
    hidecategories(Navigation);

var int r_nAmmoCharge;
var TgDevice_MalDambaInhand m_CachedInhand;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_nAmmoCharge;
}

simulated event bool ShouldInterruptReloadOnFire()
{
    return false;
    //return ReturnValue;    
}

simulated function UpdateAmmoCharge()
{
    local TgDeviceFire FireMode;

    // End:0xC2
    if(m_CachedInhand != none)
    {
        FireMode = m_CachedInhand.GetCurrentFire();
        // End:0xC2
        if((FireMode != none) && (FireMode.m_nAmmoClipSize - (GetCurrentAmmoAmount())) > 0)
        {
            r_nAmmoCharge = FireMode.m_nAmmoClipSize - m_CachedInhand.GetCurrentAmmoAmount();
        }
    }
    //return;    
}

simulated function UseNow()
{
    // End:0x3D
    if((Instigator != none) && Instigator.IsLocallyControlled())
    {
        Use();
    }
    //return;    
}

simulated event LinkedDeviceUnequipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceUnequipped(Dev);
    // End:0xB0
    if(Dev.m_nDeviceType == 10828)
    {
        Dev.UnregisterDelegate(4, UseNow);
        Dev.UnregisterDelegate(1, UpdateAmmoCharge);
    }
    //return;    
}

simulated event LinkedDeviceEquipped(TgDevice Dev)
{
    // End:0x11
    if(Dev == none)
    {
        return;
    }
    super.LinkedDeviceEquipped(Dev);
    // End:0xCC
    if(Dev.m_nDeviceType == 10828)
    {
        m_CachedInhand = TgDevice_MalDambaInhand(Dev);
        Dev.RegisterDelegate(4, UseNow);
        Dev.RegisterDelegate(1, UpdateAmmoCharge);
    }
    //return;    
}

defaultproperties
{
    m_vProjectileSpawnOffset=(X=50.0000000,Y=12.0000000,Z=0.0000000)
    m_nLinkedDeviceTypes[0]=10828
}