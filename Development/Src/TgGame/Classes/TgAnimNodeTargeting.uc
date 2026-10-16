class TgAnimNodeTargeting extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT m_EquipPoint;
var () bool m_bResetOnRelevant;
var transient bool m_bDoneTargeting;

native function InterruptTargeting();  // Export UTgAnimNodeTargeting::execInterruptTargeting(FFrame&, void* const)

native function EndTargeting();  // Export UTgAnimNodeTargeting::execEndTargeting(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeTargeting::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    m_EquipPoint=EQP_OFFHAND_3
    m_bDoneTargeting=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
