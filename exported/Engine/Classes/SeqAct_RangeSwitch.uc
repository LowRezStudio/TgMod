class SeqAct_RangeSwitch extends SequenceAction
    native(Sequence)
    hidecategories(Object);

struct native SwitchRange
{
    var() int Min;
    var() int Max;

    structdefaultproperties
    {
        Min=0
        Max=0
    }
};

var() editinline array<editinline SwitchRange> Ranges;

defaultproperties
{
    OutputLinks=none
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Index",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Ranged"
}