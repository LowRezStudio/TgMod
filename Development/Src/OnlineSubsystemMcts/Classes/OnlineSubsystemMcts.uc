class OnlineSubsystemMcts extends OnlineSubsystemCommonImpl
    native
    config(Engine)
    implements(OnlinePlayerInterface,OnlineSystemInterface,OnlineChatInterface);

struct ControllerConnectionState {
    var const int bIsControllerConnected;
    var const int bLastIsControllerConnected;
    structdefaultproperties {}
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

native event bool Init();  // Export UOnlineSubsystemMcts::execInit(FFrame&, void* const)

delegate OnLoginChange(byte LocalUserNum);

native function bool Login(byte LocalUserNum, string LoginName, string Password, optional bool bWantsLocalOnly);  // Export UOnlineSubsystemMcts::execLogin(FFrame&, void* const)

native function bool RequestNewPlayer(byte LocalUserNum, string LoginName, string Password, string DesiredPlayerName);  // Export UOnlineSubsystemMcts::execRequestNewPlayer(FFrame&, void* const)

native function bool AutoLogin();  // Export UOnlineSubsystemMcts::execAutoLogin(FFrame&, void* const)

delegate OnLoginFailed(byte LocalUserNum, EOnlineServerConnectionStatus ErrorCode);

function AddLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginFailedDelegate) { }

function ClearLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginFailedDelegate) { }

native function bool Logout(byte LocalUserNum);  // Export UOnlineSubsystemMcts::execLogout(FFrame&, void* const)

delegate OnLogoutCompleted(bool bWasSuccessful);

function AddLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate) { }

function ClearLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate) { }

native function ELoginStatus GetLoginStatus(byte LocalUserNum);  // Export UOnlineSubsystemMcts::execGetLoginStatus(FFrame&, void* const)

function bool IsGuestLogin(byte LocalUserNum) { }

function bool IsLocalLogin(byte LocalUserNum) { }

function bool GetUniquePlayerId(byte LocalUserNum, out UniqueNetId PlayerID) { }

function bool GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId) { }

function CacheLoggedInGamepad() { }

function string GetPlayerNickname(byte LocalUserNum) { }

native function EFeaturePrivilegeLevel CanPlayOnline(byte LocalUserNum);  // Export UOnlineSubsystemMcts::execCanPlayOnline(FFrame&, void* const)

function EFeaturePrivilegeLevel CanDownloadUserContent(byte LocalUserNum) { }

function EFeaturePrivilegeLevel CanPurchaseContent(byte LocalUserNum) { }

function EFeaturePrivilegeLevel CanViewPlayerProfiles(byte LocalUserNum) { }

function EFeaturePrivilegeLevel CanShowPresenceInformation(byte LocalUserNum) { }

native function bool IsFriend(byte LocalUserNum, UniqueNetId PlayerID);  // Export UOnlineSubsystemMcts::execIsFriend(FFrame&, void* const)

native function bool AreAnyFriends(byte LocalUserNum, out array<FriendsQuery> Query);  // Export UOnlineSubsystemMcts::execAreAnyFriends(FFrame&, void* const)

native function string GetPlayerMctsName();  // Export UOnlineSubsystemMcts::execGetPlayerMctsName(FFrame&, void* const)

function AddLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate) { }

function ClearLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate) { }

native function bool NeedEULA();  // Export UOnlineSubsystemMcts::execNeedEULA(FFrame&, void* const)

event string GetPlayerNicknameFromIndex(int UserIndex) { }

event UniqueNetId GetPlayerUniqueNetIdFromIndex(int UserIndex) { }

native function bool HasLinkConnection();  // Export UOnlineSubsystemMcts::execHasLinkConnection(FFrame&, void* const)

delegate OnLinkStatusChange(bool bIsConnected);

function AddLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate) { }

function ClearLinkStatusChangeDelegate(delegate<OnLinkStatusChange> LinkStatusDelegate) { }

delegate OnExternalUIChange(bool bIsOpening);

function AddExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate) { }

function ClearExternalUIChangeDelegate(delegate<OnExternalUIChange> ExternalUIDelegate) { }

function ENetworkNotificationPosition GetNetworkNotificationPosition() { }

delegate OnControllerChange(int ControllerId, bool bIsConnected);

function AddControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate) { }

function ClearControllerChangeDelegate(delegate<OnControllerChange> ControllerChangeDelegate) { }

native function bool IsControllerConnected(int ControllerId);  // Export UOnlineSubsystemMcts::execIsControllerConnected(FFrame&, void* const)

delegate OnConnectionStatusChange(EOnlineServerConnectionStatus ConnectionStatus);

function AddConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate) { }

