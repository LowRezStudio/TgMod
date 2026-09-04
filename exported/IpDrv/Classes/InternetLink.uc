class InternetLink extends Info
    transient
    native
    hidecategories(Navigation,Movement,Collision);

enum ELinkMode
{
    MODE_Text,                      // 0
    MODE_Line,                      // 1
    MODE_Binary,                    // 2
    MODE_MAX                        // 3
};

enum ELineMode
{
    LMODE_auto,                     // 0
    LMODE_DOS,                      // 1
    LMODE_UNIX,                     // 2
    LMODE_MAC,                      // 3
    LMODE_MAX                       // 4
};

enum EReceiveMode
{
    RMODE_Manual,                   // 0
    RMODE_Event,                    // 1
    RMODE_MAX                       // 2
};

var InternetLink.ELinkMode LinkMode;
var InternetLink.ELineMode InLineMode;
var InternetLink.ELineMode OutLineMode;
var InternetLink.EReceiveMode ReceiveMode;
var const Pointer Socket;
var const int Port;
var const Pointer RemoteSocket;
var private native const Pointer PrivateResolveInfo;
var const int DataPending;

// Export UInternetLink::execIsDataPending(FFrame&, void* const)
native function bool IsDataPending();

// Export UInternetLink::execParseURL(FFrame&, void* const)
native function bool ParseURL(coerce string URL, out string Addr, out int PortNum, out string LevelName, out string EntryName);

// Export UInternetLink::execResolve(FFrame&, void* const)
native function Resolve(coerce string Domain);

// Export UInternetLink::execGetLastError(FFrame&, void* const)
native function int GetLastError();

// Export UInternetLink::execIpAddrToString(FFrame&, void* const)
native function string IpAddrToString(IpAddr Arg);

// Export UInternetLink::execStringToIpAddr(FFrame&, void* const)
native function bool StringToIpAddr(string Str, out IpAddr Addr);

// Export UInternetLink::execGetLocalIP(FFrame&, void* const)
native function GetLocalIP(out IpAddr Arg);

event Resolved(IpAddr Addr)
{
    //return;    
}

event ResolveFailed()
{
    //return;    
}

defaultproperties
{
    ReceiveMode=EReceiveMode.RMODE_Event
}