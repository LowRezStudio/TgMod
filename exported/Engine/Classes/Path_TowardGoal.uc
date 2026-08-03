class Path_TowardGoal extends PathConstraint
    native(AI);

var Actor GoalActor;

static function bool TowardGoal(Pawn P, Actor Goal)
{
    local Path_TowardGoal Con;

    // End:0xBC
    if((P != none) && Goal != none)
    {
        Con = Path_TowardGoal(P.CreatePathConstraint(default.Class));
        // End:0xBC
        if(Con != none)
        {
            Con.GoalActor = Goal;
            P.AddPathConstraint(Con);
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
    //return;    
}

defaultproperties
{
    CacheIdx=1
}