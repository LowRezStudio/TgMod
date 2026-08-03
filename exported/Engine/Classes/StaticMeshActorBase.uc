class StaticMeshActorBase extends Actor
    abstract
    native
    notplaceable
    hidecategories(Navigation)
    classgroup(StaticMeshes);

defaultproperties
{
    bStatic=true
    bWorldGeometry=true
    bRouteBeginPlayEvenIfStatic=false
    bGameRelevant=true
    bMovable=false
    bCollideActors=true
    bBlockActors=true
    bEdShouldSnap=true
}