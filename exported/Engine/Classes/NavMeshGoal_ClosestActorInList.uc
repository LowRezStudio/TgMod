class NavMeshGoal_ClosestActorInList extends NavMeshPathGoalEvaluator
    native(AI);

var array<BiasedGoalActor> GoalList;
var private native const transient MultiMap_Mirror PolyToGoalActorMap;
var native Pointer CachedAnchorPoly;

static function NavMeshGoal_ClosestActorInList ClosestActorInList(NavigationHandle NavHandle, const out array<BiasedGoalActor> InGoalList)
{
    local NavMeshGoal_ClosestActorInList Eval;

    Eval = NavMeshGoal_ClosestActorInList(NavHandle.CreatePathGoalEvaluator(default.Class));
    Eval.GoalList = InGoalList;
    NavHandle.AddGoalEvaluator(Eval);
    return Eval;
    //return ReturnValue;    
}

event Recycle()
{
    super.Recycle();
    GoalList.Length = 0;
    RecycleInternal();
    //return;    
}

// Export UNavMeshGoal_ClosestActorInList::execRecycleInternal(FFrame&, void* const)
native function RecycleInternal();

defaultproperties
{
    MaxPathVisits=3000
}