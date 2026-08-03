class AnimationCompressionAlgorithm_RemoveTrivialKeys extends AnimationCompressionAlgorithm
    native(Anim)
    hidecategories(Object);

var() float MaxPosDiff;
var() float MaxAngleDiff;

defaultproperties
{
    MaxPosDiff=0.0001000
    MaxAngleDiff=0.0003000
    Description="Remove Trivial Keys"
}