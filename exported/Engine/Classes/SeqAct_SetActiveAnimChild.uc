class SeqAct_SetActiveAnimChild extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() name NodeName;
var() int ChildIndex;
var() float BlendTime;

defaultproperties
{
    BlendTime=0.2500000
    InputLinks[0]=(LinkDesc="Activate",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Set Active Anim Child"
}