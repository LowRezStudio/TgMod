class TgDeviceFire_Soar extends TgDeviceFire;

simulated event float GetMinCooldownTime()
{
    local TgDevice Dev;
    local TgPawn TgP;
    local TgDevice_OverTheMoon OverTheMoonDevice;
    local TgDeviceFire OverTheMoonDeviceFire;

    Dev = TgDevice(m_Owner);
    // End:0x10D
    if(Dev != none)
    {
        TgP = TgPawn(Dev.Instigator);
        // End:0x10D
        if(TgP != none)
        {
            OverTheMoonDevice = TgDevice_OverTheMoon(TgP.GetActiveDeviceByClass('TgDevice_OverTheMoon'));
            // End:0x10D
            if(OverTheMoonDevice != none)
            {
                OverTheMoonDeviceFire = OverTheMoonDevice.GetCurrentFire();
                // End:0x10D
                if(OverTheMoonDeviceFire != none)
                {
                    return OverTheMoonDeviceFire.GetCustomValue1();
                }
            }
        }
    }
    return super.GetMinCooldownTime();
    //return ReturnValue;    
}
