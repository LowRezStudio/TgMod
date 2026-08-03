class AmbientSoundMovable extends AmbientSound
    native(Sound)
    placeable
    hidecategories(Navigation)
    autoexpandcategories(Audio);

defaultproperties
{
    // Reference: AudioComponent'Engine.Default__AmbientSoundMovable.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    // Archetype: AudioComponent'Engine.Default__AmbientSound.AudioComponent0'
    begin object name="AudioComponent0"
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
    Physics=EPhysics.PHYS_Interpolating
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
}