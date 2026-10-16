class SeqCond_SwitchClass extends SeqCond_SwitchBase
    native(Sequence)
    hidecategories(Object);

struct native SwitchClassInfo
{
    var() name ClassName;
    var() byte bFallThru;

    structdefaultproperties
    {
        ClassName="None"
        bFallThru=0
    }
};

var() array<SwitchClassInfo> ClassArray;

event VerifyDefaultCaseValue()
{
    super.VerifyDefaultCaseValue();
    ClassArray.Length = OutputLinks.Length;
    ClassArray[ClassArray.Length - 1].ClassName = 'Default';
    ClassArray[ClassArray.Length - 1].bFallThru = 0;
    //return;    
}

event bool IsFallThruEnabled(int ValueIndex)
{
    return ((ValueIndex >= 0) && ValueIndex < ClassArray.Length) && int(ClassArray[ValueIndex].bFallThru) != int(0);
    //return ReturnValue;    
}

event InsertValueEntry(int InsertIndex)
{
    InsertIndex = Clamp(InsertIndex, 0, ClassArray.Length);
    ClassArray.Insert(InsertIndex, 1);
    //return;    
}

event RemoveValueEntry(int RemoveIndex)
{
    // End:0x3E
    if((RemoveIndex >= 0) && RemoveIndex < ClassArray.Length)
    {
        ClassArray.Remove(RemoveIndex, 1);
    }
    //return;    
}

defaultproperties
{
    ClassArray[0]=(ClassName="Default",bFallThru=0)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Object",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Switch Class"
}