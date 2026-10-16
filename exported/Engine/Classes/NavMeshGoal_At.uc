class NavMeshGoal_At extends NavMeshPathGoalEvaluator
    native(AI);

var Vector Goal;
var float GoalDist;
var bool bKeepPartial;
var bool bWeightPartialByDist;
var bool bGoalInSamePolyAsAnchor;
var float PartialDistSq;
var private native Pointer GoalPoly;
var private native Pointer PartialGoal;

// Export UNavMeshGoal_At::execRecycleNative(FFrame&, void* const)
native function RecycleNative();

static function bool AtActor(NavigationHandle NavHandle, Actor GoalActor, optional float Dist, optional bool bReturnPartial, optional bool bInWeightPartialByDist)
{
    local Controller GoalController, MyController;
    local Vector TargetLoc;

    // End:0x127
    if(NavHandle != none)
    {
        GoalController = Controller(GoalActor);
        // End:0x65
        if(GoalController != none)
        {
            GoalActor = GoalController.Pawn;
        }
        // End:0x127
        if(GoalActor != none)
        {
            MyController = Controller(NavHandle.Outer);
            NavHandle.PopulatePathfindingParamCache();
            TargetLoc = GoalActor.GetDestination(MyController);
            return AtLocation(NavHandle, TargetLoc, Dist, bReturnPartial);
        }
    }
    return false;
    //return ReturnValue;    
}

static function bool AtLocation(NavigationHandle NavHandle, Vector GoalLocation, optional float Dist, optional bool bReturnPartial, optional bool bInWeightPartialByDist)
{
    local NavMeshGoal_At Eval;

    // End:0x12A
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_At(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0x12A
        if(Eval != none)
        {
            Eval.Goal = GoalLocation;
            Eval.GoalDist = Dist;
            Eval.bKeepPartial = bReturnPartial;
            Eval.bWeightPartialByDist = bInWeightPartialByDist;
            NavHandle.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    Goal = vect(0.0000000, 0.0000000, 0.0000000);
    GoalDist = default.GoalDist;
    bKeepPartial = default.bKeepPartial;
    bWeightPartialByDist = default.bWeightPartialByDist;
    PartialDistSq = default.PartialDistSq;
    RecycleNative();
    super.Recycle();
    //return;    
}

defaultproperties
{
    PartialDistSq=1000000000000.0000000
    bDoPartialAStar=true
    MaxOpenListSize=2048
}