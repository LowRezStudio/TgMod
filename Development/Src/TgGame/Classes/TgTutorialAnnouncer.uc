class TgTutorialAnnouncer extends Object within TgPlayerController
    config(Engine);

var array<SoundCue> TutorialSounds;
var transient array<SoundCue> QueuedSounds;
var export editinline transient AudioComponent CurrentSoundAC;
var transient TgPlayerController OwnerPC;

function Init() { }

function Destroyed() { }

function AudioFinishedPlaying(AudioComponent AC) { }

function PlayAnnouncement(int SoundIndex, SoundCue OptionalCue, optional bool bPlayImmediately=false, optional bool bFlushOthers=false) { }
