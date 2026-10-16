class MotionBlurEffect extends PostProcessEffect
    native
    hidecategories(Object);

var() float MaxVelocity;
var() float MotionBlurAmount;
var() bool FullMotionBlur;
var() float CameraRotationThreshold;
var() float CameraTranslationThreshold;

defaultproperties
{
    MaxVelocity=1.0000000
    MotionBlurAmount=0.5000000
    FullMotionBlur=true
    CameraRotationThreshold=90.0000000
    CameraTranslationThreshold=10000.0000000
    bShowInEditor=false
}