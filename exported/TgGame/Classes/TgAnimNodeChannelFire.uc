class TgAnimNodeChannelFire extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() TgObject.TG_EQUIP_POINT m_EquipPoint;
var() bool m_bResetOnRelevant;
var() bool m_bCheckAnimSeqForAnim;
var transient bool m_bDoneChanneling;

// Export UTgAnimNodeChannelFire::execEndChannel(FFrame&, void* const)
native function EndChannel();

// Export UTgAnimNodeChannelFire::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

// Export UTgAnimNodeChannelFire::execShouldSetActiveChild(FFrame&, void* const)
native function bool ShouldSetActiveChild(AnimNode pAnimNode);

simulated function SetLockedBase(bool bLocked)
{
    //return;    
}

defaultproperties
{
    m_EquipPoint=TG_EQUIP_POINT.EQP_AUTO
    m_bDoneChanneling=true
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}