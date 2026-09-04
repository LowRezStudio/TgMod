class GameCrowdAgentBehavior extends Object
    abstract
    native;

enum ECrowdBehaviorEvent
{
    CBE_None,                       // 0
    CBE_Spawn,                      // 1
    CBE_Random,                     // 2
    CBE_SeePlayer,                  // 3
    CBE_EncounterAgent,             // 4
    CBE_TakeDamage,                 // 5
    CBE_GroupWaiting,               // 6
    CBE_Uneasy,                     // 7
    CBE_Alert,                      // 8
    CBE_Panic,                      // 9
    CBE_MAX                         // 10
};

var GameCrowdAgentBehavior.ECrowdBehaviorEvent MyEventType;
var() GameCrowdAgentBehavior.ECrowdBehaviorEvent ViralBehaviorEvent;
var() float DurationOfBehavior;
var float TimeUntilStopBehavior;
var() bool bIdleBehavior;
var() bool bFaceActionTargetFirst;
var() bool bIsViralBehavior;
var() bool bPassOnIsViralBehaviorFlag;
var Actor ActionTarget;
var() float MaxPlayerDistance;
var() float ViralRadius;
var() float DurationBeforeBecomesViral;
var transient float TimeToBecomeViral;
var() float DurationOfViralBehaviorPropagation;
var transient float TimeToStopPropagatingViralBehavior;
var GameCrowdAgent MyAgent;
var(Debug) Color DebugBehaviorColor;

// Export UGameCrowdAgentBehavior::execTriggerCrowdBehavior(FFrame&, void* const)
native static function GameCrowdBehaviorPoint TriggerCrowdBehavior(GameCrowdAgentBehavior.ECrowdBehaviorEvent EventType, Actor Instigator, Vector AtLocation, float InRange, float InDuration, optional Actor BaseActor, optional bool bRequireLOS);

// Export UGameCrowdAgentBehavior::execShouldEndIdle(FFrame&, void* const)
native function bool ShouldEndIdle();

// Export UGameCrowdAgentBehavior::execTick(FFrame&, void* const)
native event Tick(float DeltaTime);

function bool CanBeUsedBy(GameCrowdAgent Agent, Vector CameraLoc)
{
    // End:0x6D
    if((Agent.CurrentBehavior != none) && int(Agent.CurrentBehavior.MyEventType) == int(MyEventType))
    {
        return false;
    }
    return VSizeSq(CameraLoc - Agent.Location) < (MaxPlayerDistance * MaxPlayerDistance);
    //return ReturnValue;    
}

event FinishedTargetRotation()
{
    //return;    
}

// Export UGameCrowdAgentBehavior::execHandleMovement(FFrame&, void* const)
native function bool HandleMovement();

function InitBehavior(GameCrowdAgent Agent)
{
    MyAgent = Agent;
    // End:0x6E
    if(DurationBeforeBecomesViral > 0.0000000)
    {
        TimeToBecomeViral = MyAgent.WorldInfo.TimeSeconds + DurationBeforeBecomesViral;
    }
    // End:0xC9
    if(DurationOfViralBehaviorPropagation > 0.0000000)
    {
        TimeToStopPropagatingViralBehavior = MyAgent.WorldInfo.TimeSeconds + DurationOfViralBehaviorPropagation;
    }
    // End:0xEF
    if(DurationOfBehavior > 0.0000000)
    {
        TimeUntilStopBehavior = DurationOfBehavior;
    }
    //return;    
}

function StopBehavior()
{
    //return;    
}

event OnAnimEnd(AnimNodeSequence SeqNode, float PlayedTime, float ExcessTime)
{
    //return;    
}

function string GetBehaviorString()
{
    return "Behavior: " $ string(self);
    //return ReturnValue;    
}

function ChangingDestination(GameCrowdDestination NewDest)
{
    //return;    
}

function Actor GetDestinationActor()
{
    return MyAgent.CurrentDestination;
    //return ReturnValue;    
}

function ActivatedBy(Actor NewActionTarget)
{
    ActionTarget = NewActionTarget;
    //return;    
}

function Actor GetBehaviorInstigator()
{
    return ActionTarget;
    //return ReturnValue;    
}

event PropagateViralBehaviorTo(GameCrowdAgent OtherAgent)
{
    // End:0x51
    if(int(ViralBehaviorEvent) != int(0))
    {
        OtherAgent.HandleBehaviorEvent(ViralBehaviorEvent, GetBehaviorInstigator(), true, bPassOnIsViralBehaviorFlag);
    }
    //return;    
}

function bool AllowThisDestination(GameCrowdDestination Destination)
{
    return true;
    //return ReturnValue;    
}

function bool AllowBehaviorAt(GameCrowdDestination Destination)
{
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    bPassOnIsViralBehaviorFlag=true
    MaxPlayerDistance=10000.0000000
    ViralRadius=512.0000000
}