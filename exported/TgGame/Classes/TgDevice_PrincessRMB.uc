class TgDevice_PrincessRMB extends TgDevice
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x0F
    if(IsFiring())
    {
        return true;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

defaultproperties
{
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Princess.DeviceInhand'
}