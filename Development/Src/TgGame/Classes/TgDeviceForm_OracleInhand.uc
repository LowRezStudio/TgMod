class TgDeviceForm_OracleInhand extends TgDeviceForm_Inhand
    native(ChampOracle)
    config(Engine)
    dependson(TgPawn);

var TgPawn_Oracle m_CachedOracle;
var float c_fLastReceivedTransitionInTime;

simulated function bool HasCachedOracle() { }

simulated function TgAnimNodeSlot GetFullBodyAnimNode() { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }

event StopFire(int nFireModeNum) { }

simulated function UpdateAmmoCountSingleFx(TgSpecialFx Fx, float fAmmoPerc) { }

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc) { }

defaultproperties
{
    c_fLastReceivedTransitionInTime=0.2000000
}
