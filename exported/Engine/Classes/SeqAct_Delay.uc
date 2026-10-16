class SeqAct_Delay extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var const bool bDelayActive;
var() bool bStartWillRestart;
var const float DefaultDuration;
var() float Duration;
var const float LastUpdateTime;
var const float RemainingTime;

function Reset()
{
    ResetDelayActive();
    //return;    
}

// Export USeqAct_Delay::execResetDelayActive(FFrame&, void* const)
native function ResetDelayActive();

defaultproperties
{
    DefaultDuration=1.0000000
    Duration=1.0000000
    InputLinks[0]=(LinkDesc="Start",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[2]=(LinkDesc="Pause",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Duration",LinkVar="None",PropertyName="Duration",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Delay"
}