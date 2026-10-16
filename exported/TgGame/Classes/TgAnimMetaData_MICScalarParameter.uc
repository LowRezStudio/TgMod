class TgAnimMetaData_MICScalarParameter extends AnimMetaData
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

struct native MICScalarParameterKeyFrame
{
    var() float Time;
    var() float TargetValue;

    structdefaultproperties
    {
        Time=0.0000000
        TargetValue=0.0000000
    }
};

var() name MICParameterName;
var() int MaterialIndex;
var() editinline array<editinline MICScalarParameterKeyFrame> KeyFrames;
var() bool bForceFirstKeyFrameOnBecomeRelevant;
var() bool bForceLastKeyFrameOnCeaseRelevant;
