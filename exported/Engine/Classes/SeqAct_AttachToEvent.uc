class SeqAct_AttachToEvent extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() bool bPreferController;

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Attachee",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    EventLinks[0]=(ExpectedType=Class'Engine.SequenceEvent',LinkedEvents=none,LinkDesc="Event",DrawX=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Attach To Event"
}