class PartyBeaconClient extends PartyBeacon
    native
    config(Engine);

enum EPartyBeaconClientState
{
    PBCS_None,                      // 0
    PBCS_Connecting,                // 1
    PBCS_Connected,                 // 2
    PBCS_ConnectionFailed,          // 3
    PBCS_AwaitingResponse,          // 4
    PBCS_Closed,                    // 5
    PBCS_MAX                        // 6
};

enum EPartyBeaconClientRequest
{
    PBClientRequest_NewReservation, // 0
    PBClientRequest_UpdateReservation,// 1
    PBClientRequest_MAX             // 2
};

var const OnlineGameSearchResult HostPendingRequest;
var PartyReservation PendingRequest;
var PartyBeaconClient.EPartyBeaconClientState ClientBeaconState;
var PartyBeaconClient.EPartyBeaconClientRequest ClientBeaconRequestType;
var config float ReservationRequestTimeout;
var float ReservationRequestElapsedTime;
var config string ResolverClassName;
var Class<ClientBeaconAddressResolver> ResolverClass;
var ClientBeaconAddressResolver Resolver;
//var delegate<OnReservationRequestComplete> __OnReservationRequestComplete__Delegate;
//var delegate<OnReservationCountUpdated> __OnReservationCountUpdated__Delegate;
//var delegate<OnTravelRequestReceived> __OnTravelRequestReceived__Delegate;
//var delegate<OnHostIsReady> __OnHostIsReady__Delegate;
//var delegate<OnHostHasCancelled> __OnHostHasCancelled__Delegate;

delegate OnReservationRequestComplete(PartyBeacon.EPartyReservationResult ReservationResult)
{
    //return;    
}

delegate OnReservationCountUpdated(int ReservationRemaining)
{
    //return;    
}

delegate OnTravelRequestReceived(name SessionName, Class<OnlineGameSearch> SearchClass, byte PlatformSpecificInfo[80])
{
    //return;    
}

delegate OnHostIsReady()
{
    //return;    
}

delegate OnHostHasCancelled()
{
    //return;    
}

// Export UPartyBeaconClient::execRequestReservation(FFrame&, void* const)
native function bool RequestReservation(const out OnlineGameSearchResult DesiredHost, UniqueNetId RequestingPartyLeader, const out array<PlayerReservation> Players);

// Export UPartyBeaconClient::execRequestReservationUpdate(FFrame&, void* const)
native function bool RequestReservationUpdate(const out OnlineGameSearchResult DesiredHost, UniqueNetId RequestingPartyLeader, const out array<PlayerReservation> PlayersToAdd);

// Export UPartyBeaconClient::execCancelReservation(FFrame&, void* const)
native function bool CancelReservation(UniqueNetId CancellingPartyLeader);

// Export UPartyBeaconClient::execDestroyBeacon(FFrame&, void* const)
native event DestroyBeacon();
