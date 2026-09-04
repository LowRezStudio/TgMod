class TgAnimMetaData_SkelControl_BoneScale_KeyFrame extends AnimMetaData
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

enum EOnRelevanceChange
{
    ORC_NORMAL,                     // 0
    ORC_FORCE_KEYFRAME,             // 1
    ORC_FORCE_ACTIVE,               // 2
    ORC_FORCE_INACTIVE,             // 3
    ORC_FORCE_OTHER,                // 4
    ORC_MAX                         // 5
};

var() array<name> SkelControlNameList;
var() editinline array<editinline TimeModifier> KeyFrames;
var() bool bAllowScaleUp;
var() bool bAllowScaleDown;
var const bool bAdjustControllerStrength;
var() bool bFullControlOverController;
var() bool bSetKeysNoInterp;
var deprecated bool bForceFirstKeyFrameOnBecomeRelevant;
var deprecated bool bForceLastKeyFrameOnCeaseRelevant;
var deprecated name SkelControlName;
var() TgAnimMetaData_SkelControl_BoneScale_KeyFrame.EOnRelevanceChange OnBecomeRelevantBehavior;
var() TgAnimMetaData_SkelControl_BoneScale_KeyFrame.EOnRelevanceChange OnCeaseRelevantBehavior;
var() float OnBecomeRelevantStrength;
var() float OnCeaseRelevantStrength;

defaultproperties
{
    bAllowScaleUp=true
    bAllowScaleDown=true
}