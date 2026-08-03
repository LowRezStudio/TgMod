class AmbientSound extends Keypoint
    native(Sound)
    placeable
    hidecategories(Navigation)
    classgroup(Sounds)
    autoexpandcategories(Audio);

var() bool bAutoPlay;
var private bool bIsPlaying;
var(Audio) const editconst export editinline AudioComponent AudioComponent;

defaultproperties
{
    bAutoPlay=true
    // Reference: AudioComponent'Engine.Default__AmbientSound.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    begin object name="AudioComponent0" class=Engine.AudioComponent
        bStopWhenOwnerDestroyed=true
        bShouldRemainActiveIfDropped=true
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
}