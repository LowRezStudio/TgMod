class TgAnimNodeBlendByZoomPostFireTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

function StartZoomTransition(float transitionTimeRemaining, bool zoomIn) { }

function SetZoomState(bool zoomIn) { }

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="ZoomPostFireTransition"
}
