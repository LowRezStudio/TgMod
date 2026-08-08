class TgPathfinderWalker extends Actor
    native(Navigation)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var TgPathfinder m_Pathfinder;
var SplineActor m_CurrentSpline;
var float m_fCurrentSplineDist;

delegate OnFinishedPathing(TgPathfinderWalker PathfinderWalker);

native function SetPathfinder(TgPathfinder Pathfinder);  // Export UTgPathfinderWalker::execSetPathfinder(FFrame&, void* const)

function Destroyed() { }

defaultproperties
{
    Physics=PHYS_Custom
}
