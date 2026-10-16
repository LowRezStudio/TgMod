class Path_AlongLine extends PathConstraint
    native(AI);

var Vector Direction;

static function bool AlongLine(Pawn P, Vector Dir)
{
    local Path_AlongLine Con;

    // End:0xBE
    if((P != none) && !IsZero(Dir))
    {
        Con = Path_AlongLine(P.CreatePathConstraint(default.Class));
        // End:0xBE
        if(Con != none)
        {
            Con.Direction = Dir;
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
    Direction = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

defaultproperties
{
    CacheIdx=0
}