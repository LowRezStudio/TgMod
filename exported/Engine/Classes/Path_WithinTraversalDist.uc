class Path_WithinTraversalDist extends PathConstraint
    native(AI);

var() float MaxTraversalDist;
var() bool bSoft;
var() float SoftStartPenalty;

static function bool DontExceedMaxDist(Pawn P, float InMaxTraversalDist, optional bool bInSoft = true)
{
    local Path_WithinTraversalDist Con;

    // End:0xEF
    if((P != none) && InMaxTraversalDist > 0.0000000)
    {
        Con = Path_WithinTraversalDist(P.CreatePathConstraint(default.Class));
        // End:0xEF
        if(Con != none)
        {
            Con.MaxTraversalDist = InMaxTraversalDist;
            Con.bSoft = bInSoft;
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
    MaxTraversalDist = default.MaxTraversalDist;
    bSoft = default.bSoft;
    SoftStartPenalty = default.SoftStartPenalty;
    //return;    
}

defaultproperties
{
    bSoft=true
    SoftStartPenalty=320.0000000
    CacheIdx=4
}