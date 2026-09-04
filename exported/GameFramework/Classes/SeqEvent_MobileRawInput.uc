class SeqEvent_MobileRawInput extends SequenceEvent
    native
    forcescriptorder(true)
    hidecategories(Object);

var(Mobile) int TouchIndex;
var(Mobile) int TouchpadIndex;
var float TouchLocationX;
var float TouchLocationY;
var float TimeStamp;

event RegisterEvent()
{
    local WorldInfo WI;
    local GamePlayerController GPC;
    local MobilePlayerInput MPI;

    WI = Class'Engine.WorldInfo'.static.GetWorldInfo();
    // End:0xD1
    if(WI != none)
    {
        // End:0xD0
        foreach WI.LocalPlayerControllers(Class'GameFramework.GamePlayerController', GPC)
        {
            MPI = MobilePlayerInput(GPC.PlayerInput);
            // End:0xCF
            if(MPI != none)
            {
                MPI.AddKismetRawInputEventHandler(self);
                // End:0xD0
                break;
            }            
        }        
    }
    //return;    
}

defaultproperties
{
    MaxTriggerCount=0
    OutputLinks[0]=(Links=none,LinkDesc="Touch Begin",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Touch Update",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Touch End",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Touch Cancel",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Touch Location X",LinkVar="None",PropertyName="TouchLocationX",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Touch Location Y",LinkVar="None",PropertyName="TouchLocationY",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Float',LinkedVariables=none,LinkDesc="Timestamp",LinkVar="None",PropertyName="TimeStamp",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Mobile Raw Input Access [Old]"
}