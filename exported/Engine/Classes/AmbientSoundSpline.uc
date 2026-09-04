class AmbientSoundSpline extends AmbientSound
    native(Sound)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(Audio,AmbientSoundSpline);

defaultproperties
{
    // Reference: SplineAudioComponent'Engine.Default__AmbientSoundSpline.AudioComponent1'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent1'
    begin object name="AudioComponent1" class=Engine.SplineAudioComponent
        bStopWhenOwnerDestroyed=true
        bShouldRemainActiveIfDropped=true
    end object
    AudioComponent=AudioComponent1
    Components[0]=none
    Components[1]=none
    // Reference: SplineComponentSimplified'Engine.Default__AmbientSoundSpline.SplineComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SplineComponent0'
    begin object name="SplineComponent0" class=Engine.SplineComponentSimplified
        ReplacementPrimitive=none
    end object
    Components[2]=SplineComponent0
    Components[3]=AudioComponent1
}