class ActorFactoryLight extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

defaultproperties
{
    MenuName="Add Light (Point)"
    MenuPriority=20
    NewActorClass=Class'Engine.PointLight'
    bShowInEditorQuickMenu=true
}