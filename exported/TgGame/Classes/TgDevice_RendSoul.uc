class TgDevice_RendSoul extends TgDevice
    native(ChampOracle)
    hidecategories(Navigation);

var bool m_bApplyCooldown;

// Export UTgDevice_RendSoul::execCanDeviceFireNow(FFrame&, void* const)
native function bool CanDeviceFireNow(byte FireModeNum, AimData Aim, bool bDeviceFailLog, out TgObject.EDeviceFailType failType);

simulated event bool ShouldCooldownAfterFire()
{
    return false;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function StartFiringLogic()
    {
        super.StartFiringLogic();
        m_bApplyCooldown = false;
        //return;        
    }

    simulated function StopFiringLogic()
    {
        super.StopFiringLogic();
        // End:0x39
        if(m_bApplyCooldown && int(Role) == int(ROLE_Authority))
        {
            StartCooldown();
        }
        //return;        
    }
    stop;    
}
