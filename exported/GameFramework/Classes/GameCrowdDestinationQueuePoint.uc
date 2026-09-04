class GameCrowdDestinationQueuePoint extends GameCrowdInteractionPoint
    native
    placeable
    hidecategories(Navigation,Advanced,Collision,Display,Actor,Movement,Physics);

var() GameCrowdDestinationQueuePoint NextQueuePosition;
var GameCrowdInteractionPoint PreviousQueuePosition;
var GameCrowdAgent QueuedAgent;
var transient GameCrowdDestination QueueDestination;
var bool bClearingQueue;
var bool bPendingAdvance;
var() float AverageReactionTime;
var Class<GameCrowdBehavior_WaitInQueue> QueueBehaviorClass;

// Export UGameCrowdDestinationQueuePoint::execQueueReachedBy(FFrame&, void* const)
native function bool QueueReachedBy(GameCrowdAgent Agent, Vector TestPosition);

simulated function bool HasSpace()
{
    // End:0x6E
    if((QueuedAgent == none) && ((NextQueuePosition == none) || !NextQueuePosition.bPendingAdvance) || NextQueuePosition.QueuedAgent == none)
    {
        return true;
    }
    // End:0x7F
    if(NextQueuePosition == none)
    {
        return false;
    }
    return NextQueuePosition.HasSpace();
    //return ReturnValue;    
}

simulated event ReachedDestination(GameCrowdAgent Agent)
{
    local GameCrowdDestinationQueuePoint QueuePoint;

    QueuePoint = Agent.CurrentDestination.QueueHead;
    J0x3D:

    // End:0x2BE [Loop If]
    if(QueuePoint != none)
    {
        // End:0x293
        if(QueuePoint.NextQueuePosition == self)
        {
            // End:0x97
            if(QueuePoint.QueuedAgent == none)
            {                
            }
            else
            {
                // End:0x293
                if(!QueuePoint.QueueReachedBy(QueuePoint.QueuedAgent, QueuePoint.QueuedAgent.Location) && VSizeSq(QueuePoint.Location - Agent.Location) < VSizeSq(QueuePoint.Location - QueuePoint.QueuedAgent.Location))
                {
                    QueuedAgent = QueuePoint.QueuedAgent;
                    QueuePoint.QueuedAgent = Agent;
                    GameCrowdBehavior_WaitInQueue(QueuedAgent.CurrentBehavior).QueuePosition = self;
                    GameCrowdBehavior_WaitInQueue(QueuePoint.QueuedAgent.CurrentBehavior).QueuePosition = QueuePoint;
                    return;
                }
            }
        }
        QueuePoint = QueuePoint.NextQueuePosition;
        // [Loop Continue]
        goto J0x3D;
    }
    GameCrowdBehavior_WaitInQueue(QueuedAgent.CurrentBehavior).bIdleBehavior = true;
    QueuedAgent.PlayIdleAnimation();
    //return;    
}

simulated function AdvanceCustomerTo(GameCrowdInteractionPoint FrontPosition)
{
    PreviousQueuePosition = FrontPosition;
    bPendingAdvance = true;
    SetTimer(AverageReactionTime, false, 'ActuallyAdvance');
    //return;    
}

private final simulated function ActuallyAdvance()
{
    local GameCrowdDestinationQueuePoint FrontQueuePosition;
    local GameCrowdDestination QueueFront;
    local GameCrowdAgent TempAgent;

    bPendingAdvance = false;
    // End:0x15D
    if(QueuedAgent != none)
    {
        TempAgent = QueuedAgent;
        bClearingQueue = true;
        QueuedAgent.StopBehavior();
        bClearingQueue = false;
        QueuedAgent = none;
        FrontQueuePosition = GameCrowdDestinationQueuePoint(PreviousQueuePosition);
        // End:0xC7
        if(FrontQueuePosition != none)
        {
            FrontQueuePosition.AddCustomer(TempAgent, none);            
        }
        else
        {
            QueueFront = GameCrowdDestination(PreviousQueuePosition);
            // End:0xF4
            if(QueueFront == none)
            {
                return;
            }
            QueueFront.IncrementCustomerCount(TempAgent);
        }
        // End:0x12E
        if(QueuedAgent != none)
        {            
        }
        else
        {
            // End:0x15D
            if(NextQueuePosition != none)
            {
                NextQueuePosition.AdvanceCustomerTo(self);
            }
        }
    }
    //return;    
}

simulated function AddCustomer(GameCrowdAgent NewCustomer, GameCrowdInteractionPoint PreviousPosition)
{
    // End:0x22
    if(PreviousPosition != none)
    {
        PreviousQueuePosition = PreviousPosition;
    }
    // End:0x100
    if(QueuedAgent == none)
    {
        QueuedAgent = NewCustomer;
        NewCustomer.ActivateInstancedBehavior(new (NewCustomer) QueueBehaviorClass);
        GameCrowdBehavior_WaitInQueue(NewCustomer.CurrentBehavior).QueuePosition = self;
        GameCrowdBehavior_WaitInQueue(NewCustomer.CurrentBehavior).ActionTarget = PreviousQueuePosition;        
    }
    else
    {
        // End:0x13B
        if(NextQueuePosition != none)
        {
            NextQueuePosition.AddCustomer(NewCustomer, self);            
        }
    }
    //return;    
}

simulated function ClearQueue(GameCrowdAgent OldCustomer)
{
    // End:0x9A
    if(!bClearingQueue)
    {
        bClearingQueue = true;
        // End:0x8E
        if(OldCustomer == QueuedAgent)
        {
            QueuedAgent.StopBehavior();
            QueuedAgent = none;
            // End:0x8B
            if(NextQueuePosition != none)
            {
                NextQueuePosition.AdvanceCustomerTo(self);
            }            
        }
        bClearingQueue = false;
    }
    //return;    
}

simulated function bool HasCustomer()
{
    return QueuedAgent != none;
    //return ReturnValue;    
}

defaultproperties
{
    AverageReactionTime=0.7000000
    QueueBehaviorClass=Class'GameFramework.GameCrowdBehavior_WaitInQueue'
    // Reference: CylinderComponent'GameFramework.Default__GameCrowdDestinationQueuePoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GameCrowdInteractionPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionRadius=100.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    CollisionComponent=CollisionCylinder
}