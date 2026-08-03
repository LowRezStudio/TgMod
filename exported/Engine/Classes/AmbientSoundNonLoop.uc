class AmbientSoundNonLoop extends AmbientSoundSimple
    native(Sound)
    placeable
    hidecategories(Navigation,Audio)
    autoexpandcategories(Audio,AmbientSoundSimple);

defaultproperties
{
    // Reference: SoundCue'Engine.Default__AmbientSoundNonLoop.SoundCue0'
    // Archetype: SoundCue'Engine.Default__AmbientSoundSimple.SoundCue0'
    begin object name="SoundCue0"
    end object
    SoundCueInstance=SoundCue0
    // Reference: SoundNodeAmbientNonLoop'Engine.Default__AmbientSoundNonLoop.SoundNodeAmbientNonLoop0'
    begin object name="SoundNodeAmbientNonLoop0" class=Engine.SoundNodeAmbientNonLoop
    end object
    SoundNodeInstance=SoundNodeAmbientNonLoop0
    // Reference: AudioComponent'Engine.Default__AmbientSoundNonLoop.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    // Archetype: AudioComponent'Engine.Default__AmbientSoundSimple.AudioComponent0'
    begin object name="AudioComponent0"
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
    DrawScale=2.0000000
}