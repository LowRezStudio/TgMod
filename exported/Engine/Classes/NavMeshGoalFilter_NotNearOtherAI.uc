class NavMeshGoalFilter_NotNearOtherAI extends NavMeshGoal_Filter
    native(AI);

var transient float DistanceToCheck;

static function bool NotNearOtherAI(NavMeshGoal_GenericFilterContainer FilterContainer, const float InDistanceToCheck)
{
    local NavMeshGoalFilter_NotNearOtherAI Eval;

    // End:0xAE
    if(FilterContainer != none)
    {
        Eval = NavMeshGoalFilter_NotNearOtherAI(FilterContainer.GetFilterOfType(default.Class));
        // End:0xAE
        if(Eval != none)
        {
            Eval.DistanceToCheck = InDistanceToCheck;
            FilterContainer.GoalFilters.AddItem(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
