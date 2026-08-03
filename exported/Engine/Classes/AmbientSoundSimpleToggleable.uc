class AmbientSoundSimpleToggleable extends AmbientSoundSimple
    native(Sound)
    placeable
    hidecategories(Navigation,Audio)
    autoexpandcategories(Audio,AmbientSoundSimple,AmbientSoundSimpleToggleable);

struct CheckpointRecord
{
    var bool bCurrentlyPlaying;

    structdefaultproperties
    {
        bCurrentlyPlaying=false
    }
};

var repnotify bool bCurrentlyPlaying;
var() bool bFadeOnToggle;
var transient bool bIgnoreAutoPlay;
var() float FadeInDuration;
var() float FadeInVolumeLevel;
var() float FadeOutDuration;
var() float FadeOutVolumeLevel;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        bCurrentlyPlaying;
}

simulated event PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    bCurrentlyPlaying = AudioComponent.bAutoPlay;
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x3E
    if(VarName == 'bCurrentlyPlaying')
    {
        // End:0x31
        if(bCurrentlyPlaying)
        {
            StartPlaying();            
        }
        else
        {
            StopPlaying();
        }        
    }
    else
    {
        super(Actor).ReplicatedEvent(VarName);
    }
    //return;    
}

simulated function StartPlaying()
{
    // End:0x41
    if(bFadeOnToggle)
    {
        AudioComponent.FadeIn(FadeInDuration, FadeInVolumeLevel);        
    }
    else
    {
        AudioComponent.Play();
    }
    bCurrentlyPlaying = true;
    //return;    
}

simulated function StopPlaying()
{
    // End:0x42
    if(bFadeOnToggle)
    {
        AudioComponent.FadeOut(FadeOutDuration, FadeOutVolumeLevel);        
    }
    else
    {
        AudioComponent.Stop();
    }
    bCurrentlyPlaying = false;
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0xA4
    if(Action.InputLinks[0].bHasImpulse || Action.InputLinks[2].bHasImpulse && !AudioComponent.bWasPlaying)
    {
        StartPlaying();        
    }
    else
    {
        bIgnoreAutoPlay = true;
        StopPlaying();
    }
    ForceNetRelevant();
    //return;    
}

function CreateCheckpointRecord(out CheckpointRecord Record)
{
    Record.bCurrentlyPlaying = bCurrentlyPlaying;
    //return;    
}

function ApplyCheckpointRecord(const out CheckpointRecord Record)
{
    bCurrentlyPlaying = Record.bCurrentlyPlaying;
    // End:0x42
    if(bCurrentlyPlaying)
    {
        StartPlaying();        
    }
    else
    {
        StopPlaying();
    }
    //return;    
}

defaultproperties
{
    FadeInDuration=1.0000000
    FadeInVolumeLevel=1.0000000
    FadeOutDuration=1.0000000
    // Reference: SoundCue'Engine.Default__AmbientSoundSimpleToggleable.SoundCue0'
    // Archetype: SoundCue'Engine.Default__AmbientSoundSimple.SoundCue0'
    begin object name="SoundCue0"
    end object
    SoundCueInstance=SoundCue0
    // Reference: SoundNodeAmbient'Engine.Default__AmbientSoundSimpleToggleable.SoundNodeAmbient0'
    // Archetype: SoundNodeAmbient'Engine.Default__AmbientSoundSimple.SoundNodeAmbient0'
    begin object name="SoundNodeAmbient0"
    end object
    SoundNodeInstance=SoundNodeAmbient0
    bAutoPlay=false
    // Reference: AudioComponent'Engine.Default__AmbientSoundSimpleToggleable.AudioComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AudioComponent0'
    // Archetype: AudioComponent'Engine.Default__AmbientSoundSimple.AudioComponent0'
    begin object name="AudioComponent0"
    end object
    AudioComponent=AudioComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=AudioComponent0
    bStatic=false
    bNoDelete=true
}