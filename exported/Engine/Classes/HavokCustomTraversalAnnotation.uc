class HavokCustomTraversalAnnotation extends Actor
    native(Havok)
    placeable
    hidecategories(Navigation);

enum EHavokTraversalType
{
    TRAVERSALTYPE_DROP_DOWN,        // 0
    TRAVERSALTYPE_CLIMB,            // 1
    TRAVERSALTYPE_JUMP,             // 2
    TRAVERSALTYPE_VAULT,            // 3
    TRAVERSALTYPE_DUCK_UNDER,       // 4
    TRAVERSALTYPE_PORTAL,           // 5
    TRAVERSALTYPE_MAX               // 6
};

var() Actor m_Target;
var() HavokCustomTraversalAnnotation.EHavokTraversalType TraversalType;
var() float EdgeCost;
var(NavigationEdge) Rotator SourceEdgeRotation;
var(NavigationEdge) Vector SourceEdgeTranslation;
var(NavigationEdge) float fEdgeWidth;
var(NavigationEdge) bool bForceParallelEdges;
var HavokCustomTraversalAnnotation m_Source;

// Export UHavokCustomTraversalAnnotation::execGetSourceEdge(FFrame&, void* const)
native final function GetSourceEdge(out Vector EdgeStart, out Vector EdgeEnd);

// Export UHavokCustomTraversalAnnotation::execGetDestinationEdge(FFrame&, void* const)
native final function GetDestinationEdge(out Vector EdgeStart, out Vector EdgeEnd);

defaultproperties
{
    EdgeCost=1.0000000
    fEdgeWidth=50.0000000
    bForceParallelEdges=true
    Components[0]=none
    Components[1]=none
}