class TgDevice_Booster extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation);

// Export UTgDevice_Booster::execCanBeCrippled(FFrame&, void* const)
native function bool CanBeCrippled();

simulated event bool ShouldLockFiring(TgDevice Current)
{
    return false;
    //return ReturnValue;    
}

simulated event bool CanBeCanceled()
{
    return true;
    //return ReturnValue;    
}

simulated event bool CanBeInterrupted()
{
    return false;
    //return ReturnValue;    
}

simulated event bool IsToggleDevice()
{
    return true;
    //return ReturnValue;    
}

simulated state DeviceFiring
{
    simulated function FirePreHitDelay()
    {
        super.FirePreHitDelay();
        ClearTimer('FirePostHitDelay');
        //return;        
    }
    stop;    
}
