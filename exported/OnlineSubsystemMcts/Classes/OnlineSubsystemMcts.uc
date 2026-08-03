class OnlineSubsystemMcts extends OnlineSubsystemCommonImpl
    native
    config(Engine)
    implements(OnlinePlayerInterface,OnlineSystemInterface,OnlineChatInterface);

struct native ControllerConnectionState
{
    var const int bIsControllerConnected;
    var const int bLastIsControllerConnected;

    structdefaultproperties
    {
        bIsControllerConnected=0
        bLastIsControllerConnected=0
    }
};

var const OnlineGameInterfaceMcts MctsGameInt;
var const OnlineVoiceInterfaceMcts MctsVoiceInt;
var const localized string LocalProfileName;
var const string LoggedInPlayerName;
var const string LoggedInPlayerClanTag;
var const UniqueNetId LoggedInPlayerId;
var const int LoggedInPlayerNum;
var const OnlineSubsystem.ELoginStatus LoggedInStatus;
var const byte bWasKeyboardInputCanceled;
var config OnlineSubsystem.ENetworkNotificationPosition CurrentNotificationPosition;
var config string ProfileDataDirectory;
var config string ProfileDataExtension;
var const UniqueNetId LocalTeamChatId;
var const UniqueNetId InstanceChatId;
var array< delegate<OnConnectionStatusChange> > ConnectionStatusChangeDelegates;
var array< delegate<OnLoginChange> > LoginChangeDelegates;
var array< delegate<OnLoginFailed> > LoginFailedDelegates;
var array< delegate<OnLogoutCompleted> > LogoutCompletedDelegates;
var array< delegate<OnLinkStatusChange> > LinkStatusDelegates;
var array< delegate<OnChatMessage> > ChatMessageDelegates;
var const string KeyboardResultsString;
var const bool bNeedsKeyboardTicking;
var bool bLastHasConnection;
var const config bool bShouldUseMcp;
var array< delegate<OnKeyboardInputComplete> > KeyboardInputDelegates;
var ControllerConnectionState ControllerStates[4];
var float ConnectionPresenceTimeInterval;
var float ConnectionPresenceElapsedTime;
//var delegate<OnLoginChange> __OnLoginChange__Delegate;
//var delegate<OnLoginFailed> __OnLoginFailed__Delegate;
//var delegate<OnLogoutCompleted> __OnLogoutCompleted__Delegate;
//var delegate<OnLinkStatusChange> __OnLinkStatusChange__Delegate;
//var delegate<OnExternalUIChange> __OnExternalUIChange__Delegate;
//var delegate<OnControllerChange> __OnControllerChange__Delegate;
//var delegate<OnConnectionStatusChange> __OnConnectionStatusChange__Delegate;
//var delegate<OnStorageDeviceChange> __OnStorageDeviceChange__Delegate;
//var delegate<OnChatMessage> __OnChatMessage__Delegate;
//var delegate<OnLoginStatusChange> __OnLoginStatusChange__Delegate;
//var delegate<OnLoginCancelled> __OnLoginCancelled__Delegate;
//var delegate<OnMutingChange> __OnMutingChange__Delegate;
//var delegate<OnReadProfileSettingsComplete> __OnReadProfileSettingsComplete__Delegate;
//var delegate<OnWriteProfileSettingsComplete> __OnWriteProfileSettingsComplete__Delegate;
//var delegate<OnReadPlayerStorageComplete> __OnReadPlayerStorageComplete__Delegate;
//var delegate<OnReadPlayerStorageForNetIdComplete> __OnReadPlayerStorageForNetIdComplete__Delegate;
//var delegate<OnWritePlayerStorageComplete> __OnWritePlayerStorageComplete__Delegate;
//var delegate<OnFriendsChange> __OnFriendsChange__Delegate;
//var delegate<OnReadFriendsComplete> __OnReadFriendsComplete__Delegate;
//var delegate<OnKeyboardInputComplete> __OnKeyboardInputComplete__Delegate;
//var delegate<OnAddFriendByNameComplete> __OnAddFriendByNameComplete__Delegate;
//var delegate<OnFriendInviteReceived> __OnFriendInviteReceived__Delegate;
//var delegate<OnReceivedGameInvite> __OnReceivedGameInvite__Delegate;
//var delegate<OnJoinFriendGameComplete> __OnJoinFriendGameComplete__Delegate;
//var delegate<OnFriendMessageReceived> __OnFriendMessageReceived__Delegate;
//var delegate<OnUnlockAchievementComplete> __OnUnlockAchievementComplete__Delegate;
//var delegate<OnReadAchievementsComplete> __OnReadAchievementsComplete__Delegate;
//var delegate<OnAccountPickerComplete> __OnAccountPickerComplete__Delegate;
//var delegate<OnCurrentUserChanged> __OnCurrentUserChanged__Delegate;
//var delegate<OnPrivilegeLevelChecked> __OnPrivilegeLevelChecked__Delegate;
//var delegate<OnPrivilegeCheckedForUsers> __OnPrivilegeCheckedForUsers__Delegate;
//var delegate<OnSystemUserControllerPairingChanged> __OnSystemUserControllerPairingChanged__Delegate;
//var delegate<OnTokenAndSignatureRetrieved> __OnTokenAndSignatureRetrieved__Delegate;
//var delegate<OnUserAccountInfoRetrieved> __OnUserAccountInfoRetrieved__Delegate;

