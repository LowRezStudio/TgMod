class TgAISquad_Minion extends TgAISquad
    native(AI)
    config(Engine);

var float s_fNextClusterTime;
var float s_fNextMergeTime;

native function ClusterSquad();  // Export UTgAISquad_Minion::execClusterSquad(FFrame&, void* const)

native function CheckForMerge();  // Export UTgAISquad_Minion::execCheckForMerge(FFrame&, void* const)
