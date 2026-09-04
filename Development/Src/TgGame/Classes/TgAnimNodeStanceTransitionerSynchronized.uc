class TgAnimNodeStanceTransitionerSynchronized extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

struct StanceTransitionParam {
    var () int FromChild;
    var () int ToChild;
    structdefaultproperties {}
};

var () float StanceResetTime;
var () bool CanResetStanceOnTick;
var bool m_bDelayingChildSwitch;
var int m_nCurrentStance;
var float m_fTimestampToSwitchStance;
var () array<StanceTransitionParam> StanceTransitionControl;

native function ChangeStance(int Stance, optional bool bAutoSync=true, optional bool bForceUpdate=false);  // Export UTgAnimNodeStanceTransitionerSynchronized::execChangeStance(FFrame&, void* const)

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimNodeStanceTransitionerSynchronized::execPlayAnim(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeStanceTransitionerSynchronized::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    StanceResetTime=3.0000000
    Children=/* Array type was not detected. */
}
