class TgAnimNodeToggleWithTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var float m_fTransitionStartTime;
var float m_fTransitionTimeRemaining;

function StartTransition(float transitionPercent, float totalTransitionTime, bool transitionToActive) { }

function SetToggleState(bool IsActive) { }

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
