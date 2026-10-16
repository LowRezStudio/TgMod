class Path_MinDistBetweenSpecsOfType extends PathConstraint
    native(AI);

var float MinDistBetweenSpecTypes;
var Vector InitLocation;
var Class<ReachSpec> ReachSpecClass;

static function bool EnforceMinDist(Pawn P, float InMinDist, Class<ReachSpec> InSpecClass, optional Vector LastLocation)
{
    local Path_MinDistBetweenSpecsOfType Con;

    // End:0x135
    if(((P != none) && P.bCanMantle) && InMinDist > 0.0000000)
    {
        Con = Path_MinDistBetweenSpecsOfType(P.CreatePathConstraint(default.Class));
        // End:0x135
        if(Con != none)
        {
            Con.MinDistBetweenSpecTypes = InMinDist;
            Con.InitLocation = LastLocation;
            Con.ReachSpecClass = InSpecClass;
            P.AddPathConstraint(Con);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

function Recycle()
{
    super.Recycle();
    MinDistBetweenSpecTypes = default.MinDistBetweenSpecTypes;
    ReachSpecClass = none;
    InitLocation = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

defaultproperties
{
    CacheIdx=10
}