class SeqAct_SetMatInstVectorParam extends SequenceAction
    hidecategories(Object);

var() MaterialInstanceConstant MatInst;
var() name ParamName;
var() LinearColor VectorValue;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 2;
    //return ReturnValue;    
}

defaultproperties
{
    VectorValue=(R=0.0000000,G=0.0000000,B=0.0000000,A=1.0000000)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="VectorValue",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Set VectorParam"
}