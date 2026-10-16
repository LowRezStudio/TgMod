class TgAnimNodeFitToDuration extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object);

var() protected float Duration;
var float OverrideDuration;
var() bool bAllowIncreasedPlayRate;
var() bool bAllowDecreasedPlayRate;
var() bool bClampDuration;
var() bool m_bScaleByReload;
var() float ClampedMinDuration;
var() float ClampedMaxDuration;
var() TgObject.TG_EQUIP_POINT m_EquipPoint;
var() float m_fDurationMultiplier;

defaultproperties
{
    Duration=1.0000000
    bAllowIncreasedPlayRate=true
    m_EquipPoint=TG_EQUIP_POINT.EQP_AUTO
    m_fDurationMultiplier=1.0000000
    Children=/* Array type was not detected. */
    NodeName="FitToDuration"
}