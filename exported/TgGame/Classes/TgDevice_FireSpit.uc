class TgDevice_FireSpit extends TgDevice
    hidecategories(Navigation);

simulated event bool ShouldLockFiring(TgDevice Current)
{
    // End:0x54
    if(((Current != none) && Current.r_nDeviceId == 13328) && IsTimerActive('FirePostHitDelay'))
    {
        return false;
    }
    return super.ShouldLockFiring(Current);
    //return ReturnValue;    
}

simulated function int GetAimAssistPriority()
{
    // End:0x32
    if((IsFiring()) || self.m_FiredProjectiles.Length != 0)
    {
        return 1000;
    }
    return -1;
    //return ReturnValue;    
}

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_GameplayCurvesDeprecated=TgGameplayCurves'GP_Drogoz.DeviceFireSpit'
}