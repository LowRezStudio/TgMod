class DOFEffect extends PostProcessEffect
    abstract
    native
    hidecategories(Object);

enum EFocusType
{
    FOCUS_Distance,                 // 0
    FOCUS_Position,                 // 1
    FOCUS_MAX                       // 2
};

var(DepthOfField) float FalloffExponent;
var(DepthOfField) float BlurKernelSize;
var(DepthOfField,BlurAmount) float MaxNearBlurAmount;
var(DepthOfField,BlurAmount) float MinBlurAmount;
var(DepthOfField,BlurAmount) float MaxFarBlurAmount;
var(DepthOfField) DOFEffect.EFocusType FocusType;
var(DepthOfField) float FocusInnerRadius;
var(DepthOfField) float FocusDistance;
var(DepthOfField) Vector FocusPosition;

defaultproperties
{
    FalloffExponent=2.0000000
    BlurKernelSize=2.0000000
    MaxNearBlurAmount=1.0000000
    MaxFarBlurAmount=1.0000000
    FocusInnerRadius=400.0000000
    FocusDistance=800.0000000
}