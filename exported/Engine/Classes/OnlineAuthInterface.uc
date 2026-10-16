interface OnlineAuthInterface extends Interface
    abstract
    native;

enum EAuthStatus
{
    AUS_NotStarted,                 // 0
    AUS_Pending,                    // 1
    AUS_Authenticated,              // 2
    AUS_Failed,                     // 3
    AUS_MAX                         // 4
};

struct native BaseAuthSession
{
    var const IpAddr EndPointIP;
    var const int EndPointPort;
    var const UniqueNetId EndPointUID;

    structdefaultproperties
    {
        EndPointIP=(AddrA=0,AddrB=0,AddrC=0,AddrD=0,Port=0)
        EndPointPort=0
        EndPointUID=(Uid=())
    }
};

struct native LocalAuthSession extends BaseAuthSession
{
    var const int SessionUID;
};

struct native AuthSession extends BaseAuthSession
{
    var const OnlineAuthInterface.EAuthStatus AuthStatus;
    var const int AuthTicketUID;
};

function bool IsReady()
{
    //return ReturnValue;    
}

delegate OnAuthReady()
{
    //return;    
}

function AddAuthReadyDelegate(delegate<OnAuthReady> AuthReadyDelegate)
{
    //return;    
}

function ClearAuthReadyDelegate(delegate<OnAuthReady> AuthReadyDelegate)
{
    //return;    
}

delegate OnClientAuthRequest(UniqueNetId ServerUID, IpAddr ServerIP, int ServerPort, bool bSecure)
{
    //return;    
}

function AddClientAuthRequestDelegate(delegate<OnClientAuthRequest> ClientAuthRequestDelegate)
{
    //return;    
}

function ClearClientAuthRequestDelegate(delegate<OnClientAuthRequest> ClientAuthRequestDelegate)
{
    //return;    
}

delegate OnServerAuthRequest(Player ClientConnection, UniqueNetId ClientUID, IpAddr ClientIP, int ClientPort)
{
    //return;    
}

function AddServerAuthRequestDelegate(delegate<OnServerAuthRequest> ServerAuthRequestDelegate)
{
    //return;    
}

function ClearServerAuthRequestDelegate(delegate<OnServerAuthRequest> ServerAuthRequestDelegate)
{
    //return;    
}

delegate OnClientAuthResponse(UniqueNetId ClientUID, IpAddr ClientIP, int AuthTicketUID)
{
    //return;    
}

function AddClientAuthResponseDelegate(delegate<OnClientAuthResponse> ClientAuthResponseDelegate)
{
    //return;    
}

function ClearClientAuthResponseDelegate(delegate<OnClientAuthResponse> ClientAuthResponseDelegate)
{
    //return;    
}

delegate OnServerAuthResponse(UniqueNetId ServerUID, IpAddr ServerIP, int AuthTicketUID)
{
    //return;    
}

function AddServerAuthResponseDelegate(delegate<OnServerAuthResponse> ServerAuthResponseDelegate)
{
    //return;    
}

function ClearServerAuthResponseDelegate(delegate<OnServerAuthResponse> ServerAuthResponseDelegate)
{
    //return;    
}

delegate OnClientAuthComplete(bool bSuccess, UniqueNetId ClientUID, Player ClientConnection, string ExtraInfo)
{
    //return;    
}

function AddClientAuthCompleteDelegate(delegate<OnClientAuthComplete> ClientAuthCompleteDelegate)
{
    //return;    
}

function ClearClientAuthCompleteDelegate(delegate<OnClientAuthComplete> ClientAuthCompleteDelegate)
{
    //return;    
}

delegate OnServerAuthComplete(bool bSuccess, UniqueNetId ServerUID, Player ServerConnection, string ExtraInfo)
{
    //return;    
}

function AddServerAuthCompleteDelegate(delegate<OnServerAuthComplete> ServerAuthCompleteDelegate)
{
    //return;    
}

function ClearServerAuthCompleteDelegate(delegate<OnServerAuthComplete> ServerAuthCompleteDelegate)
{
    //return;    
}

delegate OnClientAuthEndSessionRequest(Player ServerConnection)
{
    //return;    
}

function AddClientAuthEndSessionRequestDelegate(delegate<OnClientAuthEndSessionRequest> ClientAuthEndSessionRequestDelegate)
{
    //return;    
}

function ClearClientAuthEndSessionRequestDelegate(delegate<OnClientAuthEndSessionRequest> ClientAuthEndSessionRequestDelegate)
{
    //return;    
}

delegate OnServerAuthRetryRequest(Player ClientConnection)
{
    //return;    
}

function AddServerAuthRetryRequestDelegate(delegate<OnServerAuthRetryRequest> ServerAuthRetryRequestDelegate)
{
    //return;    
}

