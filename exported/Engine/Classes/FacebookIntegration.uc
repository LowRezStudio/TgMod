class FacebookIntegration extends PlatformInterfaceBase
    transient
    native(PlatformInterface)
    config(Engine);

enum EFacebookIntegrationDelegate
{
    FID_AuthorizationComplete,      // 0
    FID_FacebookRequestComplete,    // 1
    FID_DialogComplete,             // 2
    FID_FriendsListComplete,        // 3
    FID_MAX                         // 4
};

struct native FacebookFriend
{
    var string Name;
    var string Id;

    structdefaultproperties
    {
        Name=""
        Id=""
    }
};

var config string AppID;
var config array<config string> Permissions;
var string UserName;
var string UserId;
var string AccessToken;
var array<FacebookFriend> FriendsList;

// Export UFacebookIntegration::execInit(FFrame&, void* const)
native event bool Init();

// Export UFacebookIntegration::execAuthorize(FFrame&, void* const)
native event bool Authorize();

// Export UFacebookIntegration::execIsAuthorized(FFrame&, void* const)
native event bool IsAuthorized();

// Export UFacebookIntegration::execFacebookRequest(FFrame&, void* const)
native event FacebookRequest(string GraphRequest);

// Export UFacebookIntegration::execFacebookDialog(FFrame&, void* const)
native event FacebookDialog(string Action, array<string> ParamKeysAndValues);

// Export UFacebookIntegration::execDisconnect(FFrame&, void* const)
native event Disconnect();
