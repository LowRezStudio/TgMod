class AmbientSoundNonLoopingToggleable extends AmbientSoundSimpleToggleable
    native(Sound)
    placeable
    hidecategories(Navigation,Audio)
    autoexpandcategories(Audio,AmbientSoundSimple,AmbientSoundSimpleToggleable);

defaultproperties
{
    // Reference: SoundCue'Engine.Default__AmbientSoundNonLoopingToggleable.SoundCue0'
    // Archetype: SoundCue'Engine.Default__AmbientSoundSimpleToggleable.SoundCue0'
    begin object name="SoundCue0"
    end object
    SoundCueInstance=SoundCue0
    // Reference: SoundNodeAmbientNonLoopToggle'Engine.Default__AmbientSoundNonLoopingToggleable.SoundNodeAmbientNonLoopToggle0'
    begin object name="SoundNodeAmbientNonLoopToggle0" class=Engine.SoundNodeAmbientNonLoopToggle
    end object
    SoundNodeInstance=SoundNodeAmbientNonLoopToggle0
    // Reference: AudioComponent'Engine.Default__AmbientSoundNonLoopingToggleable.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    // Archetype: AudioComponent'Engine.Default__AmbientSoundSimpleToggleable.AudioComponent0'
    begin object name="AudioComponent0"
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
}