class MeshBeaconHost extends MeshBeacon
    native
    config(Engine);

struct native ClientConnectionBandwidthTestData
{
    var MeshBeacon.EMeshBeaconBandwidthTestState CurrentState;
    var MeshBeacon.EMeshBeaconBandwidthTestType TestType;
    var int BytesTotalNeeded;
    var int BytesReceived;
    var Double RequestTestStartTime;
    var Double TestStartTime;
    var ConnectionBandwidthStats BandwidthStats;

    structdefaultproperties
    {
        CurrentState=EMeshBeaconBandwidthTestState.MB_BandwidthTestState_NotStarted
        TestType=EMeshBeaconBandwidthTestType.MB_BandwidthTestType_Upstream
        BytesTotalNeeded=0
        BytesReceived=0
        RequestTestStartTime=()
        TestStartTime=()
        BandwidthStats=(UpstreamRate=0,DownstreamRate=0,RoundtripLatency=0)
    }
};

struct native ClientMeshBeaconConnection
{
    var UniqueNetId PlayerNetId;
    var float ElapsedHeartbeatTime;
    var native transient Pointer Socket;
    var bool bConnectionAccepted;
    var ClientConnectionBandwidthTestData BandwidthTest;
    var OnlineSubsystem.ENATType NatType;
    var bool bCanHostVs;
    var float GoodHostRatio;
    var array<ConnectionBandwidthStats> BandwidthHistory;
    var int MinutesSinceLastTest;

    structdefaultproperties
    {
        PlayerNetId=(Uid=())
        ElapsedHeartbeatTime=0.0000000
        bConnectionAccepted=false
        BandwidthTest=(CurrentState=EMeshBeaconBandwidthTestState.MB_BandwidthTestState_NotStarted,TestType=EMeshBeaconBandwidthTestType.MB_BandwidthTestType_Upstream,BytesTotalNeeded=0,BytesReceived=0,RequestTestStartTime=(),TestStartTime=(),BandwidthStats=(UpstreamRate=0,DownstreamRate=0,RoundtripLatency=0))
        NatType=ENATType.NAT_Unknown
        bCanHostVs=false
        GoodHostRatio=0.0000000
        BandwidthHistory=none
        MinutesSinceLastTest=0
    }
};

var const array<ClientMeshBeaconConnection> ClientConnections;
var private array<UniqueNetId> PendingPlayerConnections;
var const UniqueNetId OwningPlayerId;
var private bool bAllowBandwidthTesting;
var config int ConnectionBacklog;
//var delegate<OnReceivedClientConnectionRequest> __OnReceivedClientConnectionRequest__Delegate;
//var delegate<OnStartedBandwidthTest> __OnStartedBandwidthTest__Delegate;
//var delegate<OnFinishedBandwidthTest> __OnFinishedBandwidthTest__Delegate;
//var delegate<OnAllPendingPlayersConnected> __OnAllPendingPlayersConnected__Delegate;
//var delegate<OnReceivedClientCreateNewSessionResult> __OnReceivedClientCreateNewSessionResult__Delegate;

// Export UMeshBeaconHost::execInitHostBeacon(FFrame&, void* const)
native function bool InitHostBeacon(UniqueNetId InOwningPlayerId);

// Export UMeshBeaconHost::execDestroyBeacon(FFrame&, void* const)
native event DestroyBeacon();

// Export UMeshBeaconHost::execRequestClientBandwidthTest(FFrame&, void* const)
native function bool RequestClientBandwidthTest(UniqueNetId PlayerNetId, MeshBeacon.EMeshBeaconBandwidthTestType TestType, int TestBufferSize);

// Export UMeshBeaconHost::execHasInProgressBandwidthTest(FFrame&, void* const)
native function bool HasInProgressBandwidthTest();

// Export UMeshBeaconHost::execCancelInProgressBandwidthTests(FFrame&, void* const)
native function CancelInProgressBandwidthTests();

// Export UMeshBeaconHost::execHasPendingBandwidthTest(FFrame&, void* const)
native function bool HasPendingBandwidthTest();

// Export UMeshBeaconHost::execCancelPendingBandwidthTests(FFrame&, void* const)
native function CancelPendingBandwidthTests();

function AllowBandwidthTesting(bool bEnabled)
{
    bAllowBandwidthTesting = bEnabled;
    //return;    
}

delegate OnReceivedClientConnectionRequest(const out ClientMeshBeaconConnection NewClientConnection)
{
    //return;    
}

delegate OnStartedBandwidthTest(UniqueNetId PlayerNetId, MeshBeacon.EMeshBeaconBandwidthTestType TestType)
{
    //return;    
}

delegate OnFinishedBandwidthTest(UniqueNetId PlayerNetId, MeshBeacon.EMeshBeaconBandwidthTestType TestType, MeshBeacon.EMeshBeaconBandwidthTestResult TestResult, const out ConnectionBandwidthStats BandwidthStats)
{
    //return;    
}

function SetPendingPlayerConnections(const out array<UniqueNetId> Players)
{
    PendingPlayerConnections = Players;
    //return;    
}

// Export UMeshBeaconHost::execGetConnectionIndexForPlayer(FFrame&, void* const)
native function int GetConnectionIndexForPlayer(UniqueNetId PlayerNetId);

// Export UMeshBeaconHost::execAllPlayersConnected(FFrame&, void* const)
native function bool AllPlayersConnected(const out array<UniqueNetId> Players);

delegate OnAllPendingPlayersConnected()
{
    //return;    
}

// Export UMeshBeaconHost::execTellClientsToTravel(FFrame&, void* const)
native function TellClientsToTravel(name SessionName, Class<OnlineGameSearch> SearchClass, const out byte PlatformSpecificInfo[80]);

// Export UMeshBeaconHost::execRequestClientCreateNewSession(FFrame&, void* const)
native function bool RequestClientCreateNewSession(UniqueNetId PlayerNetId, name SessionName, Class<OnlineGameSearch> SearchClass, const out array<PlayerMember> Players);

delegate OnReceivedClientCreateNewSessionResult(bool bSucceeded, name SessionName, Class<OnlineGameSearch> SearchClass, const out byte PlatformSpecificInfo[80])
{
    //return;    
}

defaultproperties
{
    bAllowBandwidthTesting=true
}