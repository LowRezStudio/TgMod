class ForceFeedbackWaveform extends Object
    native
    editinlinenew;

enum EWaveformFunction
{
    WF_Constant,                    // 0
    WF_LinearIncreasing,            // 1
    WF_LinearDecreasing,            // 2
    WF_Sin0to90,                    // 3
    WF_Sin90to180,                  // 4
    WF_Sin0to180,                   // 5
    WF_Noise,                       // 6
    WF_MAX                          // 7
};

struct native WaveformSample
{
    var() byte LeftAmplitude;
    var() byte RightAmplitude;
    var() byte LeftTriggerAmplitude;
    var() byte RightTriggerAmplitude;
    var() ForceFeedbackWaveform.EWaveformFunction LeftFunction;
    var() ForceFeedbackWaveform.EWaveformFunction RightFunction;
    var() ForceFeedbackWaveform.EWaveformFunction LeftTriggerFunction;
    var() ForceFeedbackWaveform.EWaveformFunction RightTriggerFunction;
    var() float Duration;

    structdefaultproperties
    {
        LeftAmplitude=0
        RightAmplitude=0
        LeftTriggerAmplitude=0
        RightTriggerAmplitude=0
        LeftFunction=EWaveformFunction.WF_Constant
        RightFunction=EWaveformFunction.WF_Constant
        LeftTriggerFunction=EWaveformFunction.WF_Constant
        RightTriggerFunction=EWaveformFunction.WF_Constant
        Duration=0.0000000
    }
};

var() bool bIsLooping;
var() array<WaveformSample> Samples;
var() float WaveformFalloffStartDistance;
var() float MaxWaveformDistance;
