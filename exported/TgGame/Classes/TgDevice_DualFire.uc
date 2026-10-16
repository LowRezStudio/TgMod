class TgDevice_DualFire extends TgDevice_ToggleWithLockout
    hidecategories(Navigation);

//var delegate<InterruptFiringDelegate> __InterruptFiringDelegate__Delegate;

simulated delegate InterruptFiringDelegate()
{
    // End:0x1E
    if(int(Role) == int(ROLE_AutonomousProxy))
    {
        ClientInterrupt();
    }
    InterruptFiring();
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
        // End:0x89
        case 13218:
            Dev.RegisterDelegate(2, InterruptFiringDelegate);
            // End:0x8C
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
        // End:0x89
        case 13218:
            Dev.UnregisterDelegate(2, InterruptFiringDelegate);
            // End:0x8C
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=13218
}