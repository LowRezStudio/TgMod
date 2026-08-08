class PComPlayerController extends GamePlayerController
    native
    config(Game)
    hidecategories(Navigation);

var UniqueNetId m_LastPendingPartyInviteId;
var bool m_bPartySessionJoinInProgress;
var bool m_bPartySessionCreateInProgress;
var bool m_bPartyDestroyInProgress;
var transient bool m_bQuittingToMainMenu;
var config int m_nMaxPartyPublicConnections;
var OnlineGameSearchResult m_PendingInviteResult;
var const name PartySessionName;
var const name GameSessionName;

native function ClientAddCheats();  // Export UPComPlayerController::execClientAddCheats(FFrame&, void* const)

simulated function AddCheats(optional bool bForce) { }

exec function TestVideoPlayer() { }

native exec function DumpConfig();  // Export UPComPlayerController::execDumpConfig(FFrame&, void* const)

native exec function string GetConfig(string Key);  // Export UPComPlayerController::execGetConfig(FFrame&, void* const)

native exec function int GetConfigInt(string Key);  // Export UPComPlayerController::execGetConfigInt(FFrame&, void* const)

native exec function bool GetConfigBool(string Key);  // Export UPComPlayerController::execGetConfigBool(FFrame&, void* const)

native exec function SetConfig(string Key, string Value);  // Export UPComPlayerController::execSetConfig(FFrame&, void* const)

native exec function TeamInvite(string fsName);  // Export UPComPlayerController::execTeamInvite(FFrame&, void* const)

native exec function TeamAccept(bool bAccepted);  // Export UPComPlayerController::execTeamAccept(FFrame&, void* const)

native exec function TeamLeave();  // Export UPComPlayerController::execTeamLeave(FFrame&, void* const)

native exec function TeamSetLeader(string fsLeader);  // Export UPComPlayerController::execTeamSetLeader(FFrame&, void* const)

native exec function ChallengeCreate(int nQueue, string fsName, optional string fsPassword);  // Export UPComPlayerController::execChallengeCreate(FFrame&, void* const)

native exec function ChallengeJoin(int nQueue, string fsName, optional string fsPassword);  // Export UPComPlayerController::execChallengeJoin(FFrame&, void* const)

native function PlayerRetrievedOSSInventory(out array<MarketplaceInventoryItem> Items);  // Export UPComPlayerController::execPlayerRetrievedOSSInventory(FFrame&, void* const)

native function SendPlayerDLCLicensesToServer();  // Export UPComPlayerController::execSendPlayerDLCLicensesToServer(FFrame&, void* const)

native function PlayerReceivedURLTokenAndSignature(byte LocalUserNum, string URL, string Token, string Signature);  // Export UPComPlayerController::execPlayerReceivedURLTokenAndSignature(FFrame&, void* const)

event RefreshStoreData() { }

function OnReadAvailableProductsComplete(OnlineSubsystem.EMediaItemType MediaType) { }

function OnReadAdditionalProductDetailsComplete(OnlineSubsystem.EMediaItemType MediaType) { }

exec function DumpGameProducts() { }

exec function DumpDurables() { }

exec function DumpConumables() { }

exec function DumpStoreCatalog(OnlineSubsystem.EMediaItemType MediaType) { }

event GetOSSTokenAndSignature(string URL) { }

event GetMarketplaceInventory() { }

function OnReadPlayerMarketplaceInventoryComplete() { }

event OnlineSubsystem.EOnlineEnumerationReadState GetPlayerDLCLicenses(out array<OnlineContent> ContentList) { }

simulated function OnMarketplaceItemPurchased() { }

native function OnLoginStatusChange(OnlineSubsystem.ELoginStatus NewStatus, UniqueNetId NewId);  // Export UPComPlayerController::execOnLoginStatusChange(FFrame&, void* const)

native function OnConnectionStatusChange(OnlineSubsystem.EOnlineServerConnectionStatus ConnectionStatus);  // Export UPComPlayerController::execOnConnectionStatusChange(FFrame&, void* const)

native function OnCurrentUserChanged(byte LocalUserNum, string CurrentUser, string LoggedInUser);  // Export UPComPlayerController::execOnCurrentUserChanged(FFrame&, void* const)

native function OnRemoteTalkerStatusChange(UniqueNetId RemoteNetId, bool bIsTalking);  // Export UPComPlayerController::execOnRemoteTalkerStatusChange(FFrame&, void* const)

