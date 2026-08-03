class NavMeshGoal_OutOfViewFrom extends NavMeshPathGoalEvaluator
    native;

var private native Pointer GoalPoly;
var Vector OutOfViewLocation;
var bool bShowDebug;

// Export UNavMeshGoal_OutOfViewFrom::execRecycleNative(FFrame&, void* const)
native function RecycleNative();

static function bool MustBeHiddenFromThisPoint(NavigationHandle NavHandle, Vector InOutOfViewLocation)
{
    local NavMeshGoal_OutOfViewFrom Eval;

    // End:0xAB
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_OutOfViewFrom(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0xAB
        if(Eval != none)
        {
            Eval.OutOfViewLocation = InOutOfViewLocation;
            NavHandle.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    RecycleNative();
    super.Recycle();
    //return;    
}
