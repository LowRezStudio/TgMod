class HavokNavigationHandle extends NavigationHandle within Actor
    native(Havok)
    config(Engine)
    dependson(Pylon);

enum EHavokNavigationMeshType {
    HavokNavMesh_Pristine,  // 0
    HavokNavMesh_Obstacle,  // 1
    HavokNavMesh_Taskforce1,  // 2
    HavokNavMesh_Taskforce2,  // 3
};

enum EHavokEdgeType {
    EDGETYPE_REGULAR,  // 0
    EDGETYPE_TRAVERSAL_DROPDOWN,  // 1
    EDGETYPE_TRAVERSAL_JUMP,  // 2
};

struct CachedPathItem {
    var int CachedKey;
    var Vector Location;
    var HavokNavigationHandle.EHavokEdgeType EdgeType;
    var bool bTerminatedPath;
    structdefaultproperties {}
};

var init array<init CachedPathItem> PathPoints;
var transient HavokNavigationHandle.EHavokNavigationMeshType PathingNavMeshType;
var transient HavokNavigationHandle.EHavokEdgeType CurrEdgeType;
var transient float LastClearPathTime;
var transient float ClearPathTime;

native function bool GetNextMoveLocation(out Vector out_MoveDest, float ArrivalDistance);  // Export UHavokNavigationHandle::execGetNextMoveLocation(FFrame&, void* const)

native function bool FindPath(optional out Actor out_DestActor, optional out int out_DestItem);  // Export UHavokNavigationHandle::execFindPath(FFrame&, void* const)

native function bool SuggestMovePreparation(out Vector MovePt, Controller C);  // Export UHavokNavigationHandle::execSuggestMovePreparation(FFrame&, void* const)

native function bool PointReachable(Vector Point, optional Vector OverrideStartPoint, optional bool bAllowHitsInEndCollisionBox=true);  // Export UHavokNavigationHandle::execPointReachable(FFrame&, void* const)

native function bool ActorReachable(Actor GoalActor);  // Export UHavokNavigationHandle::execActorReachable(FFrame&, void* const)

native function bool LineCheck(Vector Start, Vector Direction, Vector Extent, optional out Vector out_HitLocation, optional out Vector out_HitNormal);  // Export UHavokNavigationHandle::execLineCheck(FFrame&, void* const)

native function int GetPackedKeyForPosition(out Vector pos, const out Vector PrevPos, int PreviousKey);  // Export UHavokNavigationHandle::execGetPackedKeyForPosition(FFrame&, void* const)

native function ClearCurrentEdge();  // Export UHavokNavigationHandle::execClearCurrentEdge(FFrame&, void* const)

native function Pylon.ENavMeshEdgeType GetCurrentEdgeType();  // Export UHavokNavigationHandle::execGetCurrentEdgeType(FFrame&, void* const)

native function CopyMovePointsFromPathCache(Vector FinalDest, out array<Vector> MovePoints);  // Export UHavokNavigationHandle::execCopyMovePointsFromPathCache(FFrame&, void* const)

native function bool PathCache_RemoveIndex(int Index, optional int Count=1);  // Export UHavokNavigationHandle::execPathCache_RemoveIndex(FFrame&, void* const)

defaultproperties
{
    ClearPathTime=1.0000000
}
