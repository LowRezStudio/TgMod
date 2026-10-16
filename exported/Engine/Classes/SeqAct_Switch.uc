class SeqAct_Switch extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() int LinkCount;
var() int IncrementAmount;
var() bool bLooping;
var() bool bAutoDisableLinks;
var() array<int> Indices;

defaultproperties
{
    LinkCount=1
    IncrementAmount=1
    Indices[0]=1
    OutputLinks[0]=(Links=none,LinkDesc="Link 1",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Index",LinkVar="None",PropertyName="Indices",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Switch"
}