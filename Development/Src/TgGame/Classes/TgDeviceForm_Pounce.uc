class TgDeviceForm_Pounce extends TgDeviceForm
    native(ChampBlades)
    config(Engine)
    dependson(TgObject);

var array<TgAnimNodeChannelFire_Pounce> m_PounceNodes3p;
var array<TgAnimNodeChannelFire_Pounce> m_PounceNodes1p;
var bool bFOVZoomActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVModifier;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

event SetPounceNodeHitSuccessful(bool bSuccessfulHit) { }

event Generic1(optional byte byExtraData) { }

event Generic2(optional byte byExtraData) { }

event StopFire(int nFireModeNum) { }

simulated function TriggerFOVZoom(bool bActive) { }

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.1200000
    m_fFOVModifier=10.0000000
}
