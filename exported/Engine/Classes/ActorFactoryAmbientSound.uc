class ActorFactoryAmbientSound extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() SoundCue AmbientSoundCue;

defaultproperties
{
    MenuName="Add AmbientSound"
    MenuPriority=11
    NewActorClass=Class'Engine.AmbientSound'
    bShowInEditorQuickMenu=true
}