// Export UOnlineSubsystemMcts::execInit(FFrame&, void* const)
native event bool Init();

delegate OnLoginChange(byte LocalUserNum)
{
    //return;    
}

// Export UOnlineSubsystemMcts::execLogin(FFrame&, void* const)
native function bool Login(byte LocalUserNum, string LoginName, string Password, optional bool bWantsLocalOnly);

// Export UOnlineSubsystemMcts::execRequestNewPlayer(FFrame&, void* const)
native function bool RequestNewPlayer(byte LocalUserNum, string LoginName, string Password, string DesiredPlayerName);

// Export UOnlineSubsystemMcts::execAutoLogin(FFrame&, void* const)
native function bool AutoLogin();

delegate OnLoginFailed(byte LocalUserNum, OnlineSubsystem.EOnlineServerConnectionStatus ErrorCode)
{
    //return;    
}

function AddLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginFailedDelegate)
{
    // End:0x3E
    if(LoginFailedDelegates.Find(LoginFailedDelegate) == -1)
    {
        LoginFailedDelegates[LoginFailedDelegates.Length] = LoginFailedDelegate;
    }
    //return;    
}

function ClearLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginFailedDelegate)
{
    local int RemoveIndex;

    RemoveIndex = LoginFailedDelegates.Find(LoginFailedDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        LoginFailedDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineSubsystemMcts::execLogout(FFrame&, void* const)
native function bool Logout(byte LocalUserNum);

delegate OnLogoutCompleted(bool bWasSuccessful)
{
    //return;    
}

function AddLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate)
{
    // End:0x3E
    if(LogoutCompletedDelegates.Find(LogoutDelegate) == -1)
    {
        LogoutCompletedDelegates[LogoutCompletedDelegates.Length] = LogoutDelegate;
    }
    //return;    
}

function ClearLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate)
{
    local int RemoveIndex;

    RemoveIndex = LogoutCompletedDelegates.Find(LogoutDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        LogoutCompletedDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineSubsystemMcts::execGetLoginStatus(FFrame&, void* const)
native function OnlineSubsystem.ELoginStatus GetLoginStatus(byte LocalUserNum);

function bool IsGuestLogin(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool IsLocalLogin(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool GetUniquePlayerId(byte LocalUserNum, out UniqueNetId PlayerID)
{
    PlayerID = LoggedInPlayerId;
    return true;
    //return ReturnValue;    
}

function bool GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId)
{
    //return ReturnValue;    
}

function CacheLoggedInGamepad()
{
    //return;    
}

function string GetPlayerNickname(byte LocalUserNum)
{
    return GetPlayerMctsName();
    //return ReturnValue;    
}

// Export UOnlineSubsystemMcts::execCanPlayOnline(FFrame&, void* const)
native function bool CanPlayOnline(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "");

function OnlineSubsystem.EFeaturePrivilegeLevel CanDownloadUserContent(byte LocalUserNum)
{
    local OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint;

    CanPlayOnline(LocalUserNum, PrivilegeLevelHint);
    return PrivilegeLevelHint;
    //return ReturnValue;    
}

function bool CanPurchaseContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    return true;
    //return ReturnValue;    
}

function bool CanViewPlayerProfiles(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    return true;
    //return ReturnValue;    
}

function bool CanShowPresenceInformation(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    return true;
    //return ReturnValue;    
}

// Export UOnlineSubsystemMcts::execIsFriend(FFrame&, void* const)
native function bool IsFriend(byte LocalUserNum, UniqueNetId PlayerID);

// Export UOnlineSubsystemMcts::execAreAnyFriends(FFrame&, void* const)
native function bool AreAnyFriends(byte LocalUserNum, out array<FriendsQuery> Query);

// Export UOnlineSubsystemMcts::execGetPlayerMctsName(FFrame&, void* const)
native function string GetPlayerMctsName();

function AddLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate)
{
    // End:0x3E
    if(LoginChangeDelegates.Find(LoginDelegate) == -1)
    {
        LoginChangeDelegates[LoginChangeDelegates.Length] = LoginDelegate;
    }
    //return;    
}

function ClearLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate)
{
    local int RemoveIndex;

    RemoveIndex = LoginChangeDelegates.Find(LoginDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        LoginChangeDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineSubsystemMcts::execNeedEULA(FFrame&, void* const)
native function bool NeedEULA();

event string GetPlayerNicknameFromIndex(int UserIndex)
{
    // End:0x1A
    if(UserIndex == 0)
    {
        return GetPlayerMctsName();
    }
    return "";
    //return ReturnValue;    
}

event UniqueNetId GetPlayerUniqueNetIdFromIndex(int UserIndex)
{
    local UniqueNetId Zero;

    // End:0x19
    if(UserIndex == 0)
    {
        return LoggedInPlayerId;
    }
    return Zero;
    //return ReturnValue;    
}

// Export UOnlineSubsystemMcts::execHasLinkConnection(FFrame&, void* const)
native function bool HasLinkConnection();

delegate OnLinkStatusChange(bool bIsConnected)
{
    //return;    
}

function AddLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
    // End:0x3E
    if(LinkStatusDelegates.Find(LinkStatusDelegate) == -1)
    {
        LinkStatusDelegates[LinkStatusDelegates.Length] = LinkStatusDelegate;
    }
    //return;    
}

function ClearLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate)
{
    local int RemoveIndex;

    RemoveIndex = LinkStatusDelegates.Find(LinkStatusDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        LinkStatusDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

delegate OnExternalUIChange(bool bIsOpening)
{
    //return;    
}

function AddExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate)
{
    //return;    
}

function ClearExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate)
{
    //return;    
}