function ClearConnectionStatusChangeDelegate(delegate<OnConnectionStatusChange> ConnectionStatusDelegate) { }

native function ENATType GetNATType();  // Export UOnlineSubsystemMcts::execGetNATType(FFrame&, void* const)

delegate OnStorageDeviceChange();

function AddStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate) { }

function ClearStorageDeviceChangeDelegate(delegate<OnStorageDeviceChange> StorageDeviceChangeDelegate) { }

delegate OnChatMessage(int Channel, string Sender, string Message);

function AddChatMessageDelegate(delegate<OnChatMessage> ChatDelegate) { }

function ClearChatMessageDelegate(delegate<OnChatMessage> ChatDelegate) { }

native function SendChatMessage(int Channel, string Message);  // Export UOnlineSubsystemMcts::execSendChatMessage(FFrame&, void* const)

native function SendPrivateChatMessage(string PlayerName, string Message);  // Export UOnlineSubsystemMcts::execSendPrivateChatMessage(FFrame&, void* const)

native function NotifyTeamChange(QWord PlayerUID, byte TeamID);  // Export UOnlineSubsystemMcts::execNotifyTeamChange(FFrame&, void* const)

function bool IsMuted(byte LocalUserNum, UniqueNetId PlayerID) { }

native function EFeaturePrivilegeLevel CanCommunicate(byte LocalUserNum);  // Export UOnlineSubsystemMcts::execCanCommunicate(FFrame&, void* const)

delegate OnLoginStatusChange(ELoginStatus NewStatus, UniqueNetId NewId);

function AddLoginStatusChangeDelegate(delegate<OnLoginStatusChange> LoginStatusDelegate, byte LocalUserNum) { }

function ClearLoginStatusChangeDelegate(delegate<OnLoginStatusChange> LoginStatusDelegate, byte LocalUserNum) { }

delegate OnLoginCancelled();

function AddLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate) { }

function ClearLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate) { }

function bool ReadProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings) { }

function bool WriteProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings) { }

function OnlineProfileSettings GetProfileSettings(byte LocalUserNum) { }

delegate OnMutingChange();

function AddMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate) { }

function ClearMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate) { }

delegate OnReadProfileSettingsComplete(byte LocalUserNum, bool bWasSuccessful);

function AddReadProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate) { }

function ClearReadProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnReadProfileSettingsComplete> ReadProfileSettingsCompleteDelegate) { }

delegate OnWriteProfileSettingsComplete(byte LocalUserNum, bool bWasSuccessful);

function AddWriteProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate) { }

function ClearWriteProfileSettingsCompleteDelegate(byte LocalUserNum, delegate<OnWriteProfileSettingsComplete> WriteProfileSettingsCompleteDelegate) { }

function bool ReadPlayerStorage(byte LocalUserNum, OnlinePlayerStorage PlayerStorage, optional int DeviceID=-1) { }

delegate OnReadPlayerStorageComplete(byte LocalUserNum, bool bWasSuccessful);

function AddReadPlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnReadPlayerStorageComplete> ReadPlayerStorageCompleteDelegate) { }

function ClearReadPlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnReadPlayerStorageComplete> ReadPlayerStorageCompleteDelegate) { }

function bool ReadPlayerStorageForNetId(byte LocalUserNum, UniqueNetId NetId, OnlinePlayerStorage PlayerStorage) { }

delegate OnReadPlayerStorageForNetIdComplete(UniqueNetId NetId, bool bWasSuccessful);

function AddReadPlayerStorageForNetIdCompleteDelegate(UniqueNetId NetId, delegate<OnReadPlayerStorageForNetIdComplete> ReadPlayerStorageForNetIdCompleteDelegate) { }

function ClearReadPlayerStorageForNetIdCompleteDelegate(UniqueNetId NetId, delegate<OnReadPlayerStorageForNetIdComplete> ReadPlayerStorageForNetIdCompleteDelegate) { }

function OnlinePlayerStorage GetPlayerStorage(byte LocalUserNum) { }

function bool WritePlayerStorage(byte LocalUserNum, OnlinePlayerStorage PlayerStorage, optional int DeviceID=-1) { }

delegate OnWritePlayerStorageComplete(byte LocalUserNum, bool bWasSuccessful);

function AddWritePlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnWritePlayerStorageComplete> WritePlayerStorageCompleteDelegate) { }

function ClearWritePlayerStorageCompleteDelegate(byte LocalUserNum, delegate<OnWritePlayerStorageComplete> WritePlayerStorageCompleteDelegate) { }

delegate OnFriendsChange();

function AddFriendsChangeDelegate(byte LocalUserNum, delegate<OnFriendsChange> FriendsDelegate) { }

