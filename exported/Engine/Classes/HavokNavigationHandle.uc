class HavokNavigationHandle extends NavigationHandle within Actor
    native(Havok);

enum EHavokNavigationMeshType
{
    HavokNavMesh_Pristine,          // 0
    HavokNavMesh_Obstacle,          // 1
    HavokNavMesh_Taskforce1,        // 2
    HavokNavMesh_Taskforce2,        // 3
    HavokNavMesh_MAX                // 4
};

enum EHavokEdgeType
{
    EDGETYPE_REGULAR,               // 0
    EDGETYPE_TRAVERSAL_DROPDOWN,    // 1
    EDGETYPE_TRAVERSAL_JUMP,        // 2
    EDGETYPE_MAX                    // 3
};

struct native CachedPathItem
{
    var int CachedKey;
    var Vector Location;
    var HavokNavigationHandle.EHavokEdgeType EdgeType;
    var bool bTerminatedPath;

    structdefaultproperties
    {
        CachedKey=0
        Location=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        EdgeType=EHavokEdgeType.EDGETYPE_REGULAR
        bTerminatedPath=false
    }
};

var init array<init CachedPathItem> PathPoints;
var transient HavokNavigationHandle.EHavokNavigationMeshType PathingNavMeshType;
var transient HavokNavigationHandle.EHavokEdgeType CurrEdgeType;
var transient float LastClearPathTime;
var transient float ClearPathTime;

// Export UHavokNavigationHandle::execGetNextMoveLocation(FFrame&, void* const)
native function bool GetNextMoveLocation(out Vector out_MoveDest, float ArrivalDistance);

// Export UHavokNavigationHandle::execFindPath(FFrame&, void* const)
native function bool FindPath(optional out Actor out_DestActor, optional out int out_DestItem);

// Export UHavokNavigationHandle::execSuggestMovePreparation(FFrame&, void* const)
native function bool SuggestMovePreparation(out Vector MovePt, Controller C);

// Export UHavokNavigationHandle::execPointReachable(FFrame&, void* const)
native function bool PointReachable(Vector Point, optional Vector OverrideStartPoint, optional bool bAllowHitsInEndCollisionBox = true);

// Export UHavokNavigationHandle::execActorReachable(FFrame&, void* const)
native function bool ActorReachable(Actor GoalActor);

// Export UHavokNavigationHandle::execLineCheck(FFrame&, void* const)
native function bool LineCheck(Vector Start, Vector Direction, Vector Extent, optional out Vector out_HitLocation, optional out Vector out_HitNormal);

// Export UHavokNavigationHandle::execGetPackedKeyForPosition(FFrame&, void* const)
native function int GetPackedKeyForPosition(out Vector pos, const out Vector PrevPos, int PreviousKey);

// Export UHavokNavigationHandle::execClearCurrentEdge(FFrame&, void* const)
native function ClearCurrentEdge();

// Export UHavokNavigationHandle::execGetCurrentEdgeType(FFrame&, void* const)
native function Pylon.ENavMeshEdgeType GetCurrentEdgeType();

// Export UHavokNavigationHandle::execCopyMovePointsFromPathCache(FFrame&, void* const)
native function CopyMovePointsFromPathCache(Vector FinalDest, out array<Vector> MovePoints);

// Export UHavokNavigationHandle::execPathCache_RemoveIndex(FFrame&, void* const)
native function bool PathCache_RemoveIndex(int Index, optional int Count = 1);

defaultproperties
{
    ClearPathTime=1.0000000
}