function OnlineSubsystem.ENetworkNotificationPosition GetNetworkNotificationPosition()
{
    return CurrentNotificationPosition;
    //return ReturnValue;    
}

delegate OnControllerChange(int ControllerId, bool bIsConnected, bool bPauseGame)
{
    //return;    
}

function AddControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
    //return;    
}

function ClearControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate)
{
    //return;    
}

// Export UOnlineSubsystemMcts::execIsControllerConnected(FFrame&, void* const)
native function bool IsControllerConnected(int ControllerId);

delegate OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus)
{
    //return;    
}

function AddConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
    // End:0x3E
    if(ConnectionStatusChangeDelegates.Find(ConnectionStatusDelegate) == -1)
    {
        ConnectionStatusChangeDelegates[ConnectionStatusChangeDelegates.Length] = ConnectionStatusDelegate;
    }
    //return;    
}

function ClearConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate)
{
    local int RemoveIndex;

    RemoveIndex = ConnectionStatusChangeDelegates.Find(ConnectionStatusDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        ConnectionStatusChangeDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineSubsystemMcts::execGetNATType(FFrame&, void* const)
native function OnlineSubsystem.ENATType GetNATType();

delegate OnStorageDeviceChange()
{
    //return;    
}

function AddStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate)
{
    //return;    
}

function ClearStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate)
{
    //return;    
}

