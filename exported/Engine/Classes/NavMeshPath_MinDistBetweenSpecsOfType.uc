class NavMeshPath_MinDistBetweenSpecsOfType extends NavMeshPathConstraint
    native(AI);

var float MinDistBetweenEdgeTypes;
var Vector InitLocation;
var Pylon.ENavMeshEdgeType EdgeType;
var float Penalty;

static function bool EnforceMinDist(NavigationHandle NavHandle, float InMinDist, Pylon.ENavMeshEdgeType InEdgeType, optional Vector LastLocation, optional float InPenalty)
{
    local NavMeshPath_MinDistBetweenSpecsOfType Con;

    // End:0x13A
    if((NavHandle != none) && InMinDist > 0.0000000)
    {
        Con = NavMeshPath_MinDistBetweenSpecsOfType(NavHandle.CreatePathConstraint(default.Class));
        // End:0x13A
        if(Con != none)
        {
            Con.MinDistBetweenEdgeTypes = InMinDist;
            Con.InitLocation = LastLocation;
            Con.EdgeType = InEdgeType;
            Con.Penalty = InPenalty;
            NavHandle.AddPathConstraint(Con);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    MinDistBetweenEdgeTypes = default.MinDistBetweenEdgeTypes;
    EdgeType = 0;
    InitLocation = vect(0.0000000, 0.0000000, 0.0000000);
    Penalty = default.Penalty;
    //return;    
}

defaultproperties
{
    Penalty=10000.0000000
}