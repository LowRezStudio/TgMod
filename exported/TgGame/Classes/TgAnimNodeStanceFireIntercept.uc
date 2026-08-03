class TgAnimNodeStanceFireIntercept extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() int m_nStanceToAllow;
var int m_nCurrentStance;

// Export UTgAnimNodeStanceFireIntercept::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float Rate = 1.0000000, optional float StartTime = 0.0000000);

// Export UTgAnimNodeStanceFireIntercept::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}