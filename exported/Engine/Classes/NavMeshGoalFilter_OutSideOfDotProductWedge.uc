class NavMeshGoalFilter_OutSideOfDotProductWedge extends NavMeshGoal_Filter
    native(AI);

var transient Vector Location;
var transient Vector Rotation;
var transient float Epsilon;

static function bool OutsideOfDotProductWedge(NavMeshGoal_GenericFilterContainer FilterContainer, Vector InLocation, Rotator InRotation, float InEpsilon)
{
    local NavMeshGoalFilter_OutSideOfDotProductWedge Eval;

    // End:0x100
    if(FilterContainer != none)
    {
        Eval = NavMeshGoalFilter_OutSideOfDotProductWedge(FilterContainer.GetFilterOfType(default.Class));
        // End:0x100
        if(Eval != none)
        {
            Eval.Location = InLocation;
            Eval.Rotation = Vector(InRotation);
            Eval.Epsilon = InEpsilon;
            FilterContainer.GoalFilters.AddItem(Eval);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
