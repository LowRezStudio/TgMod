class SimpleSplineNonLoopAudioComponent extends SimpleSplineAudioComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent,Object,ActorComponent,Object,ActorComponent,Object,ActorComponent);

var(Randomized) float DelayMin;
var(Randomized) float DelayMax;
var(Randomized) float PitchMin;
var(Randomized) float PitchMax;
var(Randomized) float VolumeMin;
var(Randomized) float VolumeMax;
var int CurrentSlotIndex;
var float UsedVolumeModulation;
var float UsedPitchModulation;
var float NextSoundTime;

defaultproperties
{
    PitchMin=1.0000000
    PitchMax=1.0000000
    VolumeMin=1.0000000
    VolumeMax=1.0000000
    CurrentSlotIndex=-1
    UsedVolumeModulation=1.0000000
    UsedPitchModulation=1.0000000
    // Reference: ForcedLoopSoundNode'Engine.Default__SimpleSplineNonLoopAudioComponent.ForcedLoopSoundNode0'
    // Archetype: ForcedLoopSoundNode'Engine.Default__SimpleSplineAudioComponent.ForcedLoopSoundNode0'
    begin object name="ForcedLoopSoundNode0"
    end object
    NotifyBufferFinishedHook=ForcedLoopSoundNode0
    // Reference: SoundCue'Engine.Default__SimpleSplineNonLoopAudioComponent.SoundCue0'
    // Archetype: SoundCue'Engine.Default__SimpleSplineAudioComponent.SoundCue0'
    begin object name="SoundCue0"
    end object
    SoundCue=SoundCue0
}