class SeqAct_SetDOFParams extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var() float FalloffExponent;
var() float BlurKernelSize;
var(BlurAmount) float MaxNearBlurAmount;
var(BlurAmount) float MinBlurAmount;
var(BlurAmount) float MaxFarBlurAmount;
var() float FocusInnerRadius;
var() float FocusDistance;
var() Vector FocusPosition;
var() float InterpolateSeconds;
var float InterpolateElapsed;
var float OldFalloffExponent;
var float OldBlurKernelSize;
var float OldMaxNearBlurAmount;
var float OldMinBlurAmount;
var float OldMaxFarBlurAmount;
var float OldFocusInnerRadius;
var float OldFocusDistance;
var Vector OldFocusPosition;

defaultproperties
{
    FalloffExponent=4.0000000
    BlurKernelSize=5.0000000
    MaxNearBlurAmount=1.0000000
    MaxFarBlurAmount=1.0000000
    FocusInnerRadius=600.0000000
    FocusDistance=600.0000000
    InterpolateSeconds=2.0000000
    InputLinks[0]=(LinkDesc="Enable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Disable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Depth Of Field"
}