class AnimationCompressionAlgorithm_PerTrackCompression extends AnimationCompressionAlgorithm_RemoveLinearKeys
    native(Anim)
    hidecategories(Object,AnimationCompressionAlgorithm);

var(PerTrack) float MaxZeroingThreshold;
var(PerTrack) float MaxPosDiffBitwise;
var(PerTrack) float MaxAngleDiffBitwise;
var(PerTrack) array<AnimSequence.AnimationCompressionFormat> AllowedRotationFormats;
var(PerTrack) array<AnimSequence.AnimationCompressionFormat> AllowedTranslationFormats;
var(Resampling) bool bResampleAnimation;
var(AdaptiveError) bool bUseAdaptiveError;
var(AdaptiveError) bool bUseOverrideForEndEffectors;
var(AdaptiveError2) bool bUseAdaptiveError2;
var(Resampling) float ResampledFramerate;
var(Resampling) int MinKeysForResampling;
var(AdaptiveError) int TrackHeightBias;
var(AdaptiveError) float ParentingDivisor;
var(AdaptiveError) float ParentingDivisorExponent;
var(AdaptiveError2) float RotationErrorSourceRatio;
var(AdaptiveError2) float TranslationErrorSourceRatio;
var(AdaptiveError2) float MaxErrorPerTrackRatio;
var float PerturbationProbeSize;
var native const transient Pointer PerReductionCachedData;

defaultproperties
{
    MaxZeroingThreshold=0.0002000
    MaxPosDiffBitwise=0.0070000
    MaxAngleDiffBitwise=0.0020000
    AllowedRotationFormats[0]=125
    AllowedRotationFormats[1]=0
    AllowedTranslationFormats[0]=125
    AllowedTranslationFormats[1]=0
    AllowedTranslationFormats[2]=0
    ResampledFramerate=15.0000000
    MinKeysForResampling=10
    TrackHeightBias=1
    ParentingDivisor=1.0000000
    ParentingDivisorExponent=1.0000000
    RotationErrorSourceRatio=0.8000000
    TranslationErrorSourceRatio=0.8000000
    MaxErrorPerTrackRatio=0.3000000
    PerturbationProbeSize=0.0010000
    bRetarget=false
    bActuallyFilterLinearKeys=false
    Description="Compress each track independently"
}