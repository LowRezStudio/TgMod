class MusicTrackDataStructures extends Object
    native;

struct native MusicTrackStruct
{
    var() SoundCue TheSoundCue;
    var() bool bAutoPlay;
    var() bool bPersistentAcrossLevels;
    var() float FadeInTime;
    var() float FadeInVolumeLevel;
    var() float FadeOutTime;
    var() float FadeOutVolumeLevel;
    var(Mobile) string MP3Filename;

    structdefaultproperties
    {
        TheSoundCue=none
        bAutoPlay=false
        bPersistentAcrossLevels=false
        FadeInTime=5.0000000
        FadeInVolumeLevel=1.0000000
        FadeOutTime=5.0000000
        FadeOutVolumeLevel=0.0000000
        MP3Filename=""
    }
};
