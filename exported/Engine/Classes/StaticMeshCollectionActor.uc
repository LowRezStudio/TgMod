class StaticMeshCollectionActor extends StaticMeshActorBase
    native
    config(Engine)
    placeable
    hidecategories(Navigation);

var const export editinline array<export editinline StaticMeshComponent> StaticMeshComponents;
var config int MaxStaticMeshComponents;

defaultproperties
{
    MaxStaticMeshComponents=100
}