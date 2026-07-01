class PComPerformanceCaptureGame extends GameInfo
    native
    config(Game)
    hidecategories(Navigation,Movement,Collision);

struct native PComPerformanceCaptureStatCollection
{
    var name ProfileName;
    var array<PComPerformanceCaptureStat> Stats;

    structdefaultproperties
    {
        ProfileName="None"
        Stats=()
    }
};

var transient PComPerformanceCaptureBase BasePerformanceCapture;
var PComPerformanceCaptureBase.EPComPerformanceCaptureState CurrentCaptureState;
var transient array<PComPerformanceCaptureNode> NodesToCapture;
var transient array<PComPerformanceCaptureStatsPerNode> StatsPerNode;

event PostBeginPlay()
{
    //return;    
}

// Export UPComPerformanceCaptureGame::execCollectNodes(FFrame&, void* const)
native final function CollectNodes();

// Export UPComPerformanceCaptureGame::execDoNextAction(FFrame&, void* const)
native final function DoNextAction();

defaultproperties
{
    BasePerformanceCapture=none//PComPerformanceCaptureBase'Default__PComPerformanceCaptureGame.MyPerformanceBase'
}