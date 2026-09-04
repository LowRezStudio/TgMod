class TgDevice_Recovery extends TgDevice_Stim
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x31
    if(super.ShouldLockFiring(Current))
    {
        // End:0x2F
        if(IsTimerActive('FirePostHitDelay'))
        {
            return false;
        }
        return true;
    }
    return false;
    //return ReturnValue;    
}
