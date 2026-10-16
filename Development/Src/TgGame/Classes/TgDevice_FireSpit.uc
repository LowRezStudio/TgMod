class TgDevice_FireSpit extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function int GetAimAssistPriority() { }

defaultproperties
{
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceFireSpit'
}
