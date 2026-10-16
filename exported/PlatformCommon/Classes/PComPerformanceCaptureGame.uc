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
        Stats=none
    }
};

var transient PComPerformanceCaptureBase BasePerformanceCapture;
var PComPerformanceCaptureBase.EPComPerformanceCaptureState CurrentCaptureState;
var transient array<PComPerformanceCaptureNode> NodesToCapture;
var transient array<PComPerformanceCaptureStatsPerNode> StatsPerNode;

event PostBeginPlay()
{
    super.PostBeginPlay();
    BasePerformanceCapture.InitializePerformanceCaptureSettings();
    CollectNodes();
    //return;    
}

// Export UPComPerformanceCaptureGame::execCollectNodes(FFrame&, void* const)
native final function CollectNodes();

// Export UPComPerformanceCaptureGame::execDoNextAction(FFrame&, void* const)
native final function DoNextAction();

defaultproperties
{
    // Reference: PComPerformanceCaptureBase'PlatformCommon.Default__PComPerformanceCaptureGame.MyPerformanceBase'
    begin object name="MyPerformanceBase" class=PlatformCommon.PComPerformanceCaptureBase
    end object
    BasePerformanceCapture=MyPerformanceBase
}