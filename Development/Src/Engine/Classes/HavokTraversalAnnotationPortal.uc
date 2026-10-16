class HavokTraversalAnnotationPortal extends HavokCustomTraversalAnnotation
    native(Havok)
    placeable
    hidecategories(Navigation)
    config(Engine);

native function bool IsValidPortal();  // Export UHavokTraversalAnnotationPortal::execIsValidPortal(FFrame&, void* const)

defaultproperties
{
    TraversalType=TRAVERSALTYPE_PORTAL
}
