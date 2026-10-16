class PComMusicThemePlayer extends Object
    native(Audio);

var private native const noexport Pointer VfTable_FTickableObject;
var transient string MusicThemePath;
var transient PComMusicTheme MusicTheme;
var export editinline transient AudioComponent MusicComp;
var PComMusicThemeSyncActor MusicSyncActor;
var transient name LastMusicEvent;
var transient MusicTrackStruct CurrentMusicTrack;
var transient float CurrentMusicTrackStartTime;
var transient float CurrentMusicTrackDuration;

// Export UPComMusicThemePlayer::execInit(FFrame&, void* const)
native function Init();

// Export UPComMusicThemePlayer::execLoadDefaultTheme(FFrame&, void* const)
native function LoadDefaultTheme();

// Export UPComMusicThemePlayer::execGetDefaultThemePath(FFrame&, void* const)
native function string GetDefaultThemePath();

// Export UPComMusicThemePlayer::execLoadTheme(FFrame&, void* const)
native function LoadTheme(const string themepath);

// Export UPComMusicThemePlayer::execOnThemeLoaded(FFrame&, void* const)
native function OnThemeLoaded();

// Export UPComMusicThemePlayer::execPlayDefaultMusic(FFrame&, void* const)
native function PlayDefaultMusic();

// Export UPComMusicThemePlayer::execPlayMusicEvent(FFrame&, void* const)
native function PlayMusicEvent(const name EventName);

// Export UPComMusicThemePlayer::execStopMusic(FFrame&, void* const)
native function StopMusic();

// Export UPComMusicThemePlayer::execUpdateMusicTrack(FFrame&, void* const)
native function UpdateMusicTrack(const MusicTrackStruct NewMusicTrack, const optional float fDuration = 0.0000000);

// Export UPComMusicThemePlayer::execUpdateReplicatedMusicEvent(FFrame&, void* const)
native function UpdateReplicatedMusicEvent(const name EventName);

defaultproperties
{
    CurrentMusicTrack=(TheSoundCue=none,bAutoPlay=false,bPersistentAcrossLevels=false,FadeInTime=5.0000000,FadeInVolumeLevel=1.0000000,FadeOutTime=5.0000000,FadeOutVolumeLevel=0.0000000,MP3Filename="")
}