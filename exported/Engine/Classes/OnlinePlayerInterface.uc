interface OnlinePlayerInterface extends Interface
    abstract;

delegate OnLoginChange(byte LocalUserNum)
{
    //return;    
}

delegate OnLoginCancelled()
{
    //return;    
}

delegate OnCurrentUserChanged(byte CurrentUserLocalNum, string CurrentUser, string LoggedInUser)
{
    //return;    
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

delegate OnMutingChange()
{
    //return;    
}

delegate OnFriendsChange()
{
    //return;    
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

function bool Login(byte LocalUserNum, string LoginName, string Password, optional bool bWantsLocalOnly)
{
    //return ReturnValue;    
}

function bool AutoLogin()
{
    //return ReturnValue;    
}

delegate OnLoginFailed(byte LocalUserNum, OnlineSubsystem.EOnlineServerConnectionStatus ErrorCode)
{
    //return;    
}

function AddLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginDelegate)
{
    //return;    
}

function ClearLoginFailedDelegate(byte LocalUserNum, delegate<OnLoginFailed> LoginDelegate)
{
    //return;    
}

function bool Logout(byte LocalUserNum)
{
    //return ReturnValue;    
}

delegate OnLogoutCompleted(bool bWasSuccessful)
{
    //return;    
}

function AddLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate)
{
    //return;    
}

function ClearLogoutCompletedDelegate(byte LocalUserNum, delegate<OnLogoutCompleted> LogoutDelegate)
{
    //return;    
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

function CacheLoggedInGamepad()
{
    //return;    
}

function OnlineSubsystem.ELoginStatus GetLoginStatus(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool GetUniquePlayerId(byte LocalUserNum, out UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId)
{
    //return ReturnValue;    
}

function string GetPlayerNickname(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool IsGuestLogin(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool IsLocalLogin(byte LocalUserNum)
{
    //return ReturnValue;    
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

function bool CanPlayOnline(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
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

function bool CanPurchaseContent(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanViewPlayerProfiles(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

function bool CanShowPresenceInformation(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
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

function bool IsFriend(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool AreAnyFriends(byte LocalUserNum, out array<FriendsQuery> Query)
{
    //return ReturnValue;    
}

function bool IsMuted(byte LocalUserNum, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool ShowFriendsUI(byte LocalUserNum)
{
    //return ReturnValue;    
}

function AddLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate)
{
    //return;    
}

function ClearLoginChangeDelegate(delegate<OnLoginChange> LoginDelegate)
{
    //return;    
}

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

function AddLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate)
{
    //return;    
}

function ClearLoginCancelledDelegate(delegate<OnLoginCancelled> CancelledDelegate)
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

function AddMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate)
{
    //return;    
}

function ClearMutingChangeDelegate(delegate<OnMutingChange> MutingDelegate)
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

function bool ReadProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings)
{
    //return ReturnValue;    
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

function OnlineProfileSettings GetProfileSettings(byte LocalUserNum)
{
    //return ReturnValue;    
}

function bool WriteProfileSettings(byte LocalUserNum, OnlineProfileSettings ProfileSettings)
{
    //return ReturnValue;    
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

function bool HideKeyboardUI(byte LocalUserNum)
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

function bool DeleteMessage(byte LocalUserNum, int MessageIndex)
{
    //return ReturnValue;    
}

function bool UnlockAchievement(byte LocalUserNum, int AchievementId, optional float PercentComplete = 100.0000000)
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

function bool ReadAchievements(byte LocalUserNum, optional int TitleId = 0, optional bool bShouldReadText = true, optional bool bShouldReadImages = false)
{
    //return ReturnValue;    
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

function OnlineSubsystem.EOnlineEnumerationReadState GetAchievements(byte LocalUserNum, out array<AchievementDetails> Achievements, optional int TitleId = 0)
{
    //return ReturnValue;    
}

function ClearAchievements(byte LocalUserNum, optional int TitleId = 0)
{
    //return;    
}
