class TgNavMeshPath_AlongLane extends NavMeshPathConstraint
    native(Navigation);

var int m_nLane;

static function bool AlongLane(NavigationHandle NavHandle, int nLane)
{
    local TgNavMeshPath_AlongLane Con;

    // End:0xBC
    if((NavHandle != none) && nLane > 0)
    {
        Con = TgNavMeshPath_AlongLane(NavHandle.CreatePathConstraint(default.Class));
        // End:0xBC
        if(Con != none)
        {
            Con.m_nLane = nLane;
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
    m_nLane = 0;
    //return;    
}
