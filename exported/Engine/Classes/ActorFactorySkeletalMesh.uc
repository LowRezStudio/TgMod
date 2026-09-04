class ActorFactorySkeletalMesh extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() SkeletalMesh SkeletalMesh;
var() AnimSet AnimSet;
var() name AnimSequenceName;

defaultproperties
{
    GameplayActorClass=Class'Engine.SkeletalMeshActorSpawnable'
    MenuName="Add SkeletalMesh"
    MenuPriority=13
    NewActorClass=Class'Engine.SkeletalMeshActor'
}