native function SendSessionStart(int GameModeId);  // Export UPComPlayerController::execSendSessionStart(FFrame&, void* const)

native function SendSessionEnd();  // Export UPComPlayerController::execSendSessionEnd(FFrame&, void* const)

native simulated function bool IsInCustomMatch();  // Export UPComPlayerController::execIsInCustomMatch(FFrame&, void* const)

native function MCTSSetSessionId(byte PlatformSpecificInfo[80]);  // Export UPComPlayerController::execMCTSSetSessionId(FFrame&, void* const)

native function TryJoinSession();  // Export UPComPlayerController::execTryJoinSession(FFrame&, void* const)

native simulated function ConnectToPeers(out array<SessionMemberInfo> SessionListInfo);  // Export UPComPlayerController::execConnectToPeers(FFrame&, void* const)

native simulated function AcceptPartyInvite(string InviterName);  // Export UPComPlayerController::execAcceptPartyInvite(FFrame&, void* const)

native simulated function ShowPrivilegeMessageAndDeclineInvite();  // Export UPComPlayerController::execShowPrivilegeMessageAndDeclineInvite(FFrame&, void* const)

native simulated function FilterFriendListForPeoplePicker(out array<OnlineFriend> FriendList, out array<SessionMemberInfo> SessionMemberList);  // Export UPComPlayerController::execFilterFriendListForPeoplePicker(FFrame&, void* const)

native function BlockPartySceneInput(bool bBlockInput);  // Export UPComPlayerController::execBlockPartySceneInput(FFrame&, void* const)

native simulated function UpdateMCTSSession(string SessionGuid, bool bIsHost);  // Export UPComPlayerController::execUpdateMCTSSession(FFrame&, void* const)

native function bool ArePartySessionInvitesAllowed();  // Export UPComPlayerController::execArePartySessionInvitesAllowed(FFrame&, void* const)

function bool ShouldPartySessionsBePublic() { }

native function ShowControllerDisconnectedWarning();  // Export UPComPlayerController::execShowControllerDisconnectedWarning(FFrame&, void* const)

native function ShowNoFriendsForPartyInviteWarning();  // Export UPComPlayerController::execShowNoFriendsForPartyInviteWarning(FFrame&, void* const)

native function ShowUnableToReadFriendsListWarning();  // Export UPComPlayerController::execShowUnableToReadFriendsListWarning(FFrame&, void* const)

native function ShowPartyFullWarning(bool bPartySession);  // Export UPComPlayerController::execShowPartyFullWarning(FFrame&, void* const)

native function ShowPartyNoLongerAvailableWarning();  // Export UPComPlayerController::execShowPartyNoLongerAvailableWarning(FFrame&, void* const)

native function ShowPackageNotInstalledForPartyInviteWarning();  // Export UPComPlayerController::execShowPackageNotInstalledForPartyInviteWarning(FFrame&, void* const)

native function ShowCustomGameDisallowedPopup();  // Export UPComPlayerController::execShowCustomGameDisallowedPopup(FFrame&, void* const)

native function TryOpenPartyUI();  // Export UPComPlayerController::execTryOpenPartyUI(FFrame&, void* const)

native function UpdatePartyUI();  // Export UPComPlayerController::execUpdatePartyUI(FFrame&, void* const)

native function LeaveMatchQueue();  // Export UPComPlayerController::execLeaveMatchQueue(FFrame&, void* const)

native function OnAllMarketplaceProductDetailsRead();  // Export UPComPlayerController::execOnAllMarketplaceProductDetailsRead(FFrame&, void* const)

function AcknowledgePossession(Pawn P) { }

simulated event QuitToMainMenu() { }

function bool CleanupOnlineSubsystemSession(bool bWasFromMenu) { }

function FinishQuitToMainMenu() { }

function OnEndOnlineGameComplete(name SessionName, bool bWasSuccessful) { }

function OnDestroyOnlineGameComplete(name SessionName, bool bWasSuccessful) { }

exec event ChooseThisControllerForSessionScout(bool bCustomMatch, int MaxPlayers, bool bPrivate, optional out array<UniqueNetId> ReservedMembers) { }

simulated function OnCreateOnlineGameComplete(name SessionName, bool bWasSuccessful) { }

reliable client simulated event ReceiveSessionInfo(byte PlatformSpecificInfo[80], WorldInfo.EConsoleType ConsoleType) { }

