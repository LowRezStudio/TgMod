class TgTutorialAnnouncer extends Object within TgPlayerController;

var array<SoundCue> TutorialSounds;
var transient array<SoundCue> QueuedSounds;
var export editinline transient AudioComponent CurrentSoundAC;
var transient TgPlayerController OwnerPC;

function Init()
{
    OwnerPC = Outer;
    //return;    
}

function Destroyed()
{
    // End:0x48
    if((CurrentSoundAC != none) && OwnerPC != none)
    {
        OwnerPC.DetachComponent(CurrentSoundAC);
    }
    CurrentSoundAC = none;
    OwnerPC = none;
    //return;    
}

function AudioFinishedPlaying(AudioComponent AC)
{
    // End:0x35
    if(QueuedSounds.Length > 0)
    {
        PlayAnnouncement(0, QueuedSounds[0]);
        QueuedSounds.Remove(0, 1);
    }
    //return;    
}

function PlayAnnouncement(int SoundIndex, SoundCue OptionalCue, optional bool bPlayImmediately = false, optional bool bFlushOthers = false)
{
    //return;    
}
