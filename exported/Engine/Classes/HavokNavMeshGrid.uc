class HavokNavMeshGrid extends Object
    native(Havok);

var Matrix WorldToScreen;
var Matrix ScreenToWorld;
var float TexelDistance;
var int GridSize;
var native const UntypedBulkData_Mirror SerializedGridData;
var transient array<bool> MemoryGridData;

// Export UHavokNavMeshGrid::execInitGrid(FFrame&, void* const)
native function InitGrid();

// Export UHavokNavMeshGrid::execTexelToWorld(FFrame&, void* const)
native function Vector TexelToWorld(const out Vector2D InPos);

// Export UHavokNavMeshGrid::execWorldToTexel(FFrame&, void* const)
native function Vector2D WorldToTexel(const out Vector InPos);

// Export UHavokNavMeshGrid::execWorldToTangent(FFrame&, void* const)
native function Vector2D WorldToTangent(const out Vector InPos);
