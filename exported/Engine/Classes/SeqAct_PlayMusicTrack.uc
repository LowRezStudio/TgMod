class SeqAct_PlayMusicTrack extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() MusicTrackStruct MusicTrack;

defaultproperties
{
    MusicTrack=(TheSoundCue=none,bAutoPlay=false,bPersistentAcrossLevels=false,FadeInTime=5.0000000,FadeInVolumeLevel=1.0000000,FadeOutTime=5.0000000,FadeOutVolumeLevel=0.0000000,MP3Filename="")
    VariableLinks=none
    ObjName="Play Music Track"
}