simulated function OnJoinOnlineGameCompleteForReceivedSessionInfo(name SessionName, bool bWasSuccessful) { }

simulated event RestablishVoiceForReconnect() { }

native simulated function bool IsReconnect();  // Export UPComPlayerController::execIsReconnect(FFrame&, void* const)

reliable server function ServerReEstablishP2PConnections() { }

reliable client simulated function ClientRestablishP2PConnections() { }

event RegisterOnlineDelegates() { }

event ClearOnlineDelegates() { }

function OnMultiplayerSessionChange(name SessionName, SessionUpdateInfo SessionChanges) { }

native function bool IsPackageInstalled();  // Export UPComPlayerController::execIsPackageInstalled(FFrame&, void* const)

native function bool IsInGame();  // Export UPComPlayerController::execIsInGame(FFrame&, void* const)

native function LogoutPlayer();  // Export UPComPlayerController::execLogoutPlayer(FFrame&, void* const)

event PairLoggedInUserAndCurrentController() { }

event GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId) { }

simulated event LostP2PConnection(UniqueNetId UniqueId) { }

simulated exec event EstablishPeers() { }

native simulated function CloseConnectionsToInvalidPeers(array<SessionMemberInfo> SessionListInfo);  // Export UPComPlayerController::execCloseConnectionsToInvalidPeers(FFrame&, void* const)

native simulated function array<string> GetUserNamesForPS4P2PConnections();  // Export UPComPlayerController::execGetUserNamesForPS4P2PConnections(FFrame&, void* const)

simulated function OnGetUserConnectionInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful) { }

simulated function OnGetSessionMemberInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful) { }

simulated function OnGetVoicePermissionsForUsersComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResult> Results) { }

event UnregisterP2PEnemiesForCustomMatch(array<UniqueNetId> EnemyIds) { }

simulated exec event CreatePartySession() { }

simulated function OnCreatePartySessionComplete(name SessionName, bool bSuccessful) { }

event InvitePlayerToPartyByName(string InPlayerName) { }

event InvitePlayerToParty(UniqueNetId InPlayerId) { }

simulated exec event DestroyPartySession() { }

simulated function OnPartySessionDestroyed(name SessionName, bool bWasSuccessful) { }

simulated function OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult) { }

simulated function OnAlternatePrivilegeLevelCheckedComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint) { }

simulated function OnGameDestroyedForPartyJoin(name SessionName, bool bWasSuccessful) { }

simulated function OnPrivilegeLevelCheckedCompleteForPartyJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint) { }

simulated function OnPrivilegeCheckForGameSessionJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint) { }

simulated function OnJoinSessionForReceivedInviteComplete(name SessionName, bool bWasSuccessful) { }

event JoinCustomMatchFromInvite() { }

function JoinCustomMatchForInviteDelay() { }

simulated exec event bool ShowPeoplePickerUI() { }

function OnReadFriendsListComplete(bool bWasSuccessful) { }

function OnPeoplePickerComplete(bool bWasSuccessful, array<OnlineFriend> PeoplePicked) { }

simulated event bool IsHostOfParty() { }

simulated event UpdateMCTSWithNewPartyInfo() { }

simulated event TogglePartySessionInvitesAllowed(bool bAllowed) { }

simulated event ToggleGameSessionInvitesAllowed(bool bAllowed) { }

simulated event SetAsNewPartyHost() { }

event TryAutoLoginDelayed() { }

native function bool TryAutoLogin();  // Export UPComPlayerController::execTryAutoLogin(FFrame&, void* const)

reliable client simulated event ClientPlayInputLightingEffect(name InPresetName, optional bool bUseOverrideStartTime=false, optional float OverrideStartTime=0.0000000) { }

native function PlayInputLightingEffect(name InPresetName, optional bool bUseOverrideStartTime=false, optional float OverrideStartTime=0.0000000);  // Export UPComPlayerController::execPlayInputLightingEffect(FFrame&, void* const)

native function StopInputLightingEffect(name InPresetName);  // Export UPComPlayerController::execStopInputLightingEffect(FFrame&, void* const)

native function SetCurrentTimeForInputLightingEffect(name InPresetName, float InCurrentTime);  // Export UPComPlayerController::execSetCurrentTimeForInputLightingEffect(FFrame&, void* const)

exec event PlayTestInputLightingEffect(name InPresetName) { }

defaultproperties
{}
