class PathGoalEvaluator extends Object
    native(AI);

var protected PathGoalEvaluator NextEvaluator;
var protected NavigationPoint GeneratedGoal;
var protected int MaxPathVisits;
var const int CacheIdx;

event Recycle()
{
    GeneratedGoal = none;
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
    MaxPathVisits=2048
    CacheIdx=-1
}