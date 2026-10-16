class TgSpectatorTempCam extends DynamicCameraActor
    hidecategories(Navigation);

var bool bIsViewTarget;
var bool bIsBookmark;

event BecomeViewTarget(PlayerController PC)
{
    super(Actor).BecomeViewTarget(PC);
    bIsViewTarget = true;
    FOVAngle = PC.FOVAngle;
    //return;    
}

event EndViewTarget(PlayerController PC)
{
    super(Actor).EndViewTarget(PC);
    bIsViewTarget = false;
    DestroyIfNeeded();
    //return;    
}

event SetIsBookmark(bool bBookmark)
{
    bIsBookmark = bBookmark;
    DestroyIfNeeded();
    //return;    
}

function DestroyIfNeeded()
{
    // End:0x23
    if(!bIsViewTarget && !bIsBookmark)
    {
        Destroy();
    }
    //return;    
}

defaultproperties
{
    bConstrainAspectRatio=false
}