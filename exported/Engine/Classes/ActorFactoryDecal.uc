class ActorFactoryDecal extends ActorFactory
    native(Decal)
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() MaterialInterface DecalMaterial;

defaultproperties
{
    MenuName="Add Decal"
    MenuPriority=15
    NewActorClass=Class'Engine.DecalActor'
}