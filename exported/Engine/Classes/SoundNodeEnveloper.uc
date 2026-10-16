class SoundNodeEnveloper extends SoundNode
    native(Sound)
    editinlinenew
    hidecategories(Object,Object);

var(Looping) float LoopStart;
var(Looping) float LoopEnd;
var(Looping) float DurationAfterLoop;
var(Looping) int LoopCount;
var(Looping) bool bLoopIndefinitely;
var(Looping) bool bLoop;
var(Envelope) export editinline DistributionFloatConstantCurve VolumeInterpCurve;
var(Envelope) export editinline DistributionFloatConstantCurve PitchInterpCurve;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'Engine.Default__SoundNodeEnveloper.VolumeInterpCurve'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'VolumeInterpCurve'
    begin object name="VolumeInterpCurve" class=Engine.DistributionFloatConstantCurve
        ConstantCurve=(Points=((InVal=0.0000000,OutVal=1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=EInterpCurveMode.CIM_Linear)))
    end object
    VolumeInterpCurve=VolumeInterpCurve
    // Reference: DistributionFloatConstantCurve'Engine.Default__SoundNodeEnveloper.PitchInterpCurve'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PitchInterpCurve'
    begin object name="PitchInterpCurve" class=Engine.DistributionFloatConstantCurve
        ConstantCurve=(Points=((InVal=0.0000000,OutVal=1.0000000,ArriveTangent=0.0000000,LeaveTangent=0.0000000,InterpMode=EInterpCurveMode.CIM_Linear)))
    end object
    PitchInterpCurve=PitchInterpCurve
}