function ClearFriendsChangeDelegate(byte LocalUserNum, delegate<OnFriendsChange> FriendsDelegate) { }

function bool ReadFriendsList(byte LocalUserNum, optional int Count, optional int StartingAt) { }

delegate OnReadFriendsComplete(bool bWasSuccessful);

function AddReadFriendsCompleteDelegate(byte LocalUserNum, delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate) { }

function ClearReadFriendsCompleteDelegate(byte LocalUserNum, delegate<OnReadFriendsComplete> ReadFriendsCompleteDelegate) { }

function EOnlineEnumerationReadState GetFriendsList(byte LocalUserNum, out array<OnlineFriend> Friends, optional int Count, optional int StartingAt) { }

function SetOnlineStatus(byte LocalUserNum, int StatusId, const out array<LocalizedStringSetting> LocalizedStringSettings, const out array<SettingsProperty> Properties) { }

function bool ShowKeyboardUI(byte LocalUserNum, string TitleText, string DescriptionText, optional bool bIsPassword=false, optional bool bShouldValidate=true, optional string DefaultText, optional int MaxResultLength=256) { }

delegate OnKeyboardInputComplete(bool bWasSuccessful);

function AddKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate) { }

function ClearKeyboardInputDoneDelegate(delegate<OnKeyboardInputComplete> InputDelegate) { }

function string GetKeyboardInputResults(out byte bWasCanceled) { }

function bool AddFriend(byte LocalUserNum, UniqueNetId NewFriend, optional string Message) { }

function bool AddFriendByName(byte LocalUserNum, string FriendName, optional string Message) { }

delegate OnAddFriendByNameComplete(bool bWasSuccessful);

function AddAddFriendByNameCompleteDelegate(byte LocalUserNum, delegate<OnAddFriendByNameComplete> FriendDelegate) { }

function ClearAddFriendByNameCompleteDelegate(byte LocalUserNum, delegate<OnAddFriendByNameComplete> FriendDelegate) { }

function bool AcceptFriendInvite(byte LocalUserNum, UniqueNetId RequestingPlayer) { }

function bool DenyFriendInvite(byte LocalUserNum, UniqueNetId RequestingPlayer) { }

function bool RemoveFriend(byte LocalUserNum, UniqueNetId FormerFriend) { }

delegate OnFriendInviteReceived(byte LocalUserNum, UniqueNetId RequestingPlayer, string RequestingNick, string Message);

function AddFriendInviteReceivedDelegate(byte LocalUserNum, delegate<OnFriendInviteReceived> InviteDelegate) { }

function ClearFriendInviteReceivedDelegate(byte LocalUserNum, delegate<OnFriendInviteReceived> InviteDelegate) { }

function bool SendMessageToFriend(byte LocalUserNum, UniqueNetId Friend, string Message) { }

function bool SendGameInviteToFriend(byte LocalUserNum, UniqueNetId Friend, optional string Text) { }

function bool SendGameInviteToFriends(byte LocalUserNum, array<UniqueNetId> Friends, optional string Text) { }

delegate OnReceivedGameInvite(byte LocalUserNum, string InviterName);

function AddReceivedGameInviteDelegate(byte LocalUserNum, delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate) { }

function ClearReceivedGameInviteDelegate(byte LocalUserNum, delegate<OnReceivedGameInvite> ReceivedGameInviteDelegate) { }

function CheckForGameInviteOnLaunch() { }

function bool JoinFriendGame(byte LocalUserNum, UniqueNetId Friend) { }

delegate OnJoinFriendGameComplete(bool bWasSuccessful);

function AddJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate) { }

function ClearJoinFriendGameCompleteDelegate(delegate<OnJoinFriendGameComplete> JoinFriendGameCompleteDelegate) { }

function GetFriendMessages(byte LocalUserNum, out array<OnlineFriendMessage> FriendMessages) { }

delegate OnFriendMessageReceived(byte LocalUserNum, UniqueNetId SendingPlayer, string SendingNick, string Message);

function AddFriendMessageReceivedDelegate(byte LocalUserNum, delegate<OnFriendMessageReceived> MessageDelegate) { }

function ClearFriendMessageReceivedDelegate(byte LocalUserNum, delegate<OnFriendMessageReceived> MessageDelegate) { }

function bool UnlockAchievement(byte LocalUserNum, int AchievementId, optional float PercentComplete=100.0000000) { }

function bool ReadAchievements(byte LocalUserNum, optional int TitleId=0, optional bool bShouldReadText=true, optional bool bShouldReadImages=false) { }

function EOnlineEnumerationReadState GetAchievements(byte LocalUserNum, out array<AchievementDetails> Achievements, optional int TitleId = 0) { }

