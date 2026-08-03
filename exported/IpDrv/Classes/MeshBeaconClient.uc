class MeshBeaconClient extends MeshBeacon
    native
    config(Engine);

enum EMeshBeaconClientState
{
    MBCS_None,                      // 0
    MBCS_Connecting,                // 1
    MBCS_Connected,                 // 2
    MBCS_ConnectionFailed,          // 3
    MBCS_AwaitingResponse,          // 4
    MBCS_Closed,                    // 5
    MBCS_MAX                        // 6
};

struct native ClientConnectionRequest
{
    var UniqueNetId PlayerNetId;
    var OnlineSubsystem.ENATType NatType;
    var bool bCanHostVs;
    var float GoodHostRatio;
    var array<ConnectionBandwidthStats> BandwidthHistory;
    var int MinutesSinceLastTest;

    structdefaultproperties
    {
        PlayerNetId=(Uid=())
        NatType=ENATType.NAT_Unknown
        bCanHostVs=false
        GoodHostRatio=0.0000000
        BandwidthHistory=none
        MinutesSinceLastTest=0
    }
};

struct native ClientBandwidthTestData
{
    var MeshBeacon.EMeshBeaconBandwidthTestType TestType;
    var MeshBeacon.EMeshBeaconBandwidthTestState CurrentState;
    var int NumBytesToSendTotal;
    var int NumBytesSentTotal;
    var int NumBytesSentLast;
    var float ElapsedTestTime;

    structdefaultproperties
    {
        TestType=EMeshBeaconBandwidthTestType.MB_BandwidthTestType_Upstream
        CurrentState=EMeshBeaconBandwidthTestState.MB_BandwidthTestState_NotStarted
        NumBytesToSendTotal=0
        NumBytesSentTotal=0
        NumBytesSentLast=0
        ElapsedTestTime=0.0000000
    }
};

var const OnlineGameSearchResult HostPendingRequest;
var const ClientConnectionRequest ClientPendingRequest;
var ClientBandwidthTestData CurrentBandwidthTest;
var MeshBeaconClient.EMeshBeaconClientState ClientBeaconState;
var MeshBeacon.EMeshBeaconPacketType ClientBeaconRequestType;
var config float ConnectionRequestTimeout;
var float ConnectionRequestElapsedTime;
var config string ResolverClassName;
var Class<ClientBeaconAddressResolver> ResolverClass;
var ClientBeaconAddressResolver Resolver;
var transient bool bUsingRegisteredAddr;
//var delegate<OnConnectionRequestResult> __OnConnectionRequestResult__Delegate;
//var delegate<OnReceivedBandwidthTestRequest> __OnReceivedBandwidthTestRequest__Delegate;
//var delegate<OnReceivedBandwidthTestResults> __OnReceivedBandwidthTestResults__Delegate;
//var delegate<OnTravelRequestReceived> __OnTravelRequestReceived__Delegate;
//var delegate<OnCreateNewSessionRequestReceived> __OnCreateNewSessionRequestReceived__Delegate;

// Export UMeshBeaconClient::execDestroyBeacon(FFrame&, void* const)
native event DestroyBeacon();

// Export UMeshBeaconClient::execRequestConnection(FFrame&, void* const)
native function bool RequestConnection(const out OnlineGameSearchResult DesiredHost, const out ClientConnectionRequest ClientRequest, bool bRegisterSecureAddress);

// Export UMeshBeaconClient::execBeginBandwidthTest(FFrame&, void* const)
native function bool BeginBandwidthTest(MeshBeacon.EMeshBeaconBandwidthTestType TestType, int TestBufferSize);

delegate OnConnectionRequestResult(MeshBeacon.EMeshBeaconConnectionResult ConnectionResult)
{
    //return;    
}

delegate OnReceivedBandwidthTestRequest(MeshBeacon.EMeshBeaconBandwidthTestType TestType)
{
    //return;    
}

delegate OnReceivedBandwidthTestResults(MeshBeacon.EMeshBeaconBandwidthTestType TestType, MeshBeacon.EMeshBeaconBandwidthTestResult TestResult, const out ConnectionBandwidthStats BandwidthStats)
{
    //return;    
}

delegate OnTravelRequestReceived(name SessionName, Class<OnlineGameSearch> SearchClass, const out byte PlatformSpecificInfo[80])
{
    //return;    
}

delegate OnCreateNewSessionRequestReceived(name SessionName, Class<OnlineGameSearch> SearchClass, const out array<PlayerMember> Players)
{
    //return;    
}

// Export UMeshBeaconClient::execSendHostNewGameSessionResponse(FFrame&, void* const)
native function bool SendHostNewGameSessionResponse(bool bSuccess, name SessionName, Class<OnlineGameSearch> SearchClass, const out byte PlatformSpecificInfo[80]);
