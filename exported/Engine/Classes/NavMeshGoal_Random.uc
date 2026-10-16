class NavMeshGoal_Random extends NavMeshPathGoalEvaluator
    native(AI);

var int MinDist;
var float BestRating;
var private native Pointer PartialGoal;

static function bool FindRandom(NavigationHandle NavHandle, optional int InMinDist = -1, optional int InMaxPathVisits = -1)
{
    local NavMeshGoal_Random Eval;

    // End:0xE8
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_Random(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0x93
        if(InMaxPathVisits > 0)
        {
            Eval.MaxPathVisits = InMaxPathVisits;
        }
        Eval.MinDist = InMinDist;
        NavHandle.AddGoalEvaluator(Eval);
        return true;        
    }
    else
    {
        return false;
    }
    //return ReturnValue;    
}

// Export UNavMeshGoal_Random::execRecycleNative(FFrame&, void* const)
native function RecycleNative();

function Recycle()
{
    super.Recycle();
    MaxPathVisits = default.MaxPathVisits;
    BestRating = default.BestRating;
    MinDist = default.MinDist;
    RecycleNative();
    //return;    
}

defaultproperties
{
    MinDist=-1
    BestRating=-1.0000000
}