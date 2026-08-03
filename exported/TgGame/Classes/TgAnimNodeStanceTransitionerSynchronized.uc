class TgAnimNodeStanceTransitionerSynchronized extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

struct native StanceTransitionParam
{
    var() int FromChild;
    var() int ToChild;

    structdefaultproperties
    {
        FromChild=0
        ToChild=0
    }
};

var() float StanceResetTime;
var() bool CanResetStanceOnTick;
var bool m_bDelayingChildSwitch;
var int m_nCurrentStance;
var float m_fTimestampToSwitchStance;
var() array<StanceTransitionParam> StanceTransitionControl;

// Export UTgAnimNodeStanceTransitionerSynchronized::execChangeStance(FFrame&, void* const)
native function ChangeStance(int Stance, optional bool bAutoSync = true, optional bool bForceUpdate = false);

// Export UTgAnimNodeStanceTransitionerSynchronized::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float Rate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimNodeStanceTransitionerSynchronized::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    StanceResetTime=3.0000000
    Children=/* Array type was not detected. */
}