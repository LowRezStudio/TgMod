class TgDeviceForm_Spite extends TgDeviceForm
    native(ChampDarklord)
    config(Engine)
    dependson(TgPawn);

var array<TgAnimNodeChannelFire_Spite> m_SpiteNodes3p;
var array<TgAnimNodeChannelFire_Spite> m_SpiteNodes1p;
var array<TgAnimBlendByPaladinsCharacter_Darklord> m_DarklordNodes1p;
var bool bFOVZoomActive;
var float m_fCameraFOVInterpolationTime;
var float m_fFOVModifier;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Generic1(optional byte byExtraData) { }

event Generic2(optional byte byExtraData) { }

event Generic3(optional byte byExtraData) { }

event Generic4(optional byte byExtraData) { }

event Generic5(optional byte byExtraData) { }

event StopFire(int nFireModeNum) { }

simulated function TriggerFOVZoom(bool bActive) { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }

defaultproperties
{
    m_fCameraFOVInterpolationTime=0.1200000
    m_fFOVModifier=10.0000000
}
