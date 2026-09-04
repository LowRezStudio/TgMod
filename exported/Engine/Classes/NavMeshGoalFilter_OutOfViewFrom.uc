class NavMeshGoalFilter_OutOfViewFrom extends NavMeshGoal_Filter
    native(AI);

var private native transient Pointer GoalPoly;
var transient Vector OutOfViewLocation;

static function bool MustBeHiddenFromThisPoint(NavMeshGoal_GenericFilterContainer FilterContainer, Vector InOutOfViewLocation)
{
    local NavMeshGoalFilter_OutOfViewFrom Eval;

    // End:0xAE
    if(FilterContainer != none)
    {
        Eval = NavMeshGoalFilter_OutOfViewFrom(FilterContainer.GetFilterOfType(default.Class));
        // End:0xAE
        if(Eval != none)
        {
            Eval.OutOfViewLocation = InOutOfViewLocation;
            FilterContainer.GoalFilters.AddItem(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
