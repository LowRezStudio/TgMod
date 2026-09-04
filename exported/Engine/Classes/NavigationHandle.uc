class NavigationHandle extends Object within Actor
    native(AI);

const LINECHECK_GRANULARITY = 768.f;
const NUM_PATHFINDING_PARAMS = 9;
const NumBreadCrumbs = 10;

struct native PolySegmentSpan
{
    var native Pointer Poly;
    var Vector P1;
    var Vector P2;

    structdefaultproperties
    {
        P1=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        P2=(X=0.0000000,Y=0.0000000,Z=0.0000000)
    }
};

struct EdgePointer
{
    var native const Pointer Dummy;
};

struct native PathStore
{
    var native array<EdgePointer> EdgeList;
};

struct native NavMeshPathParams
{
    var native Pointer Interface;
    var bool bCanMantle;
    var bool bNeedsMantleValidityTest;
    var bool bAbleToSearch;
    var Vector SearchExtent;
    var float SearchLaneMultiplier;
    var Vector SearchStart;
    var float MaxDropHeight;
    var float MinWalkableZ;
    var float MaxHoverDistance;
    var float MaxPathLength;

    structdefaultproperties
    {
        bCanMantle=false
        bNeedsMantleValidityTest=false
        bAbleToSearch=false
        SearchExtent=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        SearchLaneMultiplier=0.0000000
        SearchStart=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        MaxDropHeight=0.0000000
        MinWalkableZ=0.0000000
        MaxHoverDistance=0.0000000
        MaxPathLength=0.0000000
    }
};

var Pylon AnchorPylon;
var native Pointer AnchorPoly;
var PathStore PathCache;
var native transient Pointer BestUnfinishedPathPoint;
var native const Pointer CurrentEdge;
var native const Pointer SubGoal_DestPoly;
var BasedPosition FinalDestination;
var Actor FinalDestinationActor;
var bool bSkipRouteCacheUpdates;
var bool bUseORforEvaluateGoal;
var(PathDebug) bool bDebugConstraintsAndGoalEvals;
var(PathDebug) bool bUltraVerbosePathDebugging;
var(PathDebug) bool bVisualPathDebugging;
var() bool bDebug_Breadcrumbs;
var NavMeshPathConstraint PathConstraintList;
var NavMeshPathGoalEvaluator PathGoalList;
var NavMeshPathParams CachedPathParams;
var(PathDebug) EngineTypes.EPathFindingError LastPathError;
var(PathDebug) float LastPathFailTime;
var Vector Breadcrumbs[10];
var int BreadCrumbMostRecentIdx;
var float BreadCrumbDistanceInterval;
var float m_fLastPathLength;

// Export UNavigationHandle::execCopyPathStoreToPathCache(FFrame&, void* const)
native function CopyPathStoreToPathCache(const out PathStore InStore);

// Export UNavigationHandle::execUpdateBreadCrumbs(FFrame&, void* const)
native function UpdateBreadCrumbs(Vector InLocation);

// Export UNavigationHandle::execGetNextBreadCrumb(FFrame&, void* const)
native function bool GetNextBreadCrumb(out Vector out_BreadCrumbLoc);

// Export UNavigationHandle::execClearConstraints(FFrame&, void* const)
native function ClearConstraints();

// Export UNavigationHandle::execAddPathConstraint(FFrame&, void* const)
native function AddPathConstraint(NavMeshPathConstraint Constraint);

// Export UNavigationHandle::execAddGoalEvaluator(FFrame&, void* const)
native function AddGoalEvaluator(NavMeshPathGoalEvaluator Evaluator);

// Export UNavigationHandle::execBuildFromPylonAToPylonB(FFrame&, void* const)
native function Pylon BuildFromPylonAToPylonB(Pylon A, Pylon B);

// Export UNavigationHandle::execDoesPylonAHaveAPathToPylonB(FFrame&, void* const)
native function bool DoesPylonAHaveAPathToPylonB(Pylon A, Pylon B);

function NavMeshPathConstraint CreatePathConstraint(Class<NavMeshPathConstraint> ConstraintClass)
{
    return Outer.WorldInfo.GetNavMeshPathConstraintFromCache(ConstraintClass, self);
    //return ReturnValue;    
}

function NavMeshPathGoalEvaluator CreatePathGoalEvaluator(Class<NavMeshPathGoalEvaluator> GoalEvalClass)
{
    return Outer.WorldInfo.GetNavMeshPathGoalEvaluatorFromCache(GoalEvalClass, self);
    //return ReturnValue;    
}

function int GetPathCacheLength()
{
    return PathCache.EdgeList.Length;
    //return ReturnValue;    
}

// Export UNavigationHandle::execPathCache_Empty(FFrame&, void* const)
native function bool PathCache_Empty();

// Export UNavigationHandle::execPathCache_GetGoalPoint(FFrame&, void* const)
native function Vector PathCache_GetGoalPoint();

// Export UNavigationHandle::execPathCache_RemoveIndex(FFrame&, void* const)
native function bool PathCache_RemoveIndex(int InIdx, optional int Count = 1);

// Export UNavigationHandle::execGetBestUnfinishedPathPoint(FFrame&, void* const)
native function Vector GetBestUnfinishedPathPoint();

// Export UNavigationHandle::execFindPylon(FFrame&, void* const)
native function bool FindPylon();

// Export UNavigationHandle::execGetPylonFromPos(FFrame&, void* const)
native static function Pylon GetPylonFromPos(Vector Position);

