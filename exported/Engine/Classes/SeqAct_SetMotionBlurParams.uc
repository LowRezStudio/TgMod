class SeqAct_SetMotionBlurParams extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var() float MotionBlurAmount;
var() float InterpolateSeconds;
var float InterpolateElapsed;
var float OldMotionBlurAmount;

defaultproperties
{
    MotionBlurAmount=0.1000000
    InterpolateSeconds=2.0000000
    InputLinks[0]=(LinkDesc="Enable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Disable",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Motion Blur"
}