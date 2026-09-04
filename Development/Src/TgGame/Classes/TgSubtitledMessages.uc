class TgSubtitledMessages extends Object within TgPlayerController
    native(Pawns)
    config(Engine);

struct QueuedSubtitle {
    var bool CurrentlyPlaying;
    var int SubtitleMessageId;
    var string SubtitleText;
    var AkBaseSoundObject SubtitleSound;
    var int AkId;
    structdefaultproperties {}
};

var QueuedSubtitle CurrentSubtitle;
var array<QueuedSubtitle> QueuedSubtitles;
var transient TgPlayerController OwnerPC;
var export editinline transient AudioComponent PlayingSubtitleAC;
var bool bFinishedSubtitle;
var float SubtitleFailsafeTime;

native reliable client simulated function PlaySubtitledMessage(int MessageId, optional bool PlayImmediately=false, optional bool FlushOthers=false, optional AkEvent CustomShutdownEvent);  // Export UTgSubtitledMessages::execPlaySubtitledMessage(FFrame&, void* const)

native function SubtitledCueEnded(AudioComponent AC);  // Export UTgSubtitledMessages::execSubtitledCueEnded(FFrame&, void* const)

native function SubtitleFailsafe();  // Export UTgSubtitledMessages::execSubtitleFailsafe(FFrame&, void* const)

function Init() { }

function Destroyed() { }

event PlaySubtitleSoundCue(SoundCue CueToPlay) { }

defaultproperties
{
    SubtitleFailsafeTime=30.0000000
}
