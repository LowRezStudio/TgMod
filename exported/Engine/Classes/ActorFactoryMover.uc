class ActorFactoryMover extends ActorFactoryDynamicSM
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

defaultproperties
{
    MenuName="Add InterpActor"
    MenuPriority=25
    NewActorClass=Class'Engine.InterpActor'
}