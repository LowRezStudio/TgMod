class NavMeshGoalFilter_MinPathDistance extends NavMeshGoal_Filter
    native(AI);

var protected transient int MinDistancePathShouldBe;

static function bool MustBeLongerPathThan(NavMeshGoal_GenericFilterContainer FilterContainer, int InMinDistancePathShouldBe)
{
    local NavMeshGoalFilter_MinPathDistance Eval;

    // End:0xAE
    if(FilterContainer != none)
    {
        Eval = NavMeshGoalFilter_MinPathDistance(FilterContainer.GetFilterOfType(default.Class));
        // End:0xAE
        if(Eval != none)
        {
            Eval.MinDistancePathShouldBe = InMinDistancePathShouldBe;
            FilterContainer.GoalFilters.AddItem(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
