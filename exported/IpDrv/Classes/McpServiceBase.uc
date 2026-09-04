class McpServiceBase extends Object
    native
    config(Engine);

var config string McpConfigClassName;
var McpServiceConfig McpConfig;

event Init()
{
    local Class<McpServiceConfig> McpConfigClass;

    McpConfigClass = Class<McpServiceConfig>(DynamicLoadObject(default.McpConfigClassName, Class'Core.Class'));
    // End:0x57
    if(McpConfigClass != none)
    {
        McpConfig = new McpConfigClass;
    }
    //return;    
}

function string GetBaseURL()
{
    return (McpConfig.Protocol $ "://") $ McpConfig.Domain;
    //return ReturnValue;    
}

function string GetAppAccessURL()
{
    return (((("?appKey=" $ McpConfig.AppKey) $ "&appSecret=") $ McpConfig.AppSecret) $ "&titleId=") $ McpConfig.TitleId;
    //return ReturnValue;    
}

function string GetUserAuthURL(string McpId)
{
    local string AuthTicket;

    AuthTicket = McpConfig.GetUserAuthTicket(McpId);
    // End:0x5D
    if(Len(AuthTicket) > 0)
    {
        return "&authTicket=" $ AuthTicket;
    }
    return "";
    //return ReturnValue;    
}

defaultproperties
{
    McpConfigClassName="IpDrv.McpServiceConfig"
}