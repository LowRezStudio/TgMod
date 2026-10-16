class TgAnimNodeStanceFireIntercept extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () int m_nStanceToAllow;
var int m_nCurrentStance;

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimNodeStanceFireIntercept::execPlayAnim(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeStanceFireIntercept::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
