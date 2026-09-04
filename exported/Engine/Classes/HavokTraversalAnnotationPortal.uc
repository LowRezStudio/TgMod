class HavokTraversalAnnotationPortal extends HavokCustomTraversalAnnotation
    native(Havok)
    placeable
    hidecategories(Navigation);

// Export UHavokTraversalAnnotationPortal::execIsValidPortal(FFrame&, void* const)
native final function bool IsValidPortal();

defaultproperties
{
    TraversalType=EHavokTraversalType.TRAVERSALTYPE_PORTAL
}