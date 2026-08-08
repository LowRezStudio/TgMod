class TgAnimMetaData_MICScalarParameter extends AnimMetaData
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

struct MICScalarParameterKeyFrame {
    var () float Time;
    var () float TargetValue;
    structdefaultproperties {}
};

var () name MICParameterName;
var () int MaterialIndex;
var () editinline array<MICScalarParameterKeyFrame> KeyFrames;
var () bool bForceFirstKeyFrameOnBecomeRelevant;
var () bool bForceLastKeyFrameOnCeaseRelevant;
