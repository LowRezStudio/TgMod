class AnimationCompressionAlgorithm_RemoveEverySecondKey extends AnimationCompressionAlgorithm
    native(Anim)
    hidecategories(Object);

var() int MinKeys;
var() bool bStartAtSecondKey;

defaultproperties
{
    MinKeys=10
    Description="Remove Every Second Key"
}