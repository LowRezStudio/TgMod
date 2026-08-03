class AnimationCompressionAlgorithm_RemoveLinearKeys extends AnimationCompressionAlgorithm
    native(Anim)
    hidecategories(Object);

var(LinearKeyRemoval) float MaxPosDiff;
var(LinearKeyRemoval) float MaxAngleDiff;
var(LinearKeyRemoval) float MaxEffectorDiff;
var(LinearKeyRemoval) float MinEffectorDiff;
var(LinearKeyRemoval) float EffectorDiffSocket;
var(LinearKeyRemoval) float ParentKeyScale;
var(LinearKeyRemoval) bool bRetarget;
var(LinearKeyRemoval) bool bActuallyFilterLinearKeys;

defaultproperties
{
    MaxPosDiff=0.0010000
    MaxAngleDiff=0.0007500
    MaxEffectorDiff=0.0010000
    MinEffectorDiff=0.0010000
    EffectorDiffSocket=0.0010000
    ParentKeyScale=2.0000000
    bRetarget=true
    bActuallyFilterLinearKeys=true
    Description="Remove Linear Keys"
    bNeedsSkeleton=true
}