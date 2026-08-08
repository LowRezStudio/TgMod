class TgSeqAct_BeginWaitForLookAt extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () Vector LocationToLookAt;
var () float MinOffsetDistance;

function Activated() { }

defaultproperties
{
    MinOffsetDistance=1.5000000
    VariableLinks[0]=(ExpectedType=Class'SeqVar_Vector',LinkedVariables=none,LinkDesc="Location To Look At",LinkVar="None",PropertyName="LocationToLookAt",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Float',LinkedVariables=none,LinkDesc="Min Aim Distance from Location",LinkVar="None",PropertyName="MinOffsetDistance",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Begin Wait For LookAt"
}
