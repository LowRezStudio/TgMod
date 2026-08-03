class NavMeshGoal_PolyEncompassesAI extends NavMeshPathGoalEvaluator
    native(AI);

var transient Vector OverrideExtentToCheck;

static function bool MakeSureAIFits(NavigationHandle NavHandle, const optional Vector InOverrideExtentToCheck)
{
    local NavMeshGoal_PolyEncompassesAI Eval;

    // End:0xAC
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_PolyEncompassesAI(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0xAC
        if(Eval != none)
        {
            Eval.OverrideExtentToCheck = InOverrideExtentToCheck;
            NavHandle.AddGoalEvaluator(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    //return;    
}

defaultproperties
{
    MaxPathVisits=64
}