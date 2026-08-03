class WaveFormBase extends Object
    abstract
    native;

var ForceFeedbackWaveform TheWaveForm;

defaultproperties
{
    // Reference: ForceFeedbackWaveform'Engine.Default__WaveFormBase.ForceFeedbackWaveform'
    begin object name="ForceFeedbackWaveform" class=Engine.ForceFeedbackWaveform
    end object
    TheWaveForm=ForceFeedbackWaveform
}