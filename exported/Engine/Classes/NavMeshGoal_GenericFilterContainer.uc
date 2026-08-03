class NavMeshGoal_GenericFilterContainer extends NavMeshPathGoalEvaluator
    native(AI);

var export editinline transient array<export editinline NavMeshGoal_Filter> GoalFilters;
var private native transient Pointer SuccessfulGoal;
var protected transient NavigationHandle MyNavigationHandle;
var transient array<Vector> SeedLocations;

static function NavMeshGoal_GenericFilterContainer CreateAndAddFilterToNavHandle(NavigationHandle NavHandle, optional int InMaxPathVisits = -1)
{
    local NavMeshGoal_GenericFilterContainer Eval;

    // End:0x163
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_GenericFilterContainer(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0x163
        if(Eval != none)
        {
            // End:0x99
            if(InMaxPathVisits > 0)
            {
                Eval.MaxPathVisits = InMaxPathVisits;
            }
            Eval.MyNavigationHandle = NavHandle;
            Eval.SeedLocations[Eval.SeedLocations.Length] = NavHandle.CachedPathParams.SearchStart;
            NavHandle.AddGoalEvaluator(Eval);
            return Eval;
        }
    }
    return none;
    //return ReturnValue;    
}

static function NavMeshGoal_GenericFilterContainer CreateAndAddFilterToNavHandleFromSeedList(NavigationHandle NavHandle, out array<Vector> InSearchSeeds, optional int InMaxPathVisits = -1)
{
    local NavMeshGoal_GenericFilterContainer Eval;

    // End:0x11B
    if(NavHandle != none)
    {
        Eval = NavMeshGoal_GenericFilterContainer(NavHandle.CreatePathGoalEvaluator(default.Class));
        // End:0x11B
        if(Eval != none)
        {
            // End:0x99
            if(InMaxPathVisits > 0)
            {
                Eval.MaxPathVisits = InMaxPathVisits;
            }
            Eval.MyNavigationHandle = NavHandle;
            Eval.SeedLocations = InSearchSeeds;
            NavHandle.AddGoalEvaluator(Eval);
            return Eval;
        }
    }
    return none;
    //return ReturnValue;    
}

function NavMeshGoal_Filter GetFilterOfType(Class<NavMeshGoal_Filter> Filter_Class)
{
    return new (self) Filter_Class;
    //return ReturnValue;    
}

// Export UNavMeshGoal_GenericFilterContainer::execGetGoalPoint(FFrame&, void* const)
native function Vector GetGoalPoint();

function Recycle()
{
    super.Recycle();
    GoalFilters.Length = 0;
    MaxPathVisits = default.MaxPathVisits;
    MyNavigationHandle = none;
    //return;    
}

defaultproperties
{
    MaxPathVisits=2048
}