class Portal extends TriggerVolume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var () Actor Destination;
var (NavigationEdge) Rotator SourceEdgeRotation;
var (NavigationEdge) Vector SourceEdgeTranslation;
var (NavigationEdge) float fEdgeWidth;
var (NavigationEdge) bool bForceParallelEdges;

native function bool IsValidPortal();  // Export UPortal::execIsValidPortal(FFrame&, void* const)

native function GetSourceEdge(out Vector EdgeStart, out Vector EdgeEnd);  // Export UPortal::execGetSourceEdge(FFrame&, void* const)

native function GetDestinationEdge(out Vector EdgeStart, out Vector EdgeEnd);  // Export UPortal::execGetDestinationEdge(FFrame&, void* const)

defaultproperties
{}
