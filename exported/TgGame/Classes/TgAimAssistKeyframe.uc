class TgAimAssistKeyframe extends Object
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(TgAimAssistKeyframe);

struct native AimAssistKeyframeData
{
    var name KeyframeName;
    var float Distance;

    structdefaultproperties
    {
        KeyframeName="None"
        Distance=0.0000000
    }
};

var() name KeyframeName;
var() RawDistributionFloat AimAssistCurve;
var() bool bMirrored;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'TgGame.Default__TgAimAssistKeyframe.DistributionAimAssistKeyframe'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAimAssistKeyframe'
    begin object name="DistributionAimAssistKeyframe" class=Engine.DistributionFloatConstantCurve
    end object
    KeyframeName="UnnamedKeyframe"
    AimAssistCurve=(Distribution=Distribution=DistributionAimAssistKeyframe,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}