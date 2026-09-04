class NavMeshGoalFilter_PolyEncompassesAI extends NavMeshGoal_Filter
    native(AI);

var transient Vector OverrideExtentToCheck;

static function bool MakeSureAIFits(NavMeshGoal_GenericFilterContainer FilterContainer, const optional Vector InOverrideExtentToCheck)
{
    local NavMeshGoalFilter_PolyEncompassesAI Eval;

    // End:0xAF
    if(FilterContainer != none)
    {
        Eval = NavMeshGoalFilter_PolyEncompassesAI(FilterContainer.GetFilterOfType(default.Class));
        // End:0xAF
        if(Eval != none)
        {
            Eval.OverrideExtentToCheck = InOverrideExtentToCheck;
            FilterContainer.GoalFilters.AddItem(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
