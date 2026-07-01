class PComPlayerController extends GamePlayerController
    native
    config(Game)
    hidecategories(Navigation);

var UniqueNetId m_LastPendingPartyInviteId;
var bool m_bPartySessionJoinInProgress;
var bool m_bPartySessionCreateInProgress;
var bool m_bPartyDestroyInProgress;
var transient bool m_bQuittingToMainMenu;
var transient bool m_bHasAcknowledgedPawn;
var transient bool m_bLastClientTokenRequestFailed;
var globalconfig bool m_bKeepLoggedIn;
var dword m_dwPendingPartyId;
var config int m_nMaxPartyPublicConnections;
var OnlineGameSearchResult m_PendingInviteResult;
var const name PartySessionName;
var const name GameSessionName;
var globalconfig dword m_dwLastLoginPortalId;
var globalconfig dword m_dwLastLoginAccountId;
var globalconfig string m_sLastLoginAccessToken;
var globalconfig string m_sLastLoginAccessTokenExpiration;

// Export UPComPlayerController::execClientAddCheats(FFrame&, void* const)
native function ClientAddCheats();

// xiloe: added bFore to stop UDK from bitching
simulated function AddCheats(optional bool bForce)
{
    ClientAddCheats();
    //return;    
}

exec function TestVideoPlayer()
{
    //return;    
}

// Export UPComPlayerController::execUpdateDatacenterPing(FFrame&, void* const)
native function UpdateDatacenterPing();

// Export UPComPlayerController::execChallengeCreate(FFrame&, void* const)
native exec function ChallengeCreate(int nQueue, string fsName, optional string fsPassword);

// Export UPComPlayerController::execChallengeJoin(FFrame&, void* const)
native exec function ChallengeJoin(int nMatchId, string fsName, optional string fsPassword);

// Export UPComPlayerController::execUpdateClientToken(FFrame&, void* const)
native function UpdateClientToken(string Token);

// Export UPComPlayerController::execUpdateClientAuthToken(FFrame&, void* const)
native function UpdateClientAuthToken(string Token);

// Export UPComPlayerController::execValidateCreatedPartySession(FFrame&, void* const)
native function ValidateCreatedPartySession();

// Export UPComPlayerController::execPlayerRetrievedOSSInventory(FFrame&, void* const)
//native function PlayerRetrievedOSSInventory(out array<MarketplaceInventoryItem> Items);

// Export UPComPlayerController::execBeginLogin(FFrame&, void* const)
native exec function BeginLogin();

// Export UPComPlayerController::execGetTokenURL(FFrame&, void* const)
native function string GetTokenURL();

event GetOSSTokenAndSignatureForLogin()
{
    //return;    
}

function PlayerReceivedURLTokenAndSignatureForLogin(bool bSuccess, byte LocalUserNum, string URL, string Token, string AuthToken, string Signature)
{
    //return;    
}

// Export UPComPlayerController::execPlayerReceivedTokenForLogin(FFrame&, void* const)
native function PlayerReceivedTokenForLogin(bool bSuccess);

event CacheLoggedInGamepad()
{
    //return;    
}

event bool ShowConsoleLoginUI(int ControllerId, optional bool bForceLoginAfter)
{
    //return ReturnValue;    
}

event bool IsLoggedIntoOSS()
{
    //return ReturnValue;    
}

event RefreshStoreData()
{
    //return;    
}

//function OnReadAvailableProductsComplete(OnlineSubsystem.EMediaItemType MediaType)
//{
    //return;    
//}

//function OnReadDetailsForProductIdListComplete(out array<MarketplaceProductDetails> ProductList)
//{
    //return;    
//}

//function OnReadAdditionalProductDetailsComplete(OnlineSubsystem.EMediaItemType MediaType)
//{
    //return;    
//}

exec function DumpGameProducts()
{
    //return;    
}

exec function DumpDurables()
{
    //return;    
}

exec function DumpConumables()
{
    //return;    
}

//exec function DumpStoreCatalog(OnlineSubsystem.EMediaItemType MediaType)
//{
    //return;    
//}

event ProcessPortalInventoryWithAuthToken()
{
    //return;    
}

