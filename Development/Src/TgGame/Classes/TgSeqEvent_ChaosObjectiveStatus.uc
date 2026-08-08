class TgSeqEvent_ChaosObjectiveStatus extends SequenceEvent
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

function UpdateLinkedVars(bool bFriendlyTaskForce) { }

defaultproperties
{
    MaxTriggerCount=0
    bPlayerOnly=false
    bClientSideOnly=true
    OutputLinks[0]=(Links=none,LinkDesc="Contested",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Uncontested",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Empty",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Bool',LinkedVariables=none,LinkDesc="Friendly Controlled",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="ChaosObjectiveStatus"
}
