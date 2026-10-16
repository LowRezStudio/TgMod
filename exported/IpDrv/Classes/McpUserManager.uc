class McpUserManager extends McpUserManagerBase
    config(Engine);

struct RegisterUserRequest
{
    var string UDID;
    var string McpId;
    var HttpRequestInterface Request;

    structdefaultproperties
    {
        UDID=""
        McpId=""
        Request=none
    }
};

var array<McpUserStatus> UserStatuses;
var config string RegisterUserMcpUrl;
var config string RegisterUserEmailUrl;
var config string RegisterUserFacebookUrl;
var config string QueryUserUrl;
var config string QueryUsersUrl;
var config string DeleteUserUrl;
var array<RegisterUserRequest> RegisterUserRequests;
var array<HttpRequestInterface> QueryUsersRequests;
var array<HttpRequestInterface> DeleteUserRequests;

function RegisterUserGenerated(string UDID, optional string ExistingMcpAuth)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x1A5
    if(Request != none)
    {
        URL = ((((GetBaseURL()) $ RegisterUserMcpUrl) $ (GetAppAccessURL())) $ "&udid=") $ UDID;
        Request.SetURL(URL);
        Request.SetVerb("POST");
        Request.__OnProcessRequestComplete__Delegate = OnRegisterUserRequestComplete;
        AddAt = RegisterUserRequests.Length;
        RegisterUserRequests.Length = AddAt + 1;
        RegisterUserRequests[AddAt].UDID = UDID;
        RegisterUserRequests[AddAt].Request = Request;
        // End:0x1A5
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnRegisterUserRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, AddAt, ResponseCode, UserIndex;
    local string McpId;
    local bool bWasFound;

    Index = RegisterUserRequests.Find('Request', Request);
    // End:0x2F2
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x83
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x255
        if(bWasSuccessful)
        {
            McpId = Response.GetContentAsString();
            RegisterUserRequests[Index].McpId = McpId;
            // End:0x255
            if(McpId != "")
            {
                UserIndex = 0;
                J0x12B:

                // End:0x19E [Loop If]
                if((UserIndex < UserStatuses.Length) && !bWasFound)
                {
                    bWasFound = McpId == UserStatuses[UserIndex].McpId;
                    UserIndex++;
                    // [Loop Continue]
                    goto J0x12B;
                }
                // End:0x255
                if(!bWasFound)
                {
                    AddAt = UserStatuses.Length;
                    UserStatuses.Length = AddAt + 1;
                    UserStatuses[AddAt].McpId = McpId;
                    UserStatuses[AddAt].UDID = RegisterUserRequests[Index].UDID;
                }
            }
        }
        OnRegisterUserComplete(RegisterUserRequests[Index].McpId, RegisterUserRequests[Index].UDID, bWasSuccessful, Response.GetContentAsString());
        RegisterUserRequests.Remove(Index, 1);
    }
    //return;    
}

function RegisterUserEmail(string Email, string PasswordHash, string UDID, optional string ExistingMcpAuth)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x217
    if(Request != none)
    {
        URL = ((((((((GetBaseURL()) $ RegisterUserEmailUrl) $ (GetAppAccessURL())) $ "&email=") $ Email) $ "&passwordhash=") $ PasswordHash) $ "&udid=") $ UDID;
        // End:0xEB
        if(Len(ExistingMcpAuth) > 0)
        {            
            URL $= ("&authticket=" $ ExistingMcpAuth);
        }
        Request.SetURL(URL);
        Request.SetVerb("POST");
        Request.__OnProcessRequestComplete__Delegate = OnRegisterUserEmailRequestComplete;
        AddAt = RegisterUserRequests.Length;
        RegisterUserRequests.Length = AddAt + 1;
        RegisterUserRequests[AddAt].UDID = UDID;
        RegisterUserRequests[AddAt].Request = Request;
        // End:0x217
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnRegisterUserEmailRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    OnRegisterUserRequestComplete(Request, Response, bWasSuccessful);
    //return;    
}

function RegisterUserFacebook(string FacebookId, string FacebookAuthToken, string UDID, optional string ExistingMcpAuth)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x21D
    if(Request != none)
    {
        URL = ((((((((GetBaseURL()) $ RegisterUserEmailUrl) $ (GetAppAccessURL())) $ "&facebookid=") $ FacebookId) $ "&facebooktoken=") $ FacebookAuthToken) $ "&udid=") $ UDID;
        // End:0xF1
        if(Len(ExistingMcpAuth) > 0)
        {            
            URL $= ("&authticket=" $ ExistingMcpAuth);
        }
        Request.SetURL(URL);
        Request.SetVerb("POST");
        Request.__OnProcessRequestComplete__Delegate = OnRegisterUserFacebookRequestComplete;
        AddAt = RegisterUserRequests.Length;
        RegisterUserRequests.Length = AddAt + 1;
        RegisterUserRequests[AddAt].UDID = UDID;
        RegisterUserRequests[AddAt].Request = Request;
        // End:0x21D
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnRegisterUserFacebookRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    OnRegisterUserRequestComplete(Request, Response, bWasSuccessful);
    //return;    
}