function PlayerReceivedURLTokenAndSignatureForPortalInventory(bool bSuccess, byte LocalUserNum, string URL, string Token, string AuthToken, string Signature)
{
    //return;    
}

function OnReadPlayerMarketplaceInventoryComplete()
{
    //return;    
}

event OnlineSubsystem.EOnlineEnumerationReadState GetPlayerDLCLicenses(out array<OnlineContent> ContentList)
{
    //return ReturnValue;    
}

simulated function OnMarketplaceItemPurchased()
{
    //return;    
}

// Export UPComPlayerController::execOnLoginStatusChange(FFrame&, void* const)
native function OnLoginStatusChange(OnlineSubsystem.ELoginStatus NewStatus, UniqueNetId NewId);

// Export UPComPlayerController::execOnConnectionStatusChange(FFrame&, void* const)
native function OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus);

// Export UPComPlayerController::execOnCurrentUserChanged(FFrame&, void* const)
native function OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser);

// Export UPComPlayerController::execOnRemoteTalkerStatusChange(FFrame&, void* const)
native function OnRemoteTalkerStatusChange(UniqueNetId RemoteNetId, bool bIsTalking);

// Export UPComPlayerController::execSendSessionStart(FFrame&, void* const)
native function SendSessionStart(int GameModeId);

// Export UPComPlayerController::execSendSessionEnd(FFrame&, void* const)
native function SendSessionEnd();

// Export UPComPlayerController::execIsInCustomMatch(FFrame&, void* const)
native simulated function bool IsInCustomMatch();

// Export UPComPlayerController::execMCTSSetSessionId(FFrame&, void* const)
native function MCTSSetSessionId(byte PlatformSpecificInfo[80]);

// Export UPComPlayerController::execTryJoinSession(FFrame&, void* const)
native function TryJoinSession();

// Export UPComPlayerController::execConnectToPeers(FFrame&, void* const)
//native simulated function ConnectToPeers(out array<SessionMemberInfo> SessionListInfo);

// Export UPComPlayerController::execShowPrivilegeMessageAndDeclineInvite(FFrame&, void* const)
native simulated function ShowPrivilegeMessageAndDeclineInvite();

// Export UPComPlayerController::execFilterFriendListForPeoplePicker(FFrame&, void* const)
//native simulated function FilterFriendListForPeoplePicker(out array<OnlineFriend> FriendList, out array<SessionMemberInfo> SessionMemberList);

// Export UPComPlayerController::execBlockPartySceneInput(FFrame&, void* const)
native function BlockPartySceneInput(bool bBlockInput);

// Export UPComPlayerController::execUpdateMCTSSession(FFrame&, void* const)
native simulated function UpdateMCTSSession(string SessionGuid, bool bIsHost);

// Export UPComPlayerController::execArePartySessionInvitesAllowed(FFrame&, void* const)
native function bool ArePartySessionInvitesAllowed();

// Export UPComPlayerController::execCreateOrJoinPartySession(FFrame&, void* const)
native function CreateOrJoinPartySession();

function bool ShouldPartySessionsBePublic()
{
    //return ReturnValue;    
}

// Export UPComPlayerController::execShowControllerDisconnectedWarning(FFrame&, void* const)
native function ShowControllerDisconnectedWarning();

// Export UPComPlayerController::execShowNoFriendsForPartyInviteWarning(FFrame&, void* const)
native function ShowNoFriendsForPartyInviteWarning();

// Export UPComPlayerController::execShowUnableToReadFriendsListWarning(FFrame&, void* const)
native function ShowUnableToReadFriendsListWarning();

// Export UPComPlayerController::execShowPartyFullWarning(FFrame&, void* const)
native function ShowPartyFullWarning(bool bPartySession);

// Export UPComPlayerController::execShowPartyNoLongerAvailableWarning(FFrame&, void* const)
native function ShowPartyNoLongerAvailableWarning();

// Export UPComPlayerController::execShowPackageNotInstalledForPartyInviteWarning(FFrame&, void* const)
native function ShowPackageNotInstalledForPartyInviteWarning();

// Export UPComPlayerController::execShowCustomGameDisallowedPopup(FFrame&, void* const)
native function ShowCustomGameDisallowedPopup();

