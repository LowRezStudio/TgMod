class TgSeqAct_SelectBestSpawnPoint extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object)
    config(Engine);

var () array<Object> Points;
var () Actor PlayerReceived;

function Activated() { }

defaultproperties
{
    InputLinks[0]=(LinkDesc="Teleport Pawn",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'SeqVar_ObjectList',LinkedVariables=none,LinkDesc="Spawn Points",LinkVar="None",PropertyName="Points",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'SeqVar_Object',LinkedVariables=none,LinkDesc="Player",LinkVar="None",PropertyName="PlayerReceived",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Teleport Player To Best Spawn Point"
}
