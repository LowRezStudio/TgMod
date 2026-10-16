class NavMeshPath_WithinTraversalDist extends NavMeshPathConstraint
    native(AI);

var() float MaxTraversalDist;
var() bool bSoft;
var() float SoftStartPenalty;

static function bool DontExceedMaxDist(NavigationHandle NavHandle, float InMaxTraversalDist, optional bool bInSoft = true)
{
    local NavMeshPath_WithinTraversalDist Con;

    // End:0xEF
    if((NavHandle != none) && InMaxTraversalDist > 0.0000000)
    {
        Con = NavMeshPath_WithinTraversalDist(NavHandle.CreatePathConstraint(default.Class));
        // End:0xEF
        if(Con != none)
        {
            Con.MaxTraversalDist = InMaxTraversalDist;
            Con.bSoft = bInSoft;
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
    MaxTraversalDist = default.MaxTraversalDist;
    bSoft = default.bSoft;
    SoftStartPenalty = default.SoftStartPenalty;
    //return;    
}

defaultproperties
{
    bSoft=true
    SoftStartPenalty=320.0000000
}