class TgAnimNodeToggleWithTransition_Disengage extends TgAnimNodeToggleWithTransition
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var int m_nPendingChildIndex;
var bool m_bForceNewActiveChild;

native function SetActiveChild(INT ChildIndex, FLOAT BlendTime);  // Export UTgAnimNodeToggleWithTransition_Disengage::execSetActiveChild(FFrame&, void* const)

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimNodeToggleWithTransition_Disengage::execPlayAnim(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimNodeToggleWithTransition_Disengage::execReplayAnim(FFrame&, void* const)

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
}
