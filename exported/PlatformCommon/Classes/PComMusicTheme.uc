class PComMusicTheme extends Object
    native(Audio)
    hidecategories(Object);

struct native MusicEvent
{
    var() name EventName;
    var() MusicTrackStruct EventTrack;
    var() float EventDuration;

    structdefaultproperties
    {
        EventName="None"
        EventTrack=(TheSoundCue=none,bAutoPlay=false,bPersistentAcrossLevels=false,FadeInTime=5.0000000,FadeInVolumeLevel=1.0000000,FadeOutTime=5.0000000,FadeOutVolumeLevel=0.0000000,MP3Filename="")
        EventDuration=0.0000000
    }
};

var() MusicTrackStruct DefaultTrack;
var() array<MusicEvent> MusicEvents;

defaultproperties
{
    DefaultTrack=(TheSoundCue=none,bAutoPlay=false,bPersistentAcrossLevels=false,FadeInTime=5.0000000,FadeInVolumeLevel=1.0000000,FadeOutTime=5.0000000,FadeOutVolumeLevel=0.0000000,MP3Filename="")
}