function QueryUser(string McpId, optional bool bShouldUpdateLastActive)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x19F
    if((Request != none) && McpId != "")
    {
        URL = ((((((GetBaseURL()) $ QueryUserUrl) $ (GetAppAccessURL())) $ "&uniqueUserId=") $ McpId) $ "&updateLastActive=") $ string(bShouldUpdateLastActive);
        Request.SetURL(URL);
        Request.SetVerb("GET");
        Request.__OnProcessRequestComplete__Delegate = OnQueryUserRequestComplete;
        AddAt = QueryUsersRequests.Length;
        QueryUsersRequests.Length = AddAt + 1;
        QueryUsersRequests[AddAt] = Request;
        // End:0x19F
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnQueryUserRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, AddAt, ResponseCode;
    local string JsonString;
    local JsonObject ParsedJson;
    local int UserIndex;
    local string McpId, UDID, CountryCode, LastActiveDate;
    local bool bIsBanned, bWasFound;
    local int DaysInactive;

    Index = QueryUsersRequests.Find(Request);
    // End:0x49A
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x7A
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x449
        if(bWasSuccessful)
        {
            JsonString = Response.GetContentAsString();
            // End:0x449
            if(JsonString != "")
            {
                ParsedJson = Class'Engine.JsonObject'.static.DecodeJson(JsonString);
                McpId = ParsedJson.GetStringValue("unique_user_id");
                UDID = ParsedJson.GetStringValue("udid");
                CountryCode = ParsedJson.GetStringValue("country_code");
                bIsBanned = ParsedJson.GetBoolValue("is_banned");
                LastActiveDate = ParsedJson.GetStringValue("last_active_date");
                DaysInactive = ParsedJson.GetIntValue("days_inactive");
                bWasFound = false;
                UserIndex = 0;
                J0x277:

                // End:0x2EA [Loop If]
                if((UserIndex < UserStatuses.Length) && !bWasFound)
                {
                    bWasFound = McpId == UserStatuses[UserIndex].McpId;
                    UserIndex++;
                    // [Loop Continue]
                    goto J0x277;
                }
                // End:0x449
                if(!bWasFound)
                {
                    AddAt = UserStatuses.Length;
                    UserStatuses.Length = AddAt + 1;
                    UserStatuses[AddAt].McpId = McpId;
                    UserStatuses[AddAt].UDID = UDID;
                    UserStatuses[AddAt].CountryCode = CountryCode;
                    UserStatuses[AddAt].bIsBanned = bIsBanned;
                    UserStatuses[AddAt].LastActiveDate = LastActiveDate;
                    UserStatuses[AddAt].DaysInactive = DaysInactive;                    
                }
            }
        }
        OnQueryUsersComplete(bWasSuccessful, Response.GetContentAsString());
        QueryUsersRequests.Remove(Index, 1);
    }
    //return;    
}

