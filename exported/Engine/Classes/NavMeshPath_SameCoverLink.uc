class NavMeshPath_SameCoverLink extends NavMeshPathConstraint
    native(AI);

var CoverLink TestLink;

static final function SameCoverLink(NavigationHandle NavHandle, CoverLink InLink)
{
    local NavMeshPath_SameCoverLink NewConstraint;

    NewConstraint = NavMeshPath_SameCoverLink(NavHandle.CreatePathConstraint(default.Class));
    NewConstraint.TestLink = InLink;
    NavHandle.AddPathConstraint(NewConstraint);
    //return;    
}

function Recycle()
{
    super.Recycle();
    TestLink = none;
    //return;    
}