delegate OnChatMessage(int Channel, string Sender, string Message)
{
    //return;    
}

function AddChatMessageDelegate(delegate<OnChatMessage> ChatDelegate)
{
    // End:0x3E
    if(ChatMessageDelegates.Find(ChatDelegate) == -1)
    {
        ChatMessageDelegates[ChatMessageDelegates.Length] = ChatDelegate;
    }
    //return;    
}

function ClearChatMessageDelegate(delegate<OnChatMessage> ChatDelegate)
{
    local int RemoveIndex;

    RemoveIndex = ChatMessageDelegates.Find(ChatDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        ChatMessageDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineSubsystemMcts::execSendChatMessage(FFrame&, void* const)
native function SendChatMessage(int Channel, string Message);

// Export UOnlineSubsystemMcts::execSendPrivateChatMessage(FFrame&, void* const)
native function SendPrivateChatMessage(string PlayerName, string Message);

// Export UOnlineSubsystemMcts::execNotifyTeamChange(FFrame&, void* const)
native function NotifyTeamChange(QWord PlayerUID, byte TeamID);

function bool IsMuted(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

// Export UOnlineSubsystemMcts::execCanCommunicate(FFrame&, void* const)
native function OnlineSubsystem.EFeaturePrivilegeLevel CanCommunicate(byte LocalUserNum);

delegate OnLoginStatusChange(OnlineSubsystem.ELoginStatus NewStatus, UniqueNetId NewId)
{
    //return;    
}

function AddLoginStatusChangeDelegate(delegate<OnLoginStatusChange> LoginStatusDelegate, byte LocalUserNum)
{
    //return;    
}

function ClearLoginStatusChangeDelegate(delegate<OnLoginStatusChange> LoginStatusDelegate, byte LocalUserNum)
{
    //return;    
}

delegate OnLoginCancelled()
{
    //return;    
}

function AddLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate)
{
    //return;    
}

function ClearLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate)
{
    //return;    
}

function bool ReadProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings)
{
    //return ReturnValue;    
}

function bool WriteProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings)
{
    //return ReturnValue;    
}

function OnlineProfileSettings GetProfileSettings(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnMutingChange()
{
    //return;    
}

function AddMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate)
{
    //return;    
}

function ClearMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate)
{
    //return;    
}

delegate OnReadProfileSettingsComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddReadProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
    //return;    
}

function ClearReadProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate)
{
    //return;    
}

delegate OnWriteProfileSettingsComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddWriteProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate)
{
    //return;    
}

function ClearWriteProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate)
{
    //return;    
}

function bool ReadPlayerStorage(byte LocalUserNum, OnlinePlayerStorage PlayerStorage, optional int DeviceID = -1)
{
    //return ReturnValue;    
}

delegate OnReadPlayerStorageComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddReadPlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnReadPlayerStorageComplete> ReadPlayerStorageCompleteDelegate)
{
    //return;    
}

function ClearReadPlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnReadPlayerStorageComplete> ReadPlayerStorageCompleteDelegate)
{
    //return;    
}

function bool ReadPlayerStorageForNetId(byte LocalUserNum, UniqueNetId NetId, OnlinePlayerStorage PlayerStorage)
{
    //return ReturnValue;    
}

delegate OnReadPlayerStorageForNetIdComplete(UniqueNetId NetId, bool bWasSuccessful)
{
    //return;    
}

function AddReadPlayerStorageForNetIdCompleteDelegate(UniqueNetId NetId, delegate<OnReadPlayerStorageForNetIdComplete> ReadPlayerStorageForNetIdCompleteDelegate)
{
    //return;    
}

