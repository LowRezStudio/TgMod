class LandscapeGizmoActor extends Actor
    native(Terrain)
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    Components[0]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=true
    bMovable=false
    bEditable=false
}