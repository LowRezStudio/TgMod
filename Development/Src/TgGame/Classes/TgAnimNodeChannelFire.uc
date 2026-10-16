class TgAnimNodeChannelFire extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

var () TgObject.TG_EQUIP_POINT m_EquipPoint;
var () bool m_bResetOnRelevant;
var () bool m_bCheckAnimSeqForAnim;
var transient bool m_bDoneChanneling;

native function EndChannel();  // Export UTgAnimNodeChannelFire::execEndChannel(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeChannelFire::execReplayAnim(FFrame&, void* const)

native function bool ShouldSetActiveChild(AnimNode pAnimNode);  // Export UTgAnimNodeChannelFire::execShouldSetActiveChild(FFrame&, void* const)

simulated function SetLockedBase(bool bLocked) { }

defaultproperties
{
    m_EquipPoint=EQP_AUTO
    m_bDoneChanneling=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
