class Portal extends TriggerVolume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display);

var() Actor Destination;
var(NavigationEdge) Rotator SourceEdgeRotation;
var(NavigationEdge) Vector SourceEdgeTranslation;
var(NavigationEdge) float fEdgeWidth;
var(NavigationEdge) bool bForceParallelEdges;

// Export UPortal::execIsValidPortal(FFrame&, void* const)
native final function bool IsValidPortal();

// Export UPortal::execGetSourceEdge(FFrame&, void* const)
native final function GetSourceEdge(out Vector EdgeStart, out Vector EdgeEnd);

// Export UPortal::execGetDestinationEdge(FFrame&, void* const)
native final function GetDestinationEdge(out Vector EdgeStart, out Vector EdgeEnd);

defaultproperties
{
    fEdgeWidth=50.0000000
    bForceParallelEdges=true
    // Reference: BrushComponent'Engine.Default__Portal.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__TriggerVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    Components[2]=none
    bProjTarget=false
    CollisionComponent=BrushComponent0
    SupportedEvents=none
}