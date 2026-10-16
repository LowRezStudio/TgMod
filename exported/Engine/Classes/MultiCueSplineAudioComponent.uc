class MultiCueSplineAudioComponent extends SplineAudioComponent
    native
    editinlinenew
    collapsecategories
    hidecategories(Object,ActorComponent,Object,ActorComponent,Object,ActorComponent);

struct native MultiCueSplineSoundSlot
{
    var() SoundCue SoundCue;
    var() float PitchScale;
    var() float VolumeScale;
    var() int StartPoint;
    var() int EndPoint;
    var native const Double LastUpdateTime;
    var native const float SourceInteriorVolume;
    var native const float SourceInteriorLPF;
    var native const float CurrentInteriorVolume;
    var native const float CurrentInteriorLPF;
    var bool bPlaying;

    structdefaultproperties
    {
        SoundCue=none
        PitchScale=1.0000000
        VolumeScale=1.0000000
        StartPoint=-1
        EndPoint=-1
        bPlaying=false
    }
};

var(Sounds) init array<init MultiCueSplineSoundSlot> SoundSlots;
var int CurrentSlotIndex;