// Export UNavigationHandle::execGetNextMoveLocation(FFrame&, void* const)
native function bool GetNextMoveLocation(out Vector out_MoveDest, float ArrivalDistance);

// Export UNavigationHandle::execSetFinalDestination(FFrame&, void* const)
native function bool SetFinalDestination(Vector FinalDest, optional Actor FinalActor);

// Export UNavigationHandle::execComputeValidFinalDestination(FFrame&, void* const)
native function bool ComputeValidFinalDestination(out Vector out_ComputedPosition);

// Export UNavigationHandle::execFindPath(FFrame&, void* const)
native function bool FindPath(optional out Actor out_DestActor, optional out int out_DestItem);

// Export UNavigationHandle::execSuggestMovePreparation(FFrame&, void* const)
native function bool SuggestMovePreparation(out Vector MovePt, Controller C);

// Export UNavigationHandle::execObstacleLineCheck(FFrame&, void* const)
native static final function bool ObstacleLineCheck(Vector Start, Vector End, Vector Extent, optional out Vector out_HitLoc, optional out Vector out_HitNorm);

// Export UNavigationHandle::execObstaclePointCheck(FFrame&, void* const)
native static final function bool ObstaclePointCheck(Vector Pt, Vector Extent);

// Export UNavigationHandle::execLineCheck(FFrame&, void* const)
native function bool LineCheck(Vector Start, Vector End, Vector Extent, optional out Vector out_HitLocation, optional out Vector out_HitNormal);

// Export UNavigationHandle::execPointCheck(FFrame&, void* const)
native function bool PointCheck(Vector Pt, Vector Extent);

// Export UNavigationHandle::execPointReachable(FFrame&, void* const)
native function bool PointReachable(Vector Point, optional Vector OverrideStartPoint, optional bool bAllowHitsInEndCollisionBox = true);

// Export UNavigationHandle::execActorReachable(FFrame&, void* const)
native function bool ActorReachable(Actor A);

// Export UNavigationHandle::execDrawPathCache(FFrame&, void* const)
native function DrawPathCache(optional Vector DrawOffset, optional bool bPersistent, optional Color DrawColor);

// Export UNavigationHandle::execPrintPathCacheDebugText(FFrame&, void* const)
native function PrintPathCacheDebugText();

// Export UNavigationHandle::execGetCurrentEdgeDebugText(FFrame&, void* const)
native function string GetCurrentEdgeDebugText();

// Export UNavigationHandle::execClearCurrentEdge(FFrame&, void* const)
native function ClearCurrentEdge();

// Export UNavigationHandle::execGetCurrentEdgeType(FFrame&, void* const)
native function Pylon.ENavMeshEdgeType GetCurrentEdgeType();

// Export UNavigationHandle::execGetAllPolyCentersWithinBounds(FFrame&, void* const)
native static function GetAllPolyCentersWithinBounds(Vector pos, Vector Extent, out array<Vector> out_PolyCtrs);

// Export UNavigationHandle::execGetValidPositionsForBox(FFrame&, void* const)
native static function GetValidPositionsForBox(Vector pos, float Radius, Vector Extent, bool bMustBeReachableFromStartPos, out array<Vector> out_ValidPositions, optional int MaxPositions = -1, optional float MinRadius, optional Vector ValidBoxAroundStartPos = vect(0.0000000, 0.0000000, 0.0000000));

// Export UNavigationHandle::execLimitPathCacheDistance(FFrame&, void* const)
native function LimitPathCacheDistance(float MaxDist);

// Export UNavigationHandle::execIsAnchorInescapable(FFrame&, void* const)
native function bool IsAnchorInescapable();

// Export UNavigationHandle::execGetFirstMoveLocation(FFrame&, void* const)
native function Vector GetFirstMoveLocation();

// Export UNavigationHandle::execCalculatePathDistance(FFrame&, void* const)
native function float CalculatePathDistance(optional Vector FinalDest);

// Export UNavigationHandle::execCopyMovePointsFromPathCache(FFrame&, void* const)
native function CopyMovePointsFromPathCache(Vector FinalDest, out array<Vector> out_MovePoints);

// Export UNavigationHandle::execMoveToDesiredHeightAboveMesh(FFrame&, void* const)
native static function Vector MoveToDesiredHeightAboveMesh(Vector Point, float Height);

// Export UNavigationHandle::execPopulatePathfindingParamCache(FFrame&, void* const)
native final function bool PopulatePathfindingParamCache();

// Export UNavigationHandle::execGetAllCoverSlotsInRadius(FFrame&, void* const)
native static final function bool GetAllCoverSlotsInRadius(Vector FromLoc, float Radius, out array<CoverInfo> out_CoverList);

// Export UNavigationHandle::execGetValidatedAnchorPosition(FFrame&, void* const)
native final function bool GetValidatedAnchorPosition(out Vector out_NewAnchorLoc, optional Vector OverrideStartLoc);

// Export UNavigationHandle::execGetPackedKeyForPosition(FFrame&, void* const)
native function int GetPackedKeyForPosition(out Vector pos, const out Vector PrevPos, int PreviousKey);

// Export UNavigationHandle::execStaticGetValidatedAnchorPosition(FFrame&, void* const)
native static final function bool StaticGetValidatedAnchorPosition(out Vector out_NewAnchorLoc, Vector StartCheckBaseLocation, Vector Extent);

function DrawBreadCrumbs(optional bool bPersistent = false)
{
    //return;    
}

defaultproperties
{
    BreadCrumbDistanceInterval=75.0000000
}