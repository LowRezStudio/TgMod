class TgDeviceForm_Scope extends TgDeviceForm_ToggleWithLockout
    native(ChampOwl)
    config(Engine);

var float m_fTransitionAmount;
var float m_fTransitionPerSec;
var const float m_fWeaponZoomFOV;

event StopFire(int nFireModeNum) { }

simulated event SetToggleState(bool bIsActive) { }

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

simulated function EnableZoom(bool bIsActive) { }

defaultproperties
{
    m_fWeaponZoomFOV=45.0000000
    m_GameplayCurves=TgGameplayCurves'DeviceInhand'
}
