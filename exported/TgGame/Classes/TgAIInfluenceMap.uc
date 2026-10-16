class TgAIInfluenceMap extends Object within Actor
    native(AI);

var private native const noexport Pointer VfTable_FTickableObject;
var transient array<int> Influences;
var native transient Pointer FalloffTable;
var native const transient HavokNavMeshGrid InfluenceGrid;
var float TickFrequency;
var transient float InvTickFrequency;
var float Decay;
var float Momentum;

// Export UTgAIInfluenceMap::execInit(FFrame&, void* const)
native function Init();

// Export UTgAIInfluenceMap::execRegisterInfluence(FFrame&, void* const)
native function RegisterInfluence(const Vector StartPosition, const int PackedInfluence, const optional bool Additive = false, const optional float Radius = 0.0000000);

defaultproperties
{
    TickFrequency=5.0000000
    Decay=0.3000000
    Momentum=0.2500000
}