// Export UPComPlayerController::execTryOpenPartyUI(FFrame&, void* const)
native function TryOpenPartyUI();

// Export UPComPlayerController::execUpdatePartyUI(FFrame&, void* const)
native function UpdatePartyUI();

// Export UPComPlayerController::execLeaveMatchQueue(FFrame&, void* const)
native function LeaveMatchQueue();

// Export UPComPlayerController::execOnAllMarketplaceProductDetailsRead(FFrame&, void* const)
native function OnAllMarketplaceProductDetailsRead();

function AcknowledgePossession(Pawn P)
{
    //return;    
}

reliable server event ServerAcknowledgePossession(Pawn P)
{
    //return;    
}

simulated event QuitToMainMenu()
{
    //return;    
}

function bool CleanupOnlineSubsystemSession(bool bWasFromMenu)
{
    //return ReturnValue;    
}

function FinishQuitToMainMenu()
{
    //return;    
}

function OnEndOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function OnDestroyOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

exec event ChooseThisControllerForSessionScout(bool bCustomMatch, int MaxPlayers, bool bPrivate, optional out array<UniqueNetId> ReservedMembers)
{
    //return;    
}

simulated function OnCreateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

reliable client simulated event ReceiveSessionInfo(byte PlatformSpecificInfo[80], WorldInfo.EConsoleType ConsoleType)
{
    //return;    
}

simulated function OnJoinOnlineGameCompleteForReceivedSessionInfo(name SessionName, bool bWasSuccessful)
{
    //return;    
}

simulated event RestablishVoiceForReconnect()
{
    //return;    
}

// Export UPComPlayerController::execIsReconnect(FFrame&, void* const)
native simulated function bool IsReconnect();

reliable server function ServerReEstablishP2PConnections()
{
    //return;    
}

reliable client simulated function ClientRestablishP2PConnections()
{
    //return;    
}

event RegisterOnlineDelegates()
{
    //return;    
}

event ClearOnlineDelegates()
{
    //return;    
}

// Export UPComPlayerController::execOnPrivilegeLevelChecked(FFrame&, void* const)
//native function OnPrivilegeLevelChecked(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint);

// Export UPComPlayerController::execOnPrivilegeCheckedForUsersByUniqueNetIds(FFrame&, void* const)
//native function OnPrivilegeCheckedForUsersByUniqueNetIds(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResultByUniqueNetId> Results);

// Export UPComPlayerController::execOnContentPurchaseResponse(FFrame&, void* const)
native function OnContentPurchaseResponse(bool bAuthorized, QWord qwOrderId);

// Export UPComPlayerController::execUpdateMctsWithFriends(FFrame&, void* const)
native function UpdateMctsWithFriends(bool bWasSuccessful);

// Export UPComPlayerController::execRequestUpdateFriendsList(FFrame&, void* const)
native function RequestUpdateFriendsList(optional bool bForceRequest = false);

// Export UPComPlayerController::execOnTextFilterApplied(FFrame&, void* const)
native function OnTextFilterApplied(string OriginalText, string FilteredText, bool bCensorCompletely);

event bool CanCommunicateText(byte LocalUserNum, out OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevelHint, optional bool bAttemptToResolve = false, optional string Reason = "")
{
    //return ReturnValue;    
}

event bool CanCommunicateTextWithUsersByUniqueNetIds(byte LocalUserNum, array<UniqueNetId> Users)
{
    //return ReturnValue;    
}

event bool CheckFilterText(string Text)
{
    //return ReturnValue;    
}

//function OnMultiplayerSessionChange(name SessionName, SessionUpdateInfo SessionChanges)
//{
    //return;    
//}

// Export UPComPlayerController::execIsPackageInstalled(FFrame&, void* const)
native function bool IsPackageInstalled();

// Export UPComPlayerController::execIsInGame(FFrame&, void* const)
native function bool IsInGame();

event PairLoggedInUserAndCurrentController()
{
    //return;    
}

event GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId)
{
    //return;    
}

simulated event LostP2PConnection(UniqueNetId UniqueId)
{
    //return;    
}

simulated exec event EstablishPeers()
{
    //return;    
}

