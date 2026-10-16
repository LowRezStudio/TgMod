class McpUserManagerBase extends McpServiceBase
    abstract
    config(Engine);

struct McpUserStatus
{
    var string McpId;
    var string UDID;
    var string CountryCode;
    var string LastActiveDate;
    var int DaysInactive;
    var bool bIsBanned;

    structdefaultproperties
    {
        McpId=""
        UDID=""
        CountryCode=""
        LastActiveDate=""
        DaysInactive=0
        bIsBanned=false
    }
};

var config string McpUserManagerClassName;
//var delegate<OnRegisterUserComplete> __OnRegisterUserComplete__Delegate;
//var delegate<OnQueryUsersComplete> __OnQueryUsersComplete__Delegate;
//var delegate<OnDeleteUserComplete> __OnDeleteUserComplete__Delegate;

static final function McpUserManagerBase CreateInstance()
{
    local Class<McpUserManagerBase> McpUserManagerBaseClass;
    local McpUserManagerBase NewInstance;

    McpUserManagerBaseClass = Class<McpUserManagerBase>(DynamicLoadObject(default.McpUserManagerClassName, Class'Core.Class'));
    // End:0x76
    if(McpUserManagerBaseClass != none)
    {
        NewInstance = new McpUserManagerBaseClass;
        NewInstance.Init();
    }
    return NewInstance;
    //return ReturnValue;    
}

function RegisterUserGenerated(string UDID, optional string ExistingMcpAuth)
{
    //return;    
}

function RegisterUserEmail(string Email, string PasswordHash, string UDID, optional string ExistingMcpAuth)
{
    //return;    
}

function RegisterUserFacebook(string FacebookId, string FacebookAuthToken, string UDID, optional string ExistingMcpAuth)
{
    //return;    
}

delegate OnRegisterUserComplete(string McpId, string UDID, bool bWasSuccessful, string Error)
{
    //return;    
}

function QueryUser(string McpId, optional bool bShouldUpdateLastActive)
{
    //return;    
}

function QueryUsers(const out array<string> McpIds)
{
    //return;    
}

delegate OnQueryUsersComplete(bool bWasSuccessful, string Error)
{
    //return;    
}

function GetUsers(out array<McpUserStatus> Users)
{
    //return;    
}

function bool GetUser(string McpId, out McpUserStatus User)
{
    //return ReturnValue;    
}

function DeleteUser(string McpId)
{
    //return;    
}

delegate OnDeleteUserComplete(bool bWasSuccessful, string Error)
{
    //return;    
}

defaultproperties
{
    McpUserManagerClassName="IpDrv.McpUserManager"
}