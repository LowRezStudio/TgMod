class TgAimAssistKeyframe extends Object
    native
    editinlinenew
    hidecategories(Object)
    autoexpandcategories(TgAimAssistKeyframe)
    config(Engine);

struct AimAssistKeyframeData {
    var name KeyframeName;
    var float Distance;
    structdefaultproperties {}
};

var () name KeyframeName;
var () RawDistributionFloat AimAssistCurve;
var () bool bMirrored;

defaultproperties
{}
