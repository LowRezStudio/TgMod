class SeqAct_ToggleInput extends SeqAct_Toggle
    hidecategories(Object);

var() bool bToggleMovement;
var() bool bToggleTurning;

defaultproperties
{
    bToggleMovement=true
    bToggleTurning=true
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=true,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Toggle Input"
}