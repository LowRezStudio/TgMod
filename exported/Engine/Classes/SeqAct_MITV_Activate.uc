class SeqAct_MITV_Activate extends SequenceAction
    hidecategories(Object);

var() float DurationOfMITV;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

event Activated()
{
    local SeqVar_Object ObjVar;
    local MaterialInstanceTimeVaryingActor MITVA;

    // End:0xC8
    foreach LinkedVariables(Class'Engine.SeqVar_Object', ObjVar, "MITV")
    {
        MITVA = MaterialInstanceTimeVaryingActor(ObjVar.GetObjectValue());
        // End:0xC7
        if(MITVA != none)
        {
            // End:0xC7
            if(MITVA.MatInst != none)
            {
                MITVA.MatInst.SetDuration(DurationOfMITV);
            }
        }        
    }    
    //return;    
}

defaultproperties
{
    bCallHandler=false
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="MITV",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="MITV Activate"
}