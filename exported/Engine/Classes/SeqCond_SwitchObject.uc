class SeqCond_SwitchObject extends SeqCond_SwitchBase
    native(Sequence)
    hidecategories(Object);

struct native SwitchObjectCase
{
    var() Object ObjectValue;
    var() bool bFallThru;
    var() bool bDefaultValue;

    structdefaultproperties
    {
        ObjectValue=none
        bFallThru=false
        bDefaultValue=false
    }
};

var() array<SwitchObjectCase> SupportedValues;

event VerifyDefaultCaseValue()
{
    local int I;

    super.VerifyDefaultCaseValue();
    SupportedValues.Length = OutputLinks.Length;
    I = 0;
    J0x2A:

    // End:0x7C [Loop If]
    if(I < (SupportedValues.Length - 1))
    {
        SupportedValues[I].bDefaultValue = false;
        I++;
        // [Loop Continue]
        goto J0x2A;
    }
    SupportedValues[SupportedValues.Length - 1].ObjectValue = none;
    SupportedValues[SupportedValues.Length - 1].bFallThru = false;
    SupportedValues[SupportedValues.Length - 1].bDefaultValue = true;
    //return;    
}

event bool IsFallThruEnabled(int ValueIndex)
{
    return ((ValueIndex >= 0) && ValueIndex < SupportedValues.Length) && SupportedValues[ValueIndex].bFallThru;
    //return ReturnValue;    
}

event InsertValueEntry(int InsertIndex)
{
    InsertIndex = Clamp(InsertIndex, 0, SupportedValues.Length);
    SupportedValues.Insert(InsertIndex, 1);
    //return;    
}

event RemoveValueEntry(int RemoveIndex)
{
    // End:0x3E
    if((RemoveIndex >= 0) && RemoveIndex < SupportedValues.Length)
    {
        SupportedValues.Remove(RemoveIndex, 1);
    }
    //return;    
}

defaultproperties
{
    SupportedValues[0]=(ObjectValue=none,bFallThru=false,bDefaultValue=true)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Object",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Switch Object"
}