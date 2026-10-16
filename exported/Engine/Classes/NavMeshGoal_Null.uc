class NavMeshGoal_Null extends NavMeshPathGoalEvaluator
    native(AI);

var private native Pointer PartialGoal;

static function bool GoUntilBust(NavigationHandle NavHandle, optional int InMaxPathVisits = -1)
{
    local NavMeshGoal_Null Eval;

    // End:0xC3
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_Null(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0xC3
        if(Eval != none)
        {
            // End:0x99
            if(InMaxPathVisits > 0)
            {
                Eval.MaxPathVisits = InMaxPathVisits;
            }
            NavHandle.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

// Export UNavMeshGoal_Null::execRecycleNative(FFrame&, void* const)
native function RecycleNative();

function Recycle()
{
    super.Recycle();
    MaxPathVisits = default.MaxPathVisits;
    RecycleNative();
    //return;    
}

defaultproperties
{
    MaxPathVisits=2048
}