function ClearServerAuthRetryRequestDelegate(delegate<OnServerAuthRetryRequest> ServerAuthRetryRequestDelegate)
{
    //return;    
}

delegate OnClientConnectionClose(Player ClientConnection)
{
    //return;    
}

function AddClientConnectionCloseDelegate(delegate<OnClientConnectionClose> ClientConnectionCloseDelegate)
{
    //return;    
}

function ClearClientConnectionCloseDelegate(delegate<OnClientConnectionClose> ClientConnectionCloseDelegate)
{
    //return;    
}

delegate OnServerConnectionClose(Player ServerConnection)
{
    //return;    
}

function AddServerConnectionCloseDelegate(delegate<OnServerConnectionClose> ServerConnectionCloseDelegate)
{
    //return;    
}

function ClearServerConnectionCloseDelegate(delegate<OnServerConnectionClose> ServerConnectionCloseDelegate)
{
    //return;    
}

function bool SendClientAuthRequest(Player ClientConnection, UniqueNetId ClientUID)
{
    //return ReturnValue;    
}

function bool SendServerAuthRequest(UniqueNetId ServerUID)
{
    //return ReturnValue;    
}

function bool SendClientAuthResponse(int AuthTicketUID)
{
    //return ReturnValue;    
}

function bool SendServerAuthResponse(Player ClientConnection, int AuthTicketUID)
{
    //return ReturnValue;    
}

function bool SendClientAuthEndSessionRequest(Player ClientConnection)
{
    //return ReturnValue;    
}

function bool SendServerAuthRetryRequest()
{
    //return ReturnValue;    
}

function bool CreateClientAuthSession(UniqueNetId ServerUID, IpAddr ServerIP, int ServerPort, bool bSecure, out int OutAuthTicketUID)
{
    //return ReturnValue;    
}

function bool VerifyClientAuthSession(UniqueNetId ClientUID, IpAddr ClientIP, int ClientPort, int AuthTicketUID)
{
    //return ReturnValue;    
}

function EndLocalClientAuthSession(UniqueNetId ServerUID, IpAddr ServerIP, int ServerPort)
{
    //return;    
}

function EndRemoteClientAuthSession(UniqueNetId ClientUID, IpAddr ClientIP)
{
    //return;    
}

function EndAllLocalClientAuthSessions()
{
    //return;    
}

function EndAllRemoteClientAuthSessions()
{
    //return;    
}

function bool CreateServerAuthSession(UniqueNetId ClientUID, IpAddr ClientIP, int ClientPort, out int OutAuthTicketUID)
{
    //return ReturnValue;    
}

function bool VerifyServerAuthSession(UniqueNetId ServerUID, IpAddr ServerIP, int AuthTicketUID)
{
    //return ReturnValue;    
}

function EndLocalServerAuthSession(UniqueNetId ClientUID, IpAddr ClientIP)
{
    //return;    
}

function EndRemoteServerAuthSession(UniqueNetId ServerUID, IpAddr ServerIP)
{
    //return;    
}

function EndAllLocalServerAuthSessions()
{
    //return;    
}

function EndAllRemoteServerAuthSessions()
{
    //return;    
}

// Export UOnlineAuthInterface::execAllClientAuthSessions(FFrame&, void* const)
native iterator function AllClientAuthSessions(out AuthSession OutSessionInfo);

// Export UOnlineAuthInterface::execAllLocalClientAuthSessions(FFrame&, void* const)
native iterator function AllLocalClientAuthSessions(out LocalAuthSession OutSessionInfo);

// Export UOnlineAuthInterface::execAllServerAuthSessions(FFrame&, void* const)
native iterator function AllServerAuthSessions(out AuthSession OutSessionInfo);

// Export UOnlineAuthInterface::execAllLocalServerAuthSessions(FFrame&, void* const)
native iterator function AllLocalServerAuthSessions(out LocalAuthSession OutSessionInfo);

function bool FindClientAuthSession(Player ClientConnection, out AuthSession OutSessionInfo)
{
    //return ReturnValue;    
}

function bool FindLocalClientAuthSession(Player ServerConnection, out LocalAuthSession OutSessionInfo)
{
    //return ReturnValue;    
}

function bool FindServerAuthSession(Player ServerConnection, out AuthSession OutSessionInfo)
{
    //return ReturnValue;    
}

function bool FindLocalServerAuthSession(Player ClientConnection, out LocalAuthSession OutSessionInfo)
{
    //return ReturnValue;    
}

function bool GetServerUniqueId(out UniqueNetId OutServerUID)
{
    //return ReturnValue;    
}

function bool GetServerAddr(out IpAddr OutServerIP, out int OutServerPort)
{
    //return ReturnValue;    
}
