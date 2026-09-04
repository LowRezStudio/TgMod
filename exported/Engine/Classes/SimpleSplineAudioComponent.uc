class SimpleSplineAudioComponent extends SplineAudioComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent,Object,ActorComponent,Object,ActorComponent);

struct native SplineSoundSlot
{
    var() SoundNodeWave Wave;
    var() float PitchScale;
    var() float VolumeScale;
    var() int StartPoint;
    var() int EndPoint;
    var() float Weight;
    var native const Double LastUpdateTime;
    var native const float SourceInteriorVolume;
    var native const float SourceInteriorLPF;
    var native const float CurrentInteriorVolume;
    var native const float CurrentInteriorLPF;

    structdefaultproperties
    {
        Wave=none
        PitchScale=1.0000000
        VolumeScale=1.0000000
        StartPoint=-1
        EndPoint=-1
        Weight=1.0000000
    }
};

var(LowPassFilter) bool bAttenuateWithLPF;
var(LowPassFilter) float LPFRadiusMin;
var(LowPassFilter) float LPFRadiusMax;
var(Attenuation) float dBAttenuationAtMax;
var(Attenuation) float FlattenAttenuationRadius;
var(Attenuation) SoundNodeAttenuation.SoundDistanceModel DistanceAlgorithm;
var(Attenuation) float RadiusMin;
var(Attenuation) float RadiusMax;
var(Sounds) init array<init SplineSoundSlot> SoundSlots;
var SoundNode NotifyBufferFinishedHook;

defaultproperties
{
    LPFRadiusMin=3000.0000000
    LPFRadiusMax=6000.0000000
    dBAttenuationAtMax=-60.0000000
    FlattenAttenuationRadius=800.0000000
    RadiusMin=200.0000000
    RadiusMax=1200.0000000
    // Reference: ForcedLoopSoundNode'Engine.Default__SimpleSplineAudioComponent.ForcedLoopSoundNode0'
    begin object name="ForcedLoopSoundNode0" class=Engine.ForcedLoopSoundNode
    end object
    NotifyBufferFinishedHook=ForcedLoopSoundNode0
    // Reference: SoundCue'Engine.Default__SimpleSplineAudioComponent.SoundCue0'
    begin object name="SoundCue0" class=Engine.SoundCue
        SoundClass="Ambient"
        FirstNode=ForcedLoopSoundNode'Engine.Default__SimpleSplineAudioComponent.ForcedLoopSoundNode0'
        Duration=10000.0000000
    end object
    SoundCue=SoundCue0
}