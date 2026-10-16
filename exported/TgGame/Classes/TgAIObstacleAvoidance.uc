class TgAIObstacleAvoidance extends Object within Actor
    native(AI);

enum EObstacleAvoidanceStatus
{
    OAS_NoPath,                     // 0
    OAS_Pathing,                    // 1
    OAS_PathFinished,               // 2
    OAS_MAX                         // 3
};

struct native ObstacleQueryCache
{
    var Vector RealGoalPos;
    var Vector ModifiedGoalPos;
    var init array<init Vector> IntermediatePoints;
    var TgAIObstacleAvoidance.EObstacleAvoidanceStatus PathStatus;

    structdefaultproperties
    {
        RealGoalPos=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        ModifiedGoalPos=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        IntermediatePoints=none
        PathStatus=EObstacleAvoidanceStatus.OAS_NoPath
    }
};

var native transient Pointer ObstacleGrid;
var transient ObstacleQueryCache CachedAvoidance;
var init transient array<init BlockingVolume> CachedBlockers;
var init transient array<init Landscape> CachedLandscapes;
var transient TgAIController_Behavior OuterController;
var bool bRenderingIsDirty;

// Export UTgAIObstacleAvoidance::execFindPath(FFrame&, void* const)
native function bool FindPath(out array<Actor> ActorsToAvoid, const out Vector TargetPoint, out Vector UpdatedTargetPoint);

// Export UTgAIObstacleAvoidance::execGetNextMoveLocation(FFrame&, void* const)
native function TgAIObstacleAvoidance.EObstacleAvoidanceStatus GetNextMoveLocation(const out Vector TargetPoint, out Vector IntermediatePoint, const out float ArrivalDistance);

// Export UTgAIObstacleAvoidance::execInit(FFrame&, void* const)
native function Init(const float GridPointSize, const float GridExtents);

// Export UTgAIObstacleAvoidance::execReset(FFrame&, void* const)
native function Reset();

// Export UTgAIObstacleAvoidance::execTestObstacleAvoidance(FFrame&, void* const)
native function TestObstacleAvoidance(int TestType);

defaultproperties
{
    bRenderingIsDirty=true
}