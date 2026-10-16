class ForceFeedbackManager extends Object within PlayerController
    abstract
    transient
    native;

const FORCEFEEDBACK_MIN = 0.f;
const FORCEFEEDBACK_MAX = 100.f;

struct native ForceFeedbackPlayingInfo
{
    var ForceFeedbackWaveform WaveForm;
    var Actor Instigator;
    var int CurrentSample;
    var float ElapsedTime;
    var float ScaleDuration;
    var float ScaleMagnitude;

    structdefaultproperties
    {
        WaveForm=none
        Instigator=none
        CurrentSample=0
        ElapsedTime=0.0000000
        ScaleDuration=0.0000000
        ScaleMagnitude=0.0000000
    }
};

var bool bAllowsForceFeedback;
var bool bIsPaused;
var float ScaleAllWaveformsBy;
var array<ForceFeedbackPlayingInfo> PlayingWaveforms;

// Export UForceFeedbackManager::execPlayForceFeedbackWaveform(FFrame&, void* const)
native function PlayForceFeedbackWaveform(ForceFeedbackWaveform WaveForm, optional Actor WaveInstigator, optional float fScaleMagnitude = 1.0000000, optional float fScaleRate = 1.0000000, optional bool bForcePlay);

// Export UForceFeedbackManager::execStopForceFeedbackWaveform(FFrame&, void* const)
native function StopForceFeedbackWaveform(optional ForceFeedbackWaveform WaveForm);

simulated function PauseWaveform(optional bool bPause)
{
    bIsPaused = bPause;
    //return;    
}

defaultproperties
{
    bAllowsForceFeedback=true
    ScaleAllWaveformsBy=1.0000000
}