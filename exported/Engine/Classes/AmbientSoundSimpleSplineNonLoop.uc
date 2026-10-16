class AmbientSoundSimpleSplineNonLoop extends AmbientSoundSimpleSpline
    placeable
    hidecategories(Navigation)
    autoexpandcategories(Audio,AmbientSoundSpline);

defaultproperties
{
    // Reference: SimpleSplineNonLoopAudioComponent'Engine.Default__AmbientSoundSimpleSplineNonLoop.AudioComponent3'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent3'
    begin object name="AudioComponent3" class=Engine.SimpleSplineNonLoopAudioComponent
        bStopWhenOwnerDestroyed=true
        bShouldRemainActiveIfDropped=true
    end object
    AudioComponent=AudioComponent3
    Components[0]=none
    Components[1]=none
    // Reference: SplineComponentSimplified'Engine.Default__AmbientSoundSimpleSplineNonLoop.SplineComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SplineComponent0'
    // Archetype: SplineComponentSimplified'Engine.Default__AmbientSoundSimpleSpline.SplineComponent0'
    begin object name="SplineComponent0"
        ReplacementPrimitive=none
    end object
    Components[2]=SplineComponent0
    Components[3]=AudioComponent3
}