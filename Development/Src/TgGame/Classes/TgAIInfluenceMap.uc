class TgAIInfluenceMap extends Object within Actor
    native(AI)
    config(Engine);

var transient array<int> Influences;
var native transient Pointer FalloffTable;
var native const transient HavokNavMeshGrid InfluenceGrid;
var float TickFrequency;
var transient float InvTickFrequency;
var float Decay;
var float Momentum;

native function Init();  // Export UTgAIInfluenceMap::execInit(FFrame&, void* const)

native function RegisterInfluence(const Vector StartPosition, const int PackedInfluence, const optional bool Additive=false, const optional float Radius=0.0000000);  // Export UTgAIInfluenceMap::execRegisterInfluence(FFrame&, void* const)

defaultproperties
{
    TickFrequency=5.0000000
    Decay=0.3000000
    Momentum=0.2500000
}
