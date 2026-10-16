class TgSeqAct_ChangeScale extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () float TargetScale;
var () Vector TargetScale3D;
var () float TransitionTime;

defaultproperties
{
    TargetScale=1.0000000
    TargetScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Float',LinkedVariables=none,LinkDesc="TargetScale",LinkVar="None",PropertyName="TargetScale",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'SeqVar_Vector',LinkedVariables=none,LinkDesc="TargetScale3D",LinkVar="None",PropertyName="TargetScale3D",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[3]=(ExpectedType=Class'SeqVar_Float',LinkedVariables=none,LinkDesc="Time",LinkVar="None",PropertyName="TransitionTime",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Change Scale"
}
