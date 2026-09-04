class TgDeviceForm_Telepunch extends TgDeviceForm
    native(ChampDemon)
    config(Engine)
    dependson(TgPawn);

var bool m_bFOVZoomActive;
var bool m_bUltFxActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVMultiplier;

event Generic1(optional byte byExtraData) { }

event Generic2(optional byte byExtraData) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }

simulated function TriggerFOVZoom(bool bActive) { }

simulated function EnableUltFx(bool bActive) { }

simulated function SetEnemyUIOverrides(bool bActive) { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.3300000
    m_fFOVMultiplier=0.5000000
}
