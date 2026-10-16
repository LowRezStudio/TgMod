class NavMeshPath_BiasAgainstPolysWithinDistanceOfLocations extends NavMeshPathConstraint
    native;

var transient Vector Location;
var transient Vector Rotation;
var transient float DistanceToCheck;
var transient array<Vector> LocationsToCheck;

static function bool BiasAgainstPolysWithinDistanceOfLocations(NavigationHandle NavHandle, const Vector InLocation, const Rotator InRotation, const float InDistanceToCheck, const array<Vector> InLocationsToCheck)
{
    local NavMeshPath_BiasAgainstPolysWithinDistanceOfLocations Con;

    // End:0x125
    if(NavHandle != none)
    {
        Con = NavMeshPath_BiasAgainstPolysWithinDistanceOfLocations(NavHandle.CreatePathConstraint(default.Class));
        // End:0x125
        if(Con != none)
        {
            Con.Location = InLocation;
            Con.Rotation = Vector(InRotation);
            Con.DistanceToCheck = InDistanceToCheck;
            Con.LocationsToCheck = InLocationsToCheck;
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
    //return;    
}
