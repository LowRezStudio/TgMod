class InstancedFoliageActor extends Actor
    native(Foliage)
    notplaceable
    hidecategories(Navigation,Object);

var native const Map_Mirror FoliageMeshes;
var const transient StaticMesh SelectedMesh;
var const export editinline transient array<export editinline InstancedStaticMeshComponent> InstancedStaticMeshComponents;

defaultproperties
{
    bStatic=true
    bCollideActors=true
    bBlockActors=true
}