class SeqAct_DrawText extends SequenceAction
    native(Sequence)
    hidecategories(Object);

var() float DisplayTimeSeconds;
var() bool bDisplayOnObject;
var() KismetDrawTextInfo DrawTextInfo;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 2;
    //return ReturnValue;    
}

defaultproperties
{
    DisplayTimeSeconds=-1.0000000
    DrawTextInfo=(MessageText="",AppendedText="",MessageFont=none,MessageFontScale=(X=1.0000000,Y=1.0000000),MessageOffset=(X=0.0000000,Y=0.0000000),MessageColor=(R=255,G=255,B=255,A=255),MessageEndTime=-1.0000000)
    bLatentExecution=true
    bAutoActivateOutputLinks=false
    InputLinks[0]=(LinkDesc="Show",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Hide",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_String',LinkedVariables=none,LinkDesc="String",LinkVar="None",PropertyName="None",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=true,MinVars=0,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Draw Text"
}