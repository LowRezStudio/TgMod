class TgNavRouteIndicator extends TgSkeletalMeshActorSpawnable
    native(Navigation)
    hidecategories(Navigation)
    implements(Interface_NavigationHandle)
    config(Engine);

const TG_NAV_ROUTE_INDICATOR_SPINUP_FX_ID = 0;

const TG_NAV_ROUTE_INDICATOR_PATHING_FX_ID = 2276;

const TG_NAV_ROUTE_INDICATOR_SPINDOWN_FX_ID = 0;

enum eSetRouteResult {
    SetRoute_Failed,  // 0
    SetRoute_OK,  // 1
    SetRoute_AtDestination,  // 2
};

var init array<init Vector> WayPoints;
var int Position;
var float m_fPositionStartTime;
var float m_fPositionMaxSeekTime;
var float m_fSpinUpTime;
var float m_fSpinDownTime;
var TgSpecialFx m_SpinUpFx;
var TgSpecialFx m_PathingFx;
var TgSpecialFx m_SpinDownFx;
var editinline NavigationHandle NavigationHandle;

native function ActivateSpinUpFx();  // Export UTgNavRouteIndicator::execActivateSpinUpFx(FFrame&, void* const)

native function ActivateSpinDownFx();  // Export UTgNavRouteIndicator::execActivateSpinDownFx(FFrame&, void* const)

native function ActivatePathingFx();  // Export UTgNavRouteIndicator::execActivatePathingFx(FFrame&, void* const)

native function DeactivateFx();  // Export UTgNavRouteIndicator::execDeactivateFx(FFrame&, void* const)

native function DeactivatePathingFx();  // Export UTgNavRouteIndicator::execDeactivatePathingFx(FFrame&, void* const)

native function TgNavRouteIndicator.eSetRouteResult SetRoute(Actor destActor);  // Export UTgNavRouteIndicator::execSetRoute(FFrame&, void* const)

native function Vector GetCurrentWayPoint();  // Export UTgNavRouteIndicator::execGetCurrentWayPoint(FFrame&, void* const)

native function bool AdvanceWayPoint();  // Export UTgNavRouteIndicator::execAdvanceWayPoint(FFrame&, void* const)

native function UpdateRotation(float fDeltaSeconds);  // Export UTgNavRouteIndicator::execUpdateRotation(FFrame&, void* const)

simulated event PostBeginPlay() { }

simulated function Destroyed() { }

simulated function TgNavRouteIndicator.eSetRouteResult SetRouteTo(Actor destActor) { }

simulated event FindNavHandlePath(Actor destActor, float Dist) { }

simulated function StartSeeking() { }

simulated function StartNextPath() { }

function float GetMaxSpeed() { }

event NotifyPathChanged() { }

state SpinUp {}

state SpinDown {}

state Pathing {}

defaultproperties
{}
