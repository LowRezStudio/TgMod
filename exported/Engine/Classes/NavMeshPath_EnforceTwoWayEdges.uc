class NavMeshPath_EnforceTwoWayEdges extends NavMeshPathConstraint
    native(AI);

static function bool EnforceTwoWayEdges(NavigationHandle NavHandle)
{
    local NavMeshPath_EnforceTwoWayEdges Con;

    // End:0x83
    if(NavHandle != none)
    {
        Con = NavMeshPath_EnforceTwoWayEdges(NavHandle.CreatePathConstraint(default.Class));
        // End:0x83
        if(Con != none)
        {
            NavHandle.AddPathConstraint(Con);
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}
