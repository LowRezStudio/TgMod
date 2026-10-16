class TgAnimNodeBlendByZoomTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var float m_fTransitionStartTime;

function StartZoomTransition(float zoomPercent, float totalTransitionTime, bool zoomIn) { }

function SetZoomState(bool zoomIn) { }

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="ZoomTransition"
}
