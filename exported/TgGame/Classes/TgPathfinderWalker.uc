class TgPathfinderWalker extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation);

var TgPathfinder m_Pathfinder;
var SplineActor m_CurrentSpline;
var float m_fCurrentSplineDist;
//var delegate<OnFinishedPathing> __OnFinishedPathing__Delegate;

delegate OnFinishedPathing(TgPathfinderWalker PathfinderWalker)
{
    //return;    
}

// Export UTgPathfinderWalker::execSetPathfinder(FFrame&, void* const)
native function SetPathfinder(TgPathfinder Pathfinder);

function Destroyed()
{
    OnFinishedPathing(self);
    super.Destroyed();
    //return;    
}

defaultproperties
{
    Physics=EPhysics.PHYS_Custom
}