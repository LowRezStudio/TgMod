class GameCrowdBehavior_WaitInQueue extends GameCrowdAgentBehavior
    native;

var bool bStoppingBehavior;
var GameCrowdDestinationQueuePoint QueuePosition;

// Export UGameCrowdBehavior_WaitInQueue::execHandleMovement(FFrame&, void* const)
native function bool HandleMovement();

function ChangingDestination(GameCrowdDestination NewDest)
{
    // End:0x0F
    if(QueuePosition == none)
    {
    }
    MyAgent.StopBehavior();
    //return;    
}

function Actor GetDestinationActor()
{
    return QueuePosition;
    //return ReturnValue;    
}

function string GetBehaviorString()
{
    // End:0x3B
    if(QueuePosition != none)
    {
        return (string(self) $ " Waiting in line at ") $ string(QueuePosition);        
    }
    else
    {
        return string(self) $ " Queue Behavior with NO QUEUEPOSITION!";
    }
    //return ReturnValue;    
}

// Export UGameCrowdBehavior_WaitInQueue::execShouldEndIdle(FFrame&, void* const)
native function bool ShouldEndIdle();

function StopBehavior()
{
    // End:0x92
    if(!bStoppingBehavior)
    {
        bStoppingBehavior = true;
        super.StopBehavior();
        // End:0x5C
        if(QueuePosition != none)
        {
            QueuePosition.ClearQueue(MyAgent);
        }
        QueuePosition = none;
        MyAgent.StopIdleAnimation();
        bStoppingBehavior = false;
    }
    //return;    
}

defaultproperties
{
    bIdleBehavior=true
}