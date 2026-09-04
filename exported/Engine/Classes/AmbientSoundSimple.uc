class AmbientSoundSimple extends AmbientSound
    native(Sound)
    placeable
    hidecategories(Navigation,Audio)
    autoexpandcategories(Audio,AmbientSoundSimple);

var() editconst editinline SoundNodeAmbient AmbientProperties;
var const export editinline SoundCue SoundCueInstance;
var const export editinline SoundNodeAmbient SoundNodeInstance;

defaultproperties
{
    // Reference: SoundCue'Engine.Default__AmbientSoundSimple.SoundCue0'
    begin object name="SoundCue0" class=Engine.SoundCue
        SoundClass="Ambient"
    end object
    SoundCueInstance=SoundCue0
    // Reference: SoundNodeAmbient'Engine.Default__AmbientSoundSimple.SoundNodeAmbient0'
    begin object name="SoundNodeAmbient0" class=Engine.SoundNodeAmbient
    end object
    SoundNodeInstance=SoundNodeAmbient0
    // Reference: AudioComponent'Engine.Default__AmbientSoundSimple.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    // Archetype: AudioComponent'Engine.Default__AmbientSound.AudioComponent0'
    begin object name="AudioComponent0"
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
}