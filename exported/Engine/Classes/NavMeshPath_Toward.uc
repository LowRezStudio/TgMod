class NavMeshPath_Toward extends NavMeshPathConstraint
    native(AI);

var bool bBiasAgainstHighLevelPath;
var float OutOfHighLevelPathBias;
var Actor GoalActor;
var Vector GoalPoint;

static function bool TowardGoal(NavigationHandle NavHandle, Actor Goal)
{
    local NavMeshPath_Toward Con;

    // End:0xBC
    if((NavHandle != none) && Goal != none)
    {
        Con = NavMeshPath_Toward(NavHandle.CreatePathConstraint(default.Class));
        // End:0xBC
        if(Con != none)
        {
            Con.GoalActor = Goal;
            NavHandle.AddPathConstraint(Con);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

static function bool TowardPoint(NavigationHandle NavHandle, Vector Point)
{
    local NavMeshPath_Toward Con;

    // End:0xC8
    if((NavHandle != none) && Point != vect(0.0000000, 0.0000000, 0.0000000))
    {
        Con = NavMeshPath_Toward(NavHandle.CreatePathConstraint(default.Class));
        // End:0xC8
        if(Con != none)
        {
            Con.GoalPoint = Point;
            NavHandle.AddPathConstraint(Con);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    GoalActor = none;
    GoalPoint = default.GoalPoint;
    //return;    
}

defaultproperties
{
    bBiasAgainstHighLevelPath=true
    OutOfHighLevelPathBias=5000.0000000
}