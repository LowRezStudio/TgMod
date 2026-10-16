class TgAnimNodeBlendByZoomPostFireTransition extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

function StartZoomTransition(float transitionTimeRemaining, bool zoomIn)
{
    // End:0x24
    if(zoomIn)
    {
        SetActiveChild(0, transitionTimeRemaining);        
    }
    else
    {
        SetActiveChild(1, transitionTimeRemaining);
    }
    //return;    
}

function SetZoomState(bool zoomIn)
{
    // End:0x20
    if(zoomIn)
    {
        SetActiveChild(0, 0.0000000);        
    }
    else
    {
        SetActiveChild(1, 0.0000000);
    }
    //return;    
}

defaultproperties
{
    TargetWeight=/* Array type was not detected. */
    Children=/* Array type was not detected. */
    bFixNumChildren=true
    NodeName="ZoomPostFireTransition"
}