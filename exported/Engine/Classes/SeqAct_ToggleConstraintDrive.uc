class SeqAct_ToggleConstraintDrive extends SequenceAction
    hidecategories(Object);

var() bool bEnableAngularPositionDrive;
var() bool bEnableAngularVelocityDrive;
var() bool bEnableLinearPositionDrive;
var() bool bEnableLinearvelocityDrive;

defaultproperties
{
    InputLinks[0]=(LinkDesc="Enable Drive",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Disable All Drive",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Toggle Constraint Drive"
}