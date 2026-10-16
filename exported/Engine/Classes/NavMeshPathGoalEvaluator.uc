class NavMeshPathGoalEvaluator extends Object
    native(AI);

struct native BiasedGoalActor
{
    var Actor Goal;
    var int ExtraCost;

    structdefaultproperties
    {
        Goal=none
        ExtraCost=0
    }
};

var protected transient NavMeshPathGoalEvaluator NextEvaluator;
var protected int MaxPathVisits;
var bool bAlwaysCallEvaluateGoal;
var bool bDoPartialAStar;
var transient int NumNodesThrownOut;
var transient int NumNodesProcessed;
var int MaxOpenListSize;

event Recycle()
{
    NumNodesThrownOut = 0;
    NumNodesProcessed = 0;
    NextEvaluator = none;
    //return;    
}

event string GetDumpString()
{
    return string(self);
    //return ReturnValue;    
}

defaultproperties
{
    MaxPathVisits=1024
}