function QueryUsers(const out array<string> McpIds)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;
    local string JsonPayload;
    local int Index;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x273
    if(Request != none)
    {
        URL = ((GetBaseURL()) $ QueryUsersUrl) $ (GetAppAccessURL());
        JsonPayload = "[ ";
        Index = 0;
        J0x7C:

        // End:0x107 [Loop If]
        if(Index < McpIds.Length)
        {            
            JsonPayload $= (("\"" $ McpIds[Index]) $ "\"");
            // End:0xF9
            if((Index + 1) < McpIds.Length)
            {                
                JsonPayload $= ",";
            }
            Index++;
            // [Loop Continue]
            goto J0x7C;
        }        
        JsonPayload $= " ]";
        Request.SetURL(URL);
        Request.SetContentAsString(JsonPayload);
        Request.SetVerb("POST");
        Request.SetHeader("Content-Type", "multipart/form-data");
        Request.__OnProcessRequestComplete__Delegate = OnQueryUsersRequestComplete;
        AddAt = QueryUsersRequests.Length;
        QueryUsersRequests.Length = AddAt + 1;
        QueryUsersRequests[AddAt] = Request;
        // End:0x273
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnQueryUsersRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, AddAt, ResponseCode;
    local string JsonString;
    local JsonObject ParsedJson;
    local int UserIndex, JsonIndex;
    local string McpId, UDID, CountryCode, LastActiveDate;
    local bool bIsBanned, bWasFound;
    local int DaysInactive;

    Index = QueryUsersRequests.Find(Request);
    // End:0x597
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x7A
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        // End:0x546
        if(bWasSuccessful)
        {
            JsonString = Response.GetContentAsString();
            // End:0x546
            if(JsonString != "")
            {
                ParsedJson = Class'Engine.JsonObject'.static.DecodeJson(JsonString);
                JsonIndex = 0;
                J0x124:

                // End:0x546 [Loop If]
                if(JsonIndex < ParsedJson.ObjectArray.Length)
                {
                    McpId = ParsedJson.ObjectArray[JsonIndex].GetStringValue("unique_user_id");
                    UDID = ParsedJson.ObjectArray[JsonIndex].GetStringValue("udid");
                    CountryCode = ParsedJson.ObjectArray[JsonIndex].GetStringValue("country_code");
                    bIsBanned = ParsedJson.ObjectArray[JsonIndex].GetBoolValue("is_banned");
                    LastActiveDate = ParsedJson.ObjectArray[JsonIndex].GetStringValue("last_active_date");
                    DaysInactive = ParsedJson.ObjectArray[JsonIndex].GetIntValue("days_inactive");
                    bWasFound = false;
                    UserIndex = 0;
                    J0x369:

                    // End:0x3DC [Loop If]
                    if((UserIndex < UserStatuses.Length) && !bWasFound)
                    {
                        bWasFound = McpId == UserStatuses[UserIndex].McpId;
                        UserIndex++;
                        // [Loop Continue]
                        goto J0x369;
                    }
                    // End:0x538
                    if(!bWasFound)
                    {
                        AddAt = UserStatuses.Length;
                        UserStatuses.Length = AddAt + 1;
                        UserStatuses[AddAt].McpId = McpId;
                        UserStatuses[AddAt].UDID = UDID;
                        UserStatuses[AddAt].CountryCode = CountryCode;
                        UserStatuses[AddAt].bIsBanned = bIsBanned;
                        UserStatuses[AddAt].LastActiveDate = LastActiveDate;
                        UserStatuses[AddAt].DaysInactive = DaysInactive;
                    }
                    JsonIndex++;
                    // [Loop Continue]
                    goto J0x124;
                }
            }
        }
        OnQueryUsersComplete(bWasSuccessful, Response.GetContentAsString());
        QueryUsersRequests.Remove(Index, 1);
    }
    //return;    
}

function GetUsers(out array<McpUserStatus> Users)
{
    Users = UserStatuses;
    //return;    
}

function DeleteUser(string McpId)
{
    local string URL;
    local HttpRequestInterface Request;
    local int AddAt;

    Request = Class'Engine.HttpFactory'.static.CreateRequest();
    // End:0x16B
    if(Request != none)
    {
        URL = ((((GetBaseURL()) $ DeleteUserUrl) $ (GetAppAccessURL())) $ "&uniqueUserId=") $ McpId;
        Request.SetURL(URL);
        Request.SetVerb("DELETE");
        Request.__OnProcessRequestComplete__Delegate = OnDeleteUserRequestComplete;
        AddAt = DeleteUserRequests.Length;
        DeleteUserRequests.Length = AddAt + 1;
        DeleteUserRequests[AddAt] = Request;
        // End:0x16B
        if(!Request.ProcessRequest())
        {
        }
    }
    //return;    
}

function OnDeleteUserRequestComplete(HttpRequestInterface Request, HttpResponseInterface Response, bool bWasSuccessful)
{
    local int Index, ResponseCode;

    Index = DeleteUserRequests.Find(Request);
    // End:0xF2
    if(Index != -1)
    {
        ResponseCode = 500;
        // End:0x7A
        if(Response != none)
        {
            ResponseCode = Response.GetResponseCode();
        }
        bWasSuccessful = bWasSuccessful && ResponseCode == 200;
        OnDeleteUserComplete(bWasSuccessful, Response.GetContentAsString());
        DeleteUserRequests.Remove(Index, 1);
    }
    //return;    
}

defaultproperties
{
    RegisterUserMcpUrl="/registerusermcp"
    RegisterUserFacebookUrl="/registeruserfacebook"
    QueryUserUrl="/userstatus"
    QueryUsersUrl="/usermultiplestatus"
    DeleteUserUrl="/deleteuser"
}