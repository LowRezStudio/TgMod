class TgDeviceFire_ShieldFernando extends TgDeviceFire;

simulated event float GetCooldownTime()
{
    local TgDevice Dev, Aegis;
    local TgDeviceFire AegisFire;
    local TgPawn TgP;
    local float fBaseCooldown, fCooldown;
    local TgProperty CooldownProperty;

    fCooldown = super.GetCooldownTime();
    Dev = TgDevice(m_Owner);
    // End:0x18D
    if(Dev != none)
    {
        TgP = TgPawn(Dev.Instigator);
        // End:0x18D
        if(TgP != none)
        {
            Aegis = TgP.GetActiveDeviceByClass('TgDevice_Aegis');
            // End:0x18D
            if(Aegis != none)
            {
                AegisFire = Aegis.GetCurrentFire();
                // End:0x18D
                if(AegisFire != none)
                {
                    CooldownProperty = GetProperty(4);
                    // End:0x18D
                    if(CooldownProperty != none)
                    {
                        fBaseCooldown = CooldownProperty.m_fBase;
                        // End:0x18D
                        if(fBaseCooldown > 0.0000000)
                        {
                            fCooldown *= (AegisFire.GetCustomValue1() / fBaseCooldown);
                        }
                    }
                }
            }
        }
    }
    return fCooldown;
    //return ReturnValue;    
}
