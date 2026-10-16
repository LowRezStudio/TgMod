class AnimationCompressionAlgorithm_Automatic extends AnimationCompressionAlgorithm
    native(Anim)
    hidecategories(Object,AnimationCompressionAlgorithm);

var() float MaxEndEffectorError;
var() bool bTryFixedBitwiseCompression;
var() bool bTryPerTrackBitwiseCompression;
var() bool bTryLinearKeyRemovalCompression;
var() bool bTryIntervalKeyRemoval;
var() bool bRunCurrentDefaultCompressor;
var() bool bAutoReplaceIfExistingErrorTooGreat;
var() bool bRaiseMaxErrorToExisting;

defaultproperties
{
    MaxEndEffectorError=1.0000000
    bTryFixedBitwiseCompression=true
    bTryPerTrackBitwiseCompression=true
    bTryLinearKeyRemovalCompression=true
    bTryIntervalKeyRemoval=true
    Description="Automatic"
}