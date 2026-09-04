class ActorFactoryStaticMesh extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() StaticMesh StaticMesh;
var() Vector DrawScale3D;

defaultproperties
{
    DrawScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    MenuName="Add StaticMesh"
    MenuPriority=30
    NewActorClass=Class'Engine.StaticMeshActor'
}