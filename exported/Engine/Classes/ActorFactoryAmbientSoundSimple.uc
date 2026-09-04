class ActorFactoryAmbientSoundSimple extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() SoundNodeWave SoundNodeWave;

defaultproperties
{
    MenuName="Add AmbientSoundSimple"
    MenuPriority=11
    NewActorClass=Class'Engine.AmbientSoundSimple'
}