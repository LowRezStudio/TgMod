class Path_TowardPoint extends PathConstraint
    native(AI);

var Vector GoalPoint;

static function bool TowardPoint(Pawn P, Vector Point)
{
    local Path_TowardPoint Con;

    // End:0xC8
    if((P != none) && Point != vect(0.0000000, 0.0000000, 0.0000000))
    {
        Con = Path_TowardPoint(P.CreatePathConstraint(default.Class));
        // End:0xC8
        if(Con != none)
        {
            Con.GoalPoint = Point;
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
    GoalPoint = default.GoalPoint;
    //return;    
}

defaultproperties
{
    CacheIdx=2
}