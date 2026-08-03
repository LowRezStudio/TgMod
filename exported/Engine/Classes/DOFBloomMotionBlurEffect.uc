class DOFBloomMotionBlurEffect extends DOFAndBloomEffect
    native
    hidecategories(Object);

var(MotionBlur) float MaxVelocity;
var(MotionBlur) float MotionBlurAmount;
var(MotionBlur) bool FullMotionBlur;
var(MotionBlur) float CameraRotationThreshold;
var(MotionBlur) float CameraTranslationThreshold;

defaultproperties
{
    MaxVelocity=1.0000000
    MotionBlurAmount=0.5000000
    FullMotionBlur=true
    CameraRotationThreshold=90.0000000
    CameraTranslationThreshold=10000.0000000
    bShowInEditor=false
}