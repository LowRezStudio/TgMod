class ActorFactoryFracturedStaticMesh extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() FracturedStaticMesh FracturedStaticMesh;
var() Vector DrawScale3D;

defaultproperties
{
    DrawScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    MenuName="Add FracturedStaticMesh"
    MenuPriority=35
    NewActorClass=Class'Engine.FracturedStaticMeshActor'
}