class AnimMetaData_SkelControlKeyFrame extends AnimMetaData_SkelControl
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() editinline array<editinline TimeModifier> KeyFrames;
var() bool bForceFirstKeyFrameOnBecomeRelevant;
var() bool bForceLastKeyFrameOnCeaseRelevant;

defaultproperties
{
    bFullControlOverController=false
}