function ClearReadPlayerStorageForNetIdCompleteDelegate(UniqueNetId NetId, delegate<OnReadPlayerStorageForNetIdComplete> ReadPlayerStorageForNetIdCompleteDelegate)
{
    //return;    
}

function OnlinePlayerStorage GetPlayerStorage(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool WritePlayerStorage(byte LocalUserNum, OnlinePlayerStorage PlayerStorage, optional int DeviceID = -1)
{
    //return ReturnValue;    
}

delegate OnWritePlayerStorageComplete(byte LocalUserNum, bool bWasSuccessful)
{
    //return;    
}

function AddWritePlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnWritePlayerStorageComplete> WritePlayerStorageCompleteDelegate)
{
    //return;    
}

function ClearWritePlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnWritePlayerStorageComplete> WritePlayerStorageCompleteDelegate)
{
    //return;    
}

delegate OnFriendsChange()
{
    //return;    
}

function AddFriendsChangeDelegate(byte LocalUserNum, delegate<OnFriendsChange> FriendsDelegate)
{
    //return;    
}

function ClearFriendsChangeDelegate(byte LocalUserNum, delegate<OnFriendsChange> FriendsDelegate)
{
    //return;    
}

function bool ReadFriendsList(byte LocalUserNum, optional int Count, optional int StartingAt)
{
    //return ReturnValue;    
}

delegate OnReadFriendsComplete(bool bWasSuccessful)
{
    //return;    
}

function AddReadFriendsCompleteDelegate(byte LocalUserNum, delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate)
{
    //return;    
}

function ClearReadFriendsCompleteDelegate(byte LocalUserNum, delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate)
{
    //return;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetFriendsList(byte LocalUserNum, out array<OnlineFriend> Friends, optional int Count, optional int StartingAt)
{
    //return ReturnValue;    
}

function SetOnlineStatus(byte LocalUserNum, string StatusString, optional bool PlayerActive = true)
{
    //return;    
}

function bool ShowKeyboardUI(byte LocalUserNum, string TitleText, string DescriptionText, optional bool bIsPassword = false, optional bool bShouldValidate = true, optional string DefaultText, optional int MaxResultLength = 256)
{
    //return ReturnValue;    
}

delegate OnKeyboardInputComplete(bool bWasSuccessful)
{
    //return;    
}

function AddKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate)
{
    //return;    
}

function ClearKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate)
{
    //return;    
}

function string GetKeyboardInputResults(out byte bWasCanceled)
{
    //return ReturnValue;    
}

function bool AddFriend(byte LocalUserNum, UniqueNetId NewFriend, optional string Message)
{
    //return ReturnValue;    
}

function bool AddFriendByName(byte LocalUserNum, string FriendName, optional string Message)
{
    //return ReturnValue;    
}

delegate OnAddFriendByNameComplete(bool bWasSuccessful)
{
    //return;    
}

function AddAddFriendByNameCompleteDelegate(byte LocalUserNum, delegate<OnAddFriendByNameComplete> FriendDelegate)
{
    //return;    
}

function ClearAddFriendByNameCompleteDelegate(byte LocalUserNum, delegate<OnAddFriendByNameComplete> FriendDelegate)
{
    //return;    
}

function bool AcceptFriendInvite(byte LocalUserNum, UniqueNetId RequestingPlayer)
{
    //return ReturnValue;    
}

function bool DenyFriendInvite(byte LocalUserNum, UniqueNetId RequestingPlayer)
{
    //return ReturnValue;    
}

function bool RemoveFriend(byte LocalUserNum, UniqueNetId FormerFriend)
{
    //return ReturnValue;    
}

delegate OnFriendInviteReceived(byte LocalUserNum, UniqueNetId RequestingPlayer, string RequestingNick, string Message)
{
    //return;    
}

function AddFriendInviteReceivedDelegate(byte LocalUserNum, delegate<OnFriendInviteReceived> InviteDelegate)
{
    //return;    
}

