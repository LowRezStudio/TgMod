class SpeedTreeActorFactory extends ActorFactory
    native(SpeedTree)
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() SpeedTree SpeedTree;

defaultproperties
{
    MenuName="Add SpeedTree"
    NewActorClass=Class'Engine.SpeedTreeActor'
}