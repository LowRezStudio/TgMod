class AnimationCompressionAlgorithm extends Object
    abstract
    native(Anim)
    hidecategories(Object);

var string Description;
var bool bNeedsSkeleton;
var AnimSequence.AnimationCompressionFormat TranslationCompressionFormat;
var() AnimSequence.AnimationCompressionFormat RotationCompressionFormat;

defaultproperties
{
    Description="None"
    RotationCompressionFormat=AnimationCompressionFormat.ACF_Float96NoW
}