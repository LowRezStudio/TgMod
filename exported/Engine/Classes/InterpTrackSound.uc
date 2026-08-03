class InterpTrackSound extends InterpTrackVectorBase
    native(Interpolation)
    collapsecategories
    hidecategories(Object);

struct native SoundTrackKey
{
    var float Time;
    var float Volume;
    var float Pitch;
    var() SoundCue Sound;

    structdefaultproperties
    {
        Time=0.0000000
        Volume=1.0000000
        Pitch=1.0000000
        Sound=none
    }
};

var array<SoundTrackKey> Sounds;
var() bool bPlayOnReverse;
var() bool bContinueSoundOnMatineeEnd;
var() bool bSuppressSubtitles;
var() bool bTreatAsDialogue;

defaultproperties
{
    TrackInstClass=Class'Engine.InterpTrackInstSound'
    TrackTitle="Sound"
}