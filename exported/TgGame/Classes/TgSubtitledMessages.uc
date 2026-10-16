class TgSubtitledMessages extends Object within TgPlayerController
    native(Pawns);

struct native QueuedSubtitle
{
    var bool CurrentlyPlaying;
    var int SubtitleMessageId;
    var string SubtitleText;
    var AkBaseSoundObject SubtitleSound;
    var int AkId;

    structdefaultproperties
    {
        CurrentlyPlaying=false
        SubtitleMessageId=0
        SubtitleText=""
        SubtitleSound=none
        AkId=0
    }
};

var QueuedSubtitle CurrentSubtitle;
var array<QueuedSubtitle> QueuedSubtitles;
var transient TgPlayerController OwnerPC;
var export editinline transient AudioComponent PlayingSubtitleAC;
var bool bFinishedSubtitle;
var float SubtitleFailsafeTime;

// Export UTgSubtitledMessages::execPlaySubtitledMessage(FFrame&, void* const)
reliable client native simulated function PlaySubtitledMessage(int MessageId, optional bool PlayImmediately = false, optional bool FlushOthers = false, optional AkEvent CustomShutdownEvent);

// Export UTgSubtitledMessages::execSubtitledCueEnded(FFrame&, void* const)
native function SubtitledCueEnded(AudioComponent AC);

// Export UTgSubtitledMessages::execSubtitleFailsafe(FFrame&, void* const)
native function SubtitleFailsafe();

function Init()
{
    OwnerPC = Outer;
    //return;    
}

function Destroyed()
{
    local AkEvent SubtitleEvent;

    // End:0x135
    if(CurrentSubtitle.CurrentlyPlaying && OwnerPC != none)
    {
        // End:0x96
        if(PlayingSubtitleAC != none)
        {
            PlayingSubtitleAC.Stop();
            OwnerPC.DetachComponent(PlayingSubtitleAC);
            PlayingSubtitleAC = none;            
        }
        else
        {
            SubtitleEvent = AkEvent(CurrentSubtitle.SubtitleSound);
            // End:0x135
            if(SubtitleEvent != none)
            {
                // End:0x135
                if(SubtitleEvent.m_ShutdownEvent != none)
                {
                    OwnerPC.PostAkEvent(SubtitleEvent.m_ShutdownEvent);
                }
            }
        }
    }
    Outer.ClearTimer('SubtitleFailsafe');
    OwnerPC = none;
    //return;    
}

event PlaySubtitleSoundCue(SoundCue CueToPlay)
{
    // End:0xD9
    if(PlayingSubtitleAC == none)
    {
        PlayingSubtitleAC = OwnerPC.CreateAudioComponent(CueToPlay, false, true);
        PlayingSubtitleAC.bAllowSpatialization = false;
        PlayingSubtitleAC.bAutoDestroy = false;
        PlayingSubtitleAC.bShouldRemainActiveIfDropped = true;
        PlayingSubtitleAC.__OnAudioFinished__Delegate = SubtitledCueEnded;
    }
    PlayingSubtitleAC.SoundCue = CueToPlay;
    PlayingSubtitleAC.Play();
    //return;    
}

defaultproperties
{
    SubtitleFailsafeTime=30.0000000
}