class TgAnimNodeTargeting extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() TgObject.TG_EQUIP_POINT m_EquipPoint;
var() bool m_bResetOnRelevant;
var transient bool m_bDoneTargeting;

// Export UTgAnimNodeTargeting::execInterruptTargeting(FFrame&, void* const)
native function InterruptTargeting();

// Export UTgAnimNodeTargeting::execEndTargeting(FFrame&, void* const)
native function EndTargeting();

// Export UTgAnimNodeTargeting::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    m_EquipPoint=TG_EQUIP_POINT.EQP_OFFHAND_3
    m_bDoneTargeting=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}