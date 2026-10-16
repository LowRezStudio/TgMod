class NavMeshPath_AlongLine extends NavMeshPathConstraint
    native(AI);

var Vector Direction;

static function bool AlongLine(NavigationHandle NavHandle, Vector Dir)
{
    local NavMeshPath_AlongLine Con;

    // End:0xBE
    if((NavHandle != none) && !IsZero(Dir))
    {
        Con = NavMeshPath_AlongLine(NavHandle.CreatePathConstraint(default.Class));
        // End:0xBE
        if(Con != none)
        {
            Con.Direction = Dir;
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
    Direction = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}
