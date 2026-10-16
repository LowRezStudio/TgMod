class SeqEvent_Mover extends SequenceEvent
    native(Sequence)
    hidecategories(Object,SequenceEvent);

var() float StayOpenTime;

event RegisterEvent()
{
    local InterpActor Mover;

    Mover = InterpActor(Originator);
    // End:0x53
    if(Mover != none)
    {
        Mover.StayOpenTime = StayOpenTime;
    }
    //return;    
}

function NotifyEncroachingOn(Actor Hit)
{
    local SeqVar_Object ObjVar;
    local array<int> ActivateIndices;

    ActivateIndices[0] = 3;
    // End:0x8C
    if(CheckActivate(Originator, Instigator, false, ActivateIndices, true))
    {
        // End:0x8B
        foreach LinkedVariables(Class'Engine.SeqVar_Object', ObjVar, "Actor Hit")
        {
            ObjVar.SetObjectValue(Hit);            
        }        
    }
    //return;    
}

function NotifyAttached(Actor Other)
{
    local array<int> ActivateIndices;

    // End:0x72
    if((Pawn(Other) != none) && IsZero(Originator.Velocity))
    {
        ActivateIndices[0] = 0;
        CheckActivate(Originator, Other, false, ActivateIndices);
    }
    //return;    
}

function NotifyDetached(Actor Other)
{
    local Pawn P;
    local array<int> ActivateIndices;

    // End:0x12
    if(Originator == none)
    {        
    }
    else
    {
        // End:0x90
        if(Pawn(Other) != none)
        {
            // End:0x5B
            foreach Originator.BasedActors(Class'Engine.Pawn', P)
            {                
                return;                
            }            
            ActivateIndices[0] = 1;
            CheckActivate(Originator, Instigator, false, ActivateIndices);
        }
    }
    //return;    
}

function NotifyFinishedOpen()
{
    local array<int> ActivateIndices;

    ActivateIndices[0] = 2;
    CheckActivate(Originator, Instigator, false, ActivateIndices);
    //return;    
}

defaultproperties
{
    StayOpenTime=1.5000000
    MaxTriggerCount=0
    bPlayerOnly=false
    OutputLinks[0]=(Links=none,LinkDesc="Pawn Attached",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Pawn Detached",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Open Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[3]=(Links=none,LinkDesc="Hit Actor",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Instigator",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Actor Hit",LinkVar="None",PropertyName="None",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Mover"
}