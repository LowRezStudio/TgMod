class SeqAct_SetVector extends SeqAct_SetSequenceVariable
    hidecategories(Object);

var() Vector DefaultValue;

event Activated()
{
    local bool bIgnoreDefault;
    local SeqVar_Vector VectVar;
    local Vector Value;

    // End:0x5C
    foreach LinkedVariables(Class'Engine.SeqVar_Vector', VectVar, "Value")
    {
        bIgnoreDefault = true;
        Value += VectVar.VectValue;        
    }    
    // End:0x7F
    if(!bIgnoreDefault)
    {
        Value = DefaultValue;
    }
    // End:0xCF
    foreach LinkedVariables(Class'Engine.SeqVar_Vector', VectVar, "Target")
    {
        VectVar.VectValue = Value;        
    }    
    //return;    
}

defaultproperties
{
    bCallHandler=false
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Value",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Vector',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Vector"
}