function ClearFriendInviteReceivedDelegate(byte LocalUserNum, delegate<OnFriendInviteReceived> InviteDelegate)
{
    //return;    
}

function bool SendMessageToFriend(byte LocalUserNum, UniqueNetId Friend, string Message)
{
    //return ReturnValue;    
}

function bool SendGameInviteToFriend(byte LocalUserNum, name SessionName, UniqueNetId Friend, optional string Text)
{
    //return ReturnValue;    
}

function bool SendGameInviteToFriends(byte LocalUserNum, name SessionName, array<UniqueNetId> Friends, optional string Text)
{
    //return ReturnValue;    
}

delegate OnReceivedGameInvite(byte LocalUserNum, string InviterName)
{
    //return;    
}

function AddReceivedGameInviteDelegate(byte LocalUserNum, delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate)
{
    //return;    
}

function ClearReceivedGameInviteDelegate(byte LocalUserNum, delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate)
{
    //return;    
}

function CheckForGameInviteOnLaunch()
{
    //return;    
}

function bool JoinFriendGame(byte LocalUserNum, UniqueNetId Friend)
{
    //return ReturnValue;    
}

delegate OnJoinFriendGameComplete(bool bWasSuccessful)
{
    //return;    
}

function AddJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate)
{
    //return;    
}

function ClearJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate)
{
    //return;    
}

function GetFriendMessages(byte LocalUserNum, out array<OnlineFriendMessage> FriendMessages)
{
    //return;    
}

delegate OnFriendMessageReceived(byte LocalUserNum, UniqueNetId SendingPlayer, string SendingNick, string Message)
{
    //return;    
}

function AddFriendMessageReceivedDelegate(byte LocalUserNum, delegate<OnFriendMessageReceived> MessageDelegate)
{
    //return;    
}

function ClearFriendMessageReceivedDelegate(byte LocalUserNum, delegate<OnFriendMessageReceived> MessageDelegate)
{
    //return;    
}

function bool UnlockAchievement(byte LocalUserNum, int AchievementId, optional float PercentComplete = 100.0000000)
{
    //return ReturnValue;    
}

function bool ReadAchievements(byte LocalUserNum, optional int TitleId = 0, optional bool bShouldReadText = true, optional bool bShouldReadImages = false)
{
    //return ReturnValue;    
}

function OnlineSubsystem.EOnlineEnumerationReadState GetAchievements(byte LocalUserNum, out array<AchievementDetails> Achievements, optional int TitleId = 0)
{
    //return ReturnValue;    
}

delegate OnUnlockAchievementComplete(bool bWasSuccessful)
{
    //return;    
}

function AddUnlockAchievementCompleteDelegate(byte LocalUserNum, delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate)
{
    //return;    
}

function ClearUnlockAchievementCompleteDelegate(byte LocalUserNum, delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate)
{
    //return;    
}

delegate OnReadAchievementsComplete(int TitleId)
{
    //return;    
}

function AddReadAchievementsCompleteDelegate(byte LocalUserNum, delegate<OnReadAchievementsComplete> ReadAchievementsCompleteDelegate)
{
    //return;    
}

function ClearReadAchievementsCompleteDelegate(byte LocalUserNum, delegate<OnReadAchievementsComplete> ReadAchievementsCompleteDelegate)
{
    //return;    
}

function bool DeleteMessage(byte LocalUserNum, int MessageIndex)
{
    //return ReturnValue;    
}

function bool ShowFriendsUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnAccountPickerComplete(bool bForceLogin)
{
    //return;    
}

function AddAccountPickerCompleteDelegate(delegate<OnAccountPickerComplete> InDelegate)
{
    //return;    
}

function RemoveAccountPickerCompleteDelegate(delegate<OnAccountPickerComplete> InDelegate)
{
    //return;    
}

function bool ShowLoginUI(byte LocalUserNum, optional bool bForceLogin, optional bool bShowOnlineOnly = false)
{
    //return ReturnValue;    
}

