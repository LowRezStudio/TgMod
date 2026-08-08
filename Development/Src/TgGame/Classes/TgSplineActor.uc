class TgSplineActor extends SplineActor
    native(Navigation)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var () TgObject.ELanePusherActionPoint m_ActionPoint;
var (Preview) editoronly transient bool m_bPreview;

native function UpdateSplineComponents();  // Export UTgSplineActor::execUpdateSplineComponents(FFrame&, void* const)

native function float DistanceToEndOfSplineChain();  // Export UTgSplineActor::execDistanceToEndOfSplineChain(FFrame&, void* const)

native function float DistanceToActionPoint(TgObject.ELanePusherActionPoint ActionPoint);  // Export UTgSplineActor::execDistanceToActionPoint(FFrame&, void* const)

event OnSplineActorReached(TgPawn_LanePusherBase Other) { }

defaultproperties
{
    Components[0]=none
    Components[1]=none
    bNoDelete=true
}