delegate OnUnlockAchievementComplete(bool bWasSuccessful);

function AddUnlockAchievementCompleteDelegate(byte LocalUserNum, delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate) { }

function ClearUnlockAchievementCompleteDelegate(byte LocalUserNum, delegate<OnUnlockAchievementComplete> UnlockAchievementCompleteDelegate) { }

delegate OnReadAchievementsComplete(int TitleId);

function AddReadAchievementsCompleteDelegate(byte LocalUserNum, delegate<OnReadAchievementsComplete> ReadAchievementsCompleteDelegate) { }

function ClearReadAchievementsCompleteDelegate(byte LocalUserNum, delegate<OnReadAchievementsComplete> ReadAchievementsCompleteDelegate) { }

function bool DeleteMessage(byte LocalUserNum, int MessageIndex) { }

function bool ShowFriendsUI(byte LocalUserNum) { }

delegate OnAccountPickerComplete(bool bForceLogin);

function AddAccountPickerCompleteDelegate(delegate<OnAccountPickerComplete> InDelegate) { }

function RemoveAccountPickerCompleteDelegate(delegate<OnAccountPickerComplete> InDelegate) { }

function bool ShowLoginUI(optional bool bShowOnlineOnly = false) { }

function SetNetworkNotificationPosition(ENetworkNotificationPosition NewPos) { }

function int GetLocale() { }

function ClearAchievements(byte LocalUserNum, optional int TitleId=0) { }

function bool HideKeyboardUI(byte LocalUserNum) { }

delegate OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser);

function AddCurrentUserChangedDelegate(delegate<OnCurrentUserChanged> CurrentUserDelegate) { }

function ClearCurrentUserChangedDelegate(delegate<OnCurrentUserChanged> CurrentUserDelegate) { }

delegate OnPrivilegeLevelChecked(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint);

function AddPrivilegeLevelCheckedDelegate(delegate<OnPrivilegeLevelChecked> PrivilegeDelegate) { }

function ClearPrivilegeLevelCheckedDelegate(delegate<OnPrivilegeLevelChecked> PrivilegeDelegate) { }

delegate OnPrivilegeCheckedForUsers(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResult> Results);

function AddPrivilegeCheckedForUsersDelegate(delegate<OnPrivilegeCheckedForUsers> PrivilegeDelegate) { }

function ClearPrivilegeCheckedForUsersDelegate(delegate<OnPrivilegeCheckedForUsers> PrivilegeDelegate) { }

function bool CanCommunicateText(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanCommunicateVideo(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanCommunicateVoice(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanCommunicateVoiceWithUsers(byte LocalUserNum, array<SessionMemberInfo> Users) { }

function bool CanShareUserCreatedContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanRecordDVRClips(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanUseCloudStorage(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanAccessPremiumContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanAccessPremiumVideoContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanBrowseInternet(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanShareWithSocialNetwork(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanShareKinectContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

function bool CanUploadFitnessData(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve=false, optional string Reason="") { }

delegate OnSystemUserControllerPairingChanged(int NewLocalUserNum, int PreviousLocalUserNum);

function AddSystemUserContrllerPairingChangedDelegate(delegate<OnSystemUserControllerPairingChanged> PairingChangeDelegate) { }

function ClearSystemUserContrllerPairingChangedDelegate(delegate<OnSystemUserControllerPairingChanged> PairingChangeDelegate) { }

function bool PairUserAndControllerAtIndex(byte PlayerIndex, byte ControllerIndex, int PairIndex) { }

function OnlineSubsystem.EOnlineServerConnectionStatus GetCurrentConnectionStatus() { }

delegate OnTokenAndSignatureRetrieved(byte LocalUserNum, string URL, string Token, string Signature);

function GetTokenAndSignatureForURL(byte LocalUserNum, string URL) { }

function AddURLTokenRetrievedDelegate(byte LocalUserNum, delegate<OnTokenAndSignatureRetrieved> tsrDelegate) { }

function ClearURLTokenRetrievedDelegate(byte LocalUserNum, delegate<OnTokenAndSignatureRetrieved> tsrDelegate) { }

delegate OnUserAccountInfoRetrieved(bool bSuccessful, UserAccountInfo AccountInfo);

function bool GetUserAccountInfo(byte LocalUserNum) { }

function AddGetUserAccountInfoDelegate(delegate<OnUserAccountInfoRetrieved> InDelegate) { }

function ClearGetUserAccountInfoDelegate(delegate<OnUserAccountInfoRetrieved> InDelegate) { }

defaultproperties
{
    LoggedInPlayerName="Local Profile"
    CurrentNotificationPosition=NNP_BottomRight
    ConnectionPresenceTimeInterval=0.5000000
}
