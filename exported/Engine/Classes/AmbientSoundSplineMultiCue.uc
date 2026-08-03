class AmbientSoundSplineMultiCue extends AmbientSoundSpline
    native(Sound)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(Audio,AmbientSoundSpline);

defaultproperties
{
    // Reference: MultiCueSplineAudioComponent'Engine.Default__AmbientSoundSplineMultiCue.AudioComponent2'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent2'
    begin object name="AudioComponent2" class=Engine.MultiCueSplineAudioComponent
        bStopWhenOwnerDestroyed=true
        bShouldRemainActiveIfDropped=true
    end object
    AudioComponent=AudioComponent2
    Components[0]=none
    Components[1]=none
    // Reference: SplineComponentSimplified'Engine.Default__AmbientSoundSplineMultiCue.SplineComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SplineComponent0'
    // Archetype: SplineComponentSimplified'Engine.Default__AmbientSoundSpline.SplineComponent0'
    begin object name="SplineComponent0"
        ReplacementPrimitive=none
    end object
    Components[2]=SplineComponent0
    Components[3]=AudioComponent2
}