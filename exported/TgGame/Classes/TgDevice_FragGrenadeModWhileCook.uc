class TgDevice_FragGrenadeModWhileCook extends TgDevice
    hidecategories(Navigation);

function ApplyHitSpecial()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x5F
    if((FireMode != none) && Instigator != none)
    {
        FireMode.ApplyHitSpecial(Instigator);
    }
    //return;    
}

function RemoveHitSpecial()
{
    local TgDeviceFire FireMode;

    FireMode = GetCurrentFire();
    // End:0x5F
    if((FireMode != none) && Instigator != none)
    {
        FireMode.RemoveHitSpecial(Instigator, true);
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
    switch(Dev.r_nDeviceId)
    {
        // End:0xCF
        case 14149:
            // End:0xCC
            if(int(Role) == int(ROLE_Authority))
            {
                Dev.RegisterDelegate(4, ApplyHitSpecial);
                Dev.RegisterDelegate(5, RemoveHitSpecial);
            }
            // End:0xD2
            break;
        // End:0xFFFF
        default:
            break;
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
    switch(Dev.r_nDeviceId)
    {
        // End:0xCF
        case 14149:
            // End:0xCC
            if(int(Role) == int(ROLE_Authority))
            {
                Dev.UnregisterDelegate(4, ApplyHitSpecial);
                Dev.UnregisterDelegate(5, RemoveHitSpecial);
            }
            // End:0xD2
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14149
}