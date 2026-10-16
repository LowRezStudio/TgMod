class SeqAct_AIMoveToActor extends SeqAct_Latent
    native(Sequence)
    hidecategories(Object);

var() bool bInterruptable;
var() bool bPickClosest;
var() array<Actor> Destination;
var() float MovementSpeedModifier;
var() Actor LookAt;
var transient int LastDestinationChoice;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 2;
    //return ReturnValue;    
}

function Actor PickDestination(Actor Requestor)
{
    local float Dist, bestDist;
    local Actor Dest, BestDest;

    // End:0xCB
    if(bPickClosest)
    {
        // End:0xBD
        foreach Destination(Dest)
        {
            Dist = VSize(Dest.Location - Requestor.Location);
            // End:0xBC
            if((BestDest == none) || Dist < bestDist)
            {
                BestDest = Dest;
                bestDist = Dist;
            }            
        }        
        return BestDest;        
    }
    else
    {
        // End:0xFF
        if((LastDestinationChoice < 0) || LastDestinationChoice >= Destination.Length)
        {
            LastDestinationChoice = 0;
        }
        return Destination[LastDestinationChoice++];
    }
    //return ReturnValue;    
}

defaultproperties
{
    MovementSpeedModifier=1.0000000
    OutputLinks[0]=(Links=none,LinkDesc="Finished",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="Aborted",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Out",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Target",LinkVar="None",PropertyName="Targets",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Destination",LinkVar="None",PropertyName="Destination",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[2]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Look At",LinkVar="None",PropertyName="LookAt",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Move To Actor"
}