// Export UPComPlayerController::execCloseConnectionsToInvalidPeers(FFrame&, void* const)
//native simulated function CloseConnectionsToInvalidPeers(array<SessionMemberInfo> SessionListInfo);

// Export UPComPlayerController::execGetUserNamesForPS4P2PConnections(FFrame&, void* const)
native simulated function array<string> GetUserNamesForPS4P2PConnections();

//simulated function OnGetUserConnectionInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful)
//{
    //return;    
//}

//simulated function OnGetSessionMemberInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful)
//{
    //return;    
//}

//simulated function OnGetVoicePermissionsForUsersComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResult> Results)
//{
    //return;    
//}

event UnregisterP2PEnemiesForCustomMatch(array<UniqueNetId> EnemyIds)
{
    //return;    
}

simulated exec event CreatePartySession()
{
    //return;    
}

simulated function OnCreatePartySessionComplete(name SessionName, bool bSuccessful)
{
    //return;    
}

event bool InvitePlayerToPartyByName(string InPlayerName)
{
    //return ReturnValue;    
}

event bool InvitePlayerToParty(UniqueNetId InPlayerId)
{
    //return ReturnValue;    
}

simulated exec event DestroyPartySession()
{
    //return;    
}

simulated event OnPartySessionDestroyed(name SessionName, bool bWasSuccessful)
{
    //return;    
}

event JoinPartySession(byte PartySessionGuid[80])
{
    //return;    
}

simulated function OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult)
{
    //return;    
}

//simulated function OnAlternatePrivilegeLevelCheckedComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
//{
    //return;    
//}

simulated function OnGameDestroyedForPartyJoin(name SessionName, bool bWasSuccessful)
{
    //return;    
}

//simulated function OnPrivilegeLevelCheckedCompleteForPartyJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
//{
    //return;    
//}

//simulated function OnPrivilegeCheckForGameSessionJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
//{
    //return;    
//}

simulated function OnJoinSessionForReceivedInviteComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

event JoinCustomMatchFromInvite()
{
    //return;    
}

function JoinCustomMatchForInviteDelay()
{
    //return;    
}

simulated exec event bool ShowPeoplePickerUI()
{
    //return ReturnValue;    
}

function OnReadFriendsListComplete(bool bWasSuccessful)
{
    //return;    
}

function OnPeoplePickerComplete(bool bWasSuccessful, array<OnlineFriend> PeoplePicked)
{
    //return;    
}

simulated event bool IsHostOfParty()
{
    //return ReturnValue;    
}

simulated event UpdateMCTSWithNewPartyInfo()
{
    //return;    
}

simulated event TogglePartySessionInvitesAllowed(bool bAllowed)
{
    //return;    
}

simulated event ToggleGameSessionInvitesAllowed(bool bAllowed)
{
    //return;    
}

simulated event SetAsNewPartyHost()
{
    //return;    
}

event TryAutoLoginDelayed()
{
    //return;    
}

// Export UPComPlayerController::execTryAutoLogin(FFrame&, void* const)
native function bool TryAutoLogin();

reliable client simulated event ClientPlayInputLightingEffect(name InPresetName, optional bool bUseOverrideStartTime = false, optional float OverrideStartTime = 0.0000000)
{
    //return;    
}

// Export UPComPlayerController::execPlayInputLightingEffect(FFrame&, void* const)
native function PlayInputLightingEffect(name InPresetName, optional bool bUseOverrideStartTime = false, optional float OverrideStartTime = 0.0000000);

// Export UPComPlayerController::execStopInputLightingEffect(FFrame&, void* const)
native function StopInputLightingEffect(name InPresetName);

// Export UPComPlayerController::execSetCurrentTimeForInputLightingEffect(FFrame&, void* const)
native function SetCurrentTimeForInputLightingEffect(name InPresetName, float InCurrentTime);

exec event PlayTestInputLightingEffect(name InPresetName)
{
    //return;    
}

defaultproperties
{
    PartySessionName="Party"
    GameSessionName="Game"
    InputClass=Class'PComPlayerInput'
    
    // remove?
    CylinderComponent=CollisionCylinder
    Components(0)=CollisionCylinder
    CollisionComponent=CollisionCylinder
}