class GameCrowdBehavior_WaitForGroup extends GameCrowdAgentBehavior
    native;

function InitBehavior(GameCrowdAgent Agent)
{
    super.InitBehavior(Agent);
    Agent.PlayIdleAnimation();
    //return;    
}

function string GetBehaviorString()
{
    local string BehaviorString;

    BehaviorString = "Behavior: " $ string(self);
    // End:0x5E
    if(bFaceActionTargetFirst)
    {
        BehaviorString = (BehaviorString @ "Turning toward ") $ string(ActionTarget);        
    }
    else
    {
        BehaviorString = BehaviorString @ "Waiting For Group";
    }
    return BehaviorString;
    //return ReturnValue;    
}

// Export UGameCrowdBehavior_WaitForGroup::execShouldEndIdle(FFrame&, void* const)
native function bool ShouldEndIdle();

function StopBehavior()
{
    super.StopBehavior();
    MyAgent.StopIdleAnimation();
    //return;    
}

defaultproperties
{
    bIdleBehavior=true
    bFaceActionTargetFirst=true
}