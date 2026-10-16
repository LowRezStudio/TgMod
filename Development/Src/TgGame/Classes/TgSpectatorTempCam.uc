class TgSpectatorTempCam extends DynamicCameraActor
    hidecategories(Navigation)
    config(Engine);

var bool bIsViewTarget;
var bool bIsBookmark;

event BecomeViewTarget(PlayerController PC) { }

event EndViewTarget(PlayerController PC) { }

event SetIsBookmark(bool bBookmark) { }

function DestroyIfNeeded() { }

defaultproperties
{
    bConstrainAspectRatio=false
}
