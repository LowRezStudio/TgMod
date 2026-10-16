class SeqEvent_Touch extends SequenceEvent
    native(Sequence)
    hidecategories(Object);

var(TouchTypes) array< Class<Actor> > ClassProximityTypes;
var(TouchTypes) array< Class<Actor> > IgnoredClassProximityTypes;
var() bool bForceOverlapping;
var() bool bUseInstigator;
var() bool bAllowDeadPawns;
var array<Actor> TouchedList;

// Export USeqEvent_Touch::execCheckTouchActivate(FFrame&, void* const)
native final function bool CheckTouchActivate(Actor InOriginator, Actor InInstigator, optional bool bTest);

// Export USeqEvent_Touch::execCheckUnTouchActivate(FFrame&, void* const)
native final function bool CheckUnTouchActivate(Actor InOriginator, Actor InInstigator, optional bool bTest);

event Toggled()
{
    local int Idx;

    // End:0xA1
    if(bEnabled)
    {
        // End:0x9E
        if(Originator != none)
        {
            Idx = 0;
            J0x27:

            // End:0x9E [Loop If]
            if(Idx < Originator.Touching.Length)
            {
                CheckTouchActivate(Originator, Originator.Touching[Idx]);
                Idx++;
                // [Loop Continue]
                goto J0x27;
            }
        }        
    }
    else
    {
        TouchedList.Length = 0;
    }
    //return;    
}

function NotifyTouchingPawnDied(Pawn P)
{
    // End:0x2C
    if(!bAllowDeadPawns)
    {
        CheckUnTouchActivate(Originator, P);
    }
    //return;    
}

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 1;
    //return ReturnValue;    
}

defaultproperties
{
    ClassProximityTypes[0]=Class'Engine.Pawn'
    bForceOverlapping=true
    ReTriggerDelay=0.1000000
    OutputLinks[0]=(Links=none,LinkDesc="Touched",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[1]=(Links=none,LinkDesc="UnTouched",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    OutputLinks[2]=(Links=none,LinkDesc="Empty",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    ObjName="Touch"
}