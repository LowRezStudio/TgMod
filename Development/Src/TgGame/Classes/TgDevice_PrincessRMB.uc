class TgDevice_PrincessRMB extends TgDevice
    hidecategories(Navigation)
    config(Engine);

simulated event bool ShouldLockFiring(TgDevice Current) { }

defaultproperties
{
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
}
