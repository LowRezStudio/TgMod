class PComPerformanceCaptureGame extends GameInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision)
    dependson(PComPerformanceCaptureBase);

struct PComPerformanceCaptureStatCollection {
    var name ProfileName;
    var array<PComPerformanceCaptureStat> Stats;
    structdefaultproperties {}
};

var transient PComPerformanceCaptureBase BasePerformanceCapture;
var PComPerformanceCaptureBase.EPComPerformanceCaptureState CurrentCaptureState;
var transient array<PComPerformanceCaptureNode> NodesToCapture;
var transient array<PComPerformanceCaptureStatsPerNode> StatsPerNode;

event PostBeginPlay() { }

native function CollectNodes();  // Export UPComPerformanceCaptureGame::execCollectNodes(FFrame&, void* const)

native function DoNextAction();  // Export UPComPerformanceCaptureGame::execDoNextAction(FFrame&, void* const)

defaultproperties
{}
