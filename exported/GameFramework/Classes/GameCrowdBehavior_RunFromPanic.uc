class GameCrowdBehavior_RunFromPanic extends GameCrowdAgentBehavior
    native;

var transient Actor PanicFocus;

function ActivatedBy(Actor NewActionTarget)
{
    local GameCrowdDestination TempDest, PrevDest;

    PanicFocus = NewActionTarget;
    PrevDest = MyAgent.PreviousDestination;
    // End:0x91
    if((MyAgent.CurrentDestination != none) && AllowThisDestination(MyAgent.CurrentDestination))
    {
        return;        
    }
    else
    {
        // End:0x1B7
        if((PrevDest != none) && PrevDest.AllowableDestinationFor(MyAgent))
        {
            TempDest = MyAgent.CurrentDestination;
            MyAgent.CurrentDestination.DecrementCustomerCount(MyAgent);
            MyAgent.SetCurrentDestination(MyAgent.PreviousDestination);
            MyAgent.PreviousDestination = TempDest;
            MyAgent.UpdateIntermediatePoint();
        }
    }
    //return;    
}

function InitBehavior(GameCrowdAgent Agent)
{
    super.InitBehavior(Agent);
    MyAgent.bIsPanicked = true;
    MyAgent.SetMaxSpeed();
    //return;    
}

function StopBehavior()
{
    super.StopBehavior();
    MyAgent.bIsPanicked = false;
    MyAgent.SetMaxSpeed();
    //return;    
}

function Actor GetBehaviorInstigator()
{
    return PanicFocus;
    //return ReturnValue;    
}

function bool AllowThisDestination(GameCrowdDestination Destination)
{
    return (!Destination.bAvoidWhenPanicked && !Destination.AtCapacity()) && (Destination.bFleeDestination || PanicFocus == none) || ((Destination.Location - MyAgent.Location) Dot (MyAgent.Location - PanicFocus.Location)) > 0.0000000;
    //return ReturnValue;    
}

function bool AllowBehaviorAt(GameCrowdDestination Destination)
{
    return !Destination.bSkipBehaviorIfPanicked && !Destination.bAvoidWhenPanicked;
    //return ReturnValue;    
}

function string GetBehaviorString()
{
    return "Run from PANIC " @ string(PanicFocus);
    //return ReturnValue;    
}

defaultproperties
{
    MyEventType=ECrowdBehaviorEvent.CBE_Panic
    ViralBehaviorEvent=ECrowdBehaviorEvent.CBE_Alert
    bIsViralBehavior=true
    MaxPlayerDistance=20000.0000000
    DebugBehaviorColor=(R=255,G=0,B=0,A=0)
}