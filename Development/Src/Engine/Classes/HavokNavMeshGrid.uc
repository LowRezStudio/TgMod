class HavokNavMeshGrid extends Object
    native(Havok)
    config(Engine);

var Matrix WorldToScreen;
var Matrix ScreenToWorld;
var float TexelDistance;
var int GridSize;
var native const UntypedBulkData_Mirror SerializedGridData;
var transient array<bool> MemoryGridData;

native function InitGrid();  // Export UHavokNavMeshGrid::execInitGrid(FFrame&, void* const)

native function Vector TexelToWorld(const out Vector2D InPos);  // Export UHavokNavMeshGrid::execTexelToWorld(FFrame&, void* const)

native function Vector2D WorldToTexel(const out Vector InPos);  // Export UHavokNavMeshGrid::execWorldToTexel(FFrame&, void* const)

native function Vector2D WorldToTangent(const out Vector InPos);  // Export UHavokNavMeshGrid::execWorldToTangent(FFrame&, void* const)
