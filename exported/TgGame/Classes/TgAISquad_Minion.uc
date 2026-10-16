class TgAISquad_Minion extends TgAISquad
    native(AI);

var float s_fNextClusterTime;
var float s_fNextMergeTime;

// Export UTgAISquad_Minion::execClusterSquad(FFrame&, void* const)
native function ClusterSquad();

// Export UTgAISquad_Minion::execCheckForMerge(FFrame&, void* const)
native function CheckForMerge();
