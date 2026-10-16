class WebServer extends TcpLink
    transient
    config(Web)
    hidecategories(Navigation,Movement,Collision);

var config string ServerName;
var config string Applications[10];
var config string ApplicationPaths[10];
var config bool bEnabled;
var config int ListenPort;
var config int MaxConnections;
var config int DefaultApplication;
var config int ExpirationSeconds;
var string ServerURL;
var WebApplication ApplicationObjects[10];
var int ConnectionCount;
var int ConnID;

function PostBeginPlay()
{
    local int I;
    local Class<WebApplication> ApplicationClass;
    local IpAddr L;
    local string S;

    // End:0x59
    if((int(WorldInfo.NetMode) == int(NM_Standalone)) || int(WorldInfo.NetMode) == int(NM_Client))
    {
        Destroy();
        return;
    }
    // End:0x6D
    if(!bEnabled)
    {
        Destroy();
        return;
    }
    super(Actor).PostBeginPlay();
    // End:0x124
    if(ServerName == "")
    {
        GetLocalIP(L);
        S = IpAddrToString(L);
        I = InStr(S, ":");
        // End:0x103
        if(I != -1)
        {
            S = Left(S, I);
        }
        ServerURL = "http://" $ S;        
    }
    else
    {
        ServerURL = "http://" $ ServerName;
    }
    // End:0x177
    if(ListenPort != 80)
    {
        ServerURL = (ServerURL $ ":") $ string(ListenPort);
    }
    // End:0x31E
    if((BindPort(ListenPort)) > 0)
    {
        // End:0x31B
        if((Listen()) == true)
        {
            I = 0;
            J0x1AC:

            // End:0x316 [Loop If]
            if(I < 10)
            {
                // End:0x1D9
                if(Applications[I] == "")
                {
                    // [Explicit Break]
                    goto J0x316;
                }
                ApplicationClass = Class<WebApplication>(DynamicLoadObject(Applications[I], Class'Core.Class'));
                // End:0x308
                if(ApplicationClass != none)
                {
                    ApplicationObjects[I] = new (none) ApplicationClass;
                    ApplicationObjects[I].WorldInfo = WorldInfo;
                    ApplicationObjects[I].WebServer = self;
                    ApplicationObjects[I].Path = ApplicationPaths[I];
                    ApplicationObjects[I].Init();                    
                }
                I++;
                // [Loop Continue]
                goto J0x1AC;
            }
            J0x316:

            return;            
        }        
    }
    Destroy();
    //return;    
}

event Destroyed()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x6B [Loop If]
    if(I < 10)
    {
        // End:0x5D
        if(ApplicationObjects[I] != none)
        {
            ApplicationObjects[I].CleanupApp();
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    super(Actor).Destroyed();
    //return;    
}

event GainedChild(Actor C)
{
    super(Actor).GainedChild(C);
    ConnectionCount++;
    // End:0x66
    if(((MaxConnections > 0) && ConnectionCount > MaxConnections) && int(LinkState) == int(2))
    {
        Close();
    }
    //return;    
}

event LostChild(Actor C)
{
    super(Actor).LostChild(C);
    ConnectionCount--;
    // End:0x55
    if((ConnectionCount <= MaxConnections) && int(LinkState) != int(2))
    {
        Listen();
    }
    //return;    
}

function WebApplication GetApplication(string URI, out string SubURI)
{
    local int I, L;

    SubURI = "";
    I = 0;
    J0x17:

    // End:0x107 [Loop If]
    if(I < 10)
    {
        // End:0xF9
        if(ApplicationPaths[I] != "")
        {
            L = Len(ApplicationPaths[I]);
            // End:0xF9
            if((Left(URI, L) ~= ApplicationPaths[I]) && (Len(URI) == L) || Mid(URI, L, 1) == "/")
            {
                SubURI = Mid(URI, L);
                return ApplicationObjects[I];
            }
        }
        I++;
        // [Loop Continue]
        goto J0x17;
    }
    return none;
    //return ReturnValue;    
}

defaultproperties
{
    AcceptClass=Class'IpDrv.WebConnection'
}