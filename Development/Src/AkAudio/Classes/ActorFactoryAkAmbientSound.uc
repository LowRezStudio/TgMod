class ActorFactoryAkAmbientSound extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() AkEvent AmbientEvent;

defaultproperties
{
    MenuName="Add AkAmbientSound"
    NewActorClass=Class'AkAmbientSound'
}