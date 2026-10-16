class TgDevice_Compensator extends TgDevice
    hidecategories(Navigation);

simulated function ApplyRecoilReduction(TgDevice Dev, bool bShouldApply)
{
    local TgDevice_ViktorInhand inhand;

    inhand = TgDevice_ViktorInhand(Dev);
    // End:0x7E
    if(inhand != none)
    {
        inhand.m_fADSRecoilMultiplier = ((bShouldApply) ? GetCurrentFire().GetCustomValue1() : 1.0000000);
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
        // End:0x6B
        case 14127:
            ApplyRecoilReduction(Dev, true);
            // End:0x6E
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
        // End:0x6B
        case 14127:
            ApplyRecoilReduction(Dev, false);
            // End:0x6E
            break;
        // End:0xFFFF
        default:
            break;
    }
    //return;    
}

defaultproperties
{
    m_nLinkedDeviceIDs[0]=14127
}