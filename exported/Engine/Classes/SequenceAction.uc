class SequenceAction extends SequenceOp
    abstract
    native(Sequence)
    hidecategories(Object);

var name HandlerName;
var bool bCallHandler;
var() array<Object> Targets;

defaultproperties
{
    bCallHandler=true
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Unknown Action"
}