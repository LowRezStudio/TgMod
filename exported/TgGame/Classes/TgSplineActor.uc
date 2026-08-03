class TgSplineActor extends SplineActor
    native(Navigation)
    hidecategories(Navigation);

var() TgObject.ELanePusherActionPoint m_ActionPoint;
var(Preview) editoronly transient bool m_bPreview;

// Export UTgSplineActor::execUpdateSplineComponents(FFrame&, void* const)
native function UpdateSplineComponents();

// Export UTgSplineActor::execDistanceToEndOfSplineChain(FFrame&, void* const)
native final function float DistanceToEndOfSplineChain();

// Export UTgSplineActor::execDistanceToActionPoint(FFrame&, void* const)
native final function float DistanceToActionPoint(TgObject.ELanePusherActionPoint ActionPoint);

event OnSplineActorReached(TgPawn_LanePusherBase Other)
{
    //return;    
}

defaultproperties
{
    Components[0]=none
    Components[1]=none
    bNoDelete=true
}