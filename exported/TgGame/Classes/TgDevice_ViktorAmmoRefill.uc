class TgDevice_ViktorAmmoRefill extends TgDevice
    hidecategories(Navigation);

simulated function FireAmmunition()
{
    local TgPawn_Viktor Viktor;

    super.FireAmmunition();
    // End:0xDB
    if(int(Role) == int(ROLE_Authority))
    {
        Viktor = TgPawn_Viktor(Instigator);
        // End:0xDB
        if(Viktor != none)
        {
            Viktor.r_nAmmoRefreshSound++;
            Viktor.bNetDirty = true;
            // End:0xDB
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                Viktor.PlayLocalPawnFX('ViktorRefreshAmmo');
            }
        }
    }
    //return;    
}