function SetNetworkNotificationPosition(OnlineSubsystem.ENetworkNotificationPosition NewPos)
{
    //return;    
}

function int GetLocale()
{
    //return ReturnValue;    
}

function ClearAchievements(byte LocalUserNum, optional int TitleId = 0)
{
    //return;    
}

function bool HideKeyboardUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser)
{
    //return;    
}

function AddCurrentUserChangedDelegate(delegate<OnCurrentUserChanged> CurrentUserDelegate)
{
    //return;    
}

function ClearCurrentUserChangedDelegate(delegate<OnCurrentUserChanged> CurrentUserDelegate)
{
    //return;    
}

delegate OnPrivilegeLevelChecked(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
{
    //return;    
}

function AddPrivilegeLevelCheckedDelegate(delegate<OnPrivilegeLevelChecked> PrivilegeDelegate)
{
    //return;    
}

function ClearPrivilegeLevelCheckedDelegate(delegate<OnPrivilegeLevelChecked> PrivilegeDelegate)
{
    //return;    
}

delegate OnPrivilegeCheckedForUsers(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResult> Results)
{
    //return;    
}

function AddPrivilegeCheckedForUsersDelegate(delegate<OnPrivilegeCheckedForUsers> PrivilegeDelegate)
{
    //return;    
}

function ClearPrivilegeCheckedForUsersDelegate(delegate<OnPrivilegeCheckedForUsers> PrivilegeDelegate)
{
    //return;    
}

function bool CanCommunicateText(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanCommunicateVideo(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanCommunicateVoice(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanCommunicateVoiceWithUsers(byte LocalUserNum, array<SessionMemberInfo> Users)
{
    //return ReturnValue;    
}

function bool CanShareUserCreatedContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanRecordDVRClips(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanUseCloudStorage(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanAccessPremiumContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanAccessPremiumVideoContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanBrowseInternet(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanShareWithSocialNetwork(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanShareKinectContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanUploadFitnessData(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

delegate OnSystemUserControllerPairingChanged(int NewLocalUserNum, int PreviousLocalUserNum)
{
    //return;    
}

function AddSystemUserContrllerPairingChangedDelegate(delegate<OnSystemUserControllerPairingChanged> PairingChangeDelegate)
{
    //return;    
}

function ClearSystemUserContrllerPairingChangedDelegate(delegate<OnSystemUserControllerPairingChanged> PairingChangeDelegate)
{
    //return;    
}

function bool PairUserAndControllerAtIndex(byte PlayerIndex, byte ControllerIndex, int PairIndex)
{
    //return ReturnValue;    
}

function OnlineSubsystem.EOnlineServerConnectionStatus GetCurrentConnectionStatus()
{
    //return ReturnValue;    
}

delegate OnTokenAndSignatureRetrieved(byte LocalUserNum, string URL, string Token, string Signature)
{
    //return;    
}

function GetTokenAndSignatureForURL(byte LocalUserNum, string URL)
{
    //return;    
}

function AddURLTokenRetrievedDelegate(byte LocalUserNum, delegate<OnTokenAndSignatureRetrieved> tsrDelegate)
{
    //return;    
}

function ClearURLTokenRetrievedDelegate(byte LocalUserNum, delegate<OnTokenAndSignatureRetrieved> tsrDelegate)
{
    //return;    
}

delegate OnUserAccountInfoRetrieved(bool bSuccessful, UserAccountInfo AccountInfo)
{
    //return;    
}

function bool GetUserAccountInfo(byte LocalUserNum)
{
    //return ReturnValue;    
}

function AddGetUserAccountInfoDelegate(delegate<OnUserAccountInfoRetrieved> InDelegate)
{
    //return;    
}

function ClearGetUserAccountInfoDelegate(delegate<OnUserAccountInfoRetrieved> InDelegate)
{
    //return;    
}

defaultproperties
{
    LoggedInPlayerName="Local Profile"
    CurrentNotificationPosition=ENetworkNotificationPosition.NNP_BottomRight
    ConnectionPresenceTimeInterval=0.5000000
}