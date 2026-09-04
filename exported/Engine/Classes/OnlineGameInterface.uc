interface OnlineGameInterface extends Interface
    abstract;

function bool CreateOnlineGame(byte HostingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings)
{
    //return ReturnValue;    
}

delegate OnCreateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddCreateOnlineGameCompleteDelegate(delegate<OnCreateOnlineGameComplete> CreateOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearCreateOnlineGameCompleteDelegate(delegate<OnCreateOnlineGameComplete> CreateOnlineGameCompleteDelegate)
{
    //return;    
}

function bool UpdateOnlineGame(name SessionName, OnlineGameSettings UpdatedGameSettings, optional bool bShouldRefreshOnlineData = false)
{
    //return ReturnValue;    
}

delegate OnUpdateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddUpdateOnlineGameCompleteDelegate(delegate<OnUpdateOnlineGameComplete> UpdateOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearUpdateOnlineGameCompleteDelegate(delegate<OnUpdateOnlineGameComplete> UpdateOnlineGameCompleteDelegate)
{
    //return;    
}

function OnlineGameSettings GetGameSettings(name SessionName)
{
    //return ReturnValue;    
}

function bool DestroyOnlineGame(name SessionName)
{
    //return ReturnValue;    
}

delegate OnDestroyOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddDestroyOnlineGameCompleteDelegate(delegate<OnDestroyOnlineGameComplete> DestroyOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearDestroyOnlineGameCompleteDelegate(delegate<OnDestroyOnlineGameComplete> DestroyOnlineGameCompleteDelegate)
{
    //return;    
}

function bool FindOnlineGames(byte SearchingPlayerNum, OnlineGameSearch SearchSettings)
{
    //return ReturnValue;    
}

delegate OnFindOnlineGamesComplete(bool bWasSuccessful)
{
    //return;    
}

function AddFindOnlineGamesCompleteDelegate(delegate<OnFindOnlineGamesComplete> FindOnlineGamesCompleteDelegate)
{
    //return;    
}

function ClearFindOnlineGamesCompleteDelegate(delegate<OnFindOnlineGamesComplete> FindOnlineGamesCompleteDelegate)
{
    //return;    
}

function bool CancelFindOnlineGames()
{
    //return ReturnValue;    
}

delegate OnCancelFindOnlineGamesComplete(bool bWasSuccessful)
{
    //return;    
}

function AddCancelFindOnlineGamesCompleteDelegate(delegate<OnCancelFindOnlineGamesComplete> CancelFindOnlineGamesCompleteDelegate)
{
    //return;    
}

function ClearCancelFindOnlineGamesCompleteDelegate(delegate<OnCancelFindOnlineGamesComplete> CancelFindOnlineGamesCompleteDelegate)
{
    //return;    
}

delegate OnQosStatusChanged(int NumComplete, int NumTotal)
{
    //return;    
}

function AddQosStatusChangedDelegate(delegate<OnQosStatusChanged> QosStatusChangedDelegate)
{
    //return;    
}

function ClearQosStatusChangedDelegate(delegate<OnQosStatusChanged> QosStatusChangedDelegate)
{
    //return;    
}

function bool ReadPlatformSpecificSessionInfo(const out OnlineGameSearchResult DesiredGame, out byte PlatformSpecificInfo[80])
{
    //return ReturnValue;    
}

function bool ReadPlatformSpecificSessionInfoBySessionName(name SessionName, out byte PlatformSpecificInfo[80])
{
    //return ReturnValue;    
}

function bool BindPlatformSpecificSessionToSearch(byte SearchingPlayerNum, OnlineGameSearch SearchSettings, byte PlatformSpecificInfo[80])
{
    //return ReturnValue;    
}

function OnlineGameSearch GetGameSearch()
{
    //return ReturnValue;    
}

function bool FreeSearchResults(optional OnlineGameSearch Search)
{
    //return ReturnValue;    
}

function bool QueryNonAdvertisedData(int StartAt, int NumberToQuery)
{
    //return ReturnValue;    
}

function bool JoinOnlineGame(byte PlayerNum, name SessionName, const out OnlineGameSearchResult DesiredGame)
{
    //return ReturnValue;    
}

function bool JoinOnlineGameBySessionHandle(byte PlayerNum, name SessionName, const string InSessionGuid)
{
    //return ReturnValue;    
}

function OnMapChangePending()
{
    //return;    
}

function OnMapChangeComplete()
{
    //return;    
}

function bool JoinOnlineGameByMatchingParams(QWord RoomId, out OnlineGameSettings JoinedGameSettings)
{
    //return ReturnValue;    
}

function bool IsJoinOperationInProgress()
{
    //return ReturnValue;    
}

function bool SetRankedReadyStatus(bool bReady)
{
    //return ReturnValue;    
}

function bool IsCurrentRoomOwner()
{
    //return ReturnValue;    
}

delegate OnJoinOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddJoinOnlineGameCompleteDelegate(delegate<OnJoinOnlineGameComplete> JoinOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearJoinOnlineGameCompleteDelegate(delegate<OnJoinOnlineGameComplete> JoinOnlineGameCompleteDelegate)
{
    //return;    
}

function bool CreateOnlineGameWithParty(byte ScoutingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings)
{
    //return ReturnValue;    
}

delegate OnCreateOnlineGameWithPartyComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddCreateOnlineGameWithPartyCompleteDelegate(delegate<OnCreateOnlineGameWithPartyComplete> CreateOnlineGameWithPartyCompleteDelegate)
{
    //return;    
}

function ClearCreateOnlineGameWithPartyCompleteDelegate(delegate<OnCreateOnlineGameWithPartyComplete> CreateOnlineGameWithPartyCompleteDelegate)
{
    //return;    
}

function bool MatchmakeOnlineGameWithParty(byte ScoutingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings)
{
    //return ReturnValue;    
}

delegate OnMatchmakeOnlineGameWithPartyComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddMatchmakeOnlineGameWithPartyCompleteDelegate(delegate<OnMatchmakeOnlineGameWithPartyComplete> MatchmakeOnlineGameWithPartyCompleteDelegate)
{
    //return;    
}

function ClearMatchmakeOnlineGameWithPartyCompleteDelegate(delegate<OnMatchmakeOnlineGameWithPartyComplete> MatchmakeOnlineGameWithPartyCompleteDelegate)
{
    //return;    
}

function bool IsHostOfSession(name SessionName)
{
    //return ReturnValue;    
}

function bool InitiatedSessionSearch(name SessionName)
{
    //return ReturnValue;    
}

function bool CreateOnlineSessionWithTemplate(byte ScoutingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings, string TemplateName, string SessionKeyword)
{
    //return ReturnValue;    
}

function bool AddSessionMemberByString(byte ScoutingPlayerNum, name SessionName, string Member)
{
    //return ReturnValue;    
}

function bool AddSessionMember(byte ScoutingPlayerNum, name SessionName, UniqueNetId Member)
{
    //return ReturnValue;    
}

function bool AddSessionMembers(byte ScoutingPlayerNum, name SessionName, array<UniqueNetId> Members)
{
    //return ReturnValue;    
}

delegate OnAddSessionMemberComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddAddSessionMemberCompleteDelegate(delegate<OnAddSessionMemberComplete> AddSessionMemberCompleteDelegate)
{
    //return;    
}

function ClearAddSessionMemberCompleteDelegate(delegate<OnAddSessionMemberComplete> AddSessionMemberCompleteDelegate)
{
    //return;    
}

delegate OnMultiplayerSessionChange(name SessionName, SessionUpdateInfo SessionChanges)
{
    //return;    
}

function AddMultiplayerSessionChangeDelegate(delegate<OnMultiplayerSessionChange> MultiplayerSessionChangeDelegate)
{
    //return;    
}

function ClearMultiplayerSessionChangeDelegate(delegate<OnMultiplayerSessionChange> MultiplayerSessionChangeDelegate)
{
    //return;    
}

function bool SetCustomSessionProperty(name SessionName, string PropertyName, string PropertyValue)
{
    //return ReturnValue;    
}

function bool DeleteCustomSessionProperty(name SessionName, string PropertyName)
{
    //return ReturnValue;    
}

function bool SetCustomMemberProperty(name SessionName, string PropertyName, string PropertyValue)
{
    //return ReturnValue;    
}

function bool DeleteCustomMemberProperty(name SessionName, string PropertyName)
{
    //return ReturnValue;    
}

function bool UpdateSessionProperties(byte ScoutingUserNum, name SessionName)
{
    //return ReturnValue;    
}

delegate OnUpdateSessionPropertiesComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddUpdateSessionPropertiesCompleteDelegate(delegate<OnUpdateSessionPropertiesComplete> UpdateSessionPropertiesCompleteDelegate)
{
    //return;    
}

function ClearUpdateSessionPropertiesCompleteDelegate(delegate<OnUpdateSessionPropertiesComplete> UpdateSessionPropertiesCompleteDelegate)
{
    //return;    
}

delegate OnGameSessionReady(name SessionName)
{
    //return;    
}

function AddGameSessionReadyDelegate(delegate<OnGameSessionReady> GameSessionReadyDelegate)
{
    //return;    
}

function ClearGameSessionReadyDelegate(delegate<OnGameSessionReady> GameSessionReadyDelegate)
{
    //return;    
}

function AcceptPendingGameSession(name SessionName)
{
    //return;    
}

delegate OnAcceptPendingGameSessionComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddAcceptPendingGameSessionCompleteDelegate(delegate<OnAcceptPendingGameSessionComplete> AcceptPendingGameSessionCompleteDelegate)
{
    //return;    
}

function ClearAcceptPendingGameSessionCompleteDelegate(delegate<OnAcceptPendingGameSessionComplete> AcceptPendingGameSessionCompleteDelegate)
{
    //return;    
}

delegate OnGamePlayersChanged(name SessionName, array<UniqueNetId> Players)
{
    //return;    
}

function AddGamePlayersChangedDelegate(delegate<OnGamePlayersChanged> GamePlayersChangedDelegate)
{
    //return;    
}

function ClearGamePlayersChangedDelegate(delegate<OnGamePlayersChanged> GamePlayersChangedDelegate)
{
    //return;    
}

delegate OnMatchStatusChanged(name SessionName, byte Status)
{
    //return;    
}

function AddMatchStatusChangedDelegate(delegate<OnMatchStatusChanged> MatchStatusChangedDelegate)
{
    //return;    
}

function ClearMatchStatusChangedDelegate(delegate<OnMatchStatusChanged> MatchStatusChangedDelegate)
{
    //return;    
}

function bool LeaveOnlineSession(byte LocalPlayerNum, name SessionName, optional bool bClearSessionIfHost = false)
{
    //return ReturnValue;    
}

function LeaveAllOnlineSessions(optional bool bClearSessionIfHost = false)
{
    //return;    
}

function bool QuerySessionsForUser(byte LocalPlayerNum)
{
    //return ReturnValue;    
}

function bool QuerySessionsByKeyword(byte LocalPlayerNum, string Keyword, OnlineGameSearch SearchSettings)
{
    //return ReturnValue;    
}

delegate OnQuerySessionsForUserComplete(byte LocalPlayerNum, bool bWasSuccessful)
{
    //return;    
}

function AddQuerySessionsForUserCompleteDelegate(delegate<OnQuerySessionsForUserComplete> QuerySessionsForUserCompleteDelegate)
{
    //return;    
}

function ClearQuerySessionsForUserCompleteDelegate(delegate<OnQuerySessionsForUserComplete> QuerySessionsForUserCompleteDelegate)
{
    //return;    
}

function bool GetResolvedConnectString(name SessionName, out string ConnectInfo)
{
    //return ReturnValue;    
}

function bool RegisterPlayer(name SessionName, UniqueNetId PlayerID, bool bWasInvited)
{
    //return ReturnValue;    
}

function bool RegisterPlayers(name SessionName, const out array<UniqueNetId> Players)
{
    //return ReturnValue;    
}

delegate OnRegisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful)
{
    //return;    
}

function AddRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate)
{
    //return;    
}

function ClearRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate)
{
    //return;    
}

function bool UnregisterPlayer(name SessionName, UniqueNetId PlayerID)
{
    //return ReturnValue;    
}

function bool UnregisterPlayers(name SessionName, const out array<UniqueNetId> Players)
{
    //return ReturnValue;    
}

delegate OnUnregisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful)
{
    //return;    
}

function AddUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate)
{
    //return;    
}

function ClearUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate)
{
    //return;    
}

function bool StartOnlineGame(name SessionName)
{
    //return ReturnValue;    
}

delegate OnStartOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddStartOnlineGameCompleteDelegate(delegate<OnStartOnlineGameComplete> StartOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearStartOnlineGameCompleteDelegate(delegate<OnStartOnlineGameComplete> StartOnlineGameCompleteDelegate)
{
    //return;    
}

function bool EndOnlineGame(name SessionName)
{
    //return ReturnValue;    
}

delegate OnEndOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddEndOnlineGameCompleteDelegate(delegate<OnEndOnlineGameComplete> EndOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearEndOnlineGameCompleteDelegate(delegate<OnEndOnlineGameComplete> EndOnlineGameCompleteDelegate)
{
    //return;    
}

function bool RegisterForArbitration(name SessionName)
{
    //return ReturnValue;    
}

delegate OnArbitrationRegistrationComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddArbitrationRegistrationCompleteDelegate(delegate<OnArbitrationRegistrationComplete> ArbitrationRegistrationCompleteDelegate)
{
    //return;    
}

function ClearArbitrationRegistrationCompleteDelegate(delegate<OnArbitrationRegistrationComplete> ArbitrationRegistrationCompleteDelegate)
{
    //return;    
}

function array<OnlineArbitrationRegistrant> GetArbitratedPlayers(name SessionName)
{
    //return ReturnValue;    
}

delegate OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult)
{
    //return;    
}

function AddGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate)
{
    //return;    
}

function ClearGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate)
{
    //return;    
}

function bool AcceptGameInvite(byte LocalUserNum, name SessionName)
{
    //return ReturnValue;    
}

function bool RecalculateSkillRating(name SessionName, const out array<UniqueNetId> Players)
{
    //return ReturnValue;    
}

delegate OnRecalculateSkillRatingComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddRecalculateSkillRatingCompleteDelegate(delegate<OnRecalculateSkillRatingComplete> RecalculateSkillRatingCompleteDelegate)
{
    //return;    
}

function ClearRecalculateSkillRatingCompleteDelegate(delegate<OnRecalculateSkillRatingComplete> RecalculateSkillRatingGameCompleteDelegate)
{
    //return;    
}

function bool MigrateOnlineGame(byte HostingPlayerNum, name SessionName)
{
    //return ReturnValue;    
}

delegate OnMigrateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddMigrateOnlineGameCompleteDelegate(delegate<OnMigrateOnlineGameComplete> MigrateOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearMigrateOnlineGameCompleteDelegate(delegate<OnMigrateOnlineGameComplete> MigrateOnlineGameCompleteDelegate)
{
    //return;    
}

function bool JoinMigratedOnlineGame(byte PlayerNum, name SessionName, const out OnlineGameSearchResult DesiredGame)
{
    //return ReturnValue;    
}

delegate OnJoinMigratedOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddJoinMigratedOnlineGameCompleteDelegate(delegate<OnJoinMigratedOnlineGameComplete> JoinMigratedOnlineGameCompleteDelegate)
{
    //return;    
}

function ClearJoinMigratedOnlineGameCompleteDelegate(delegate<OnJoinMigratedOnlineGameComplete> JoinMigratedOnlineGameCompleteDelegate)
{
    //return;    
}

function bool GetNumberOfCurrentPlayers()
{
    //return ReturnValue;    
}

delegate OnRetrievedGameSettingsForIP(bool bSuccessful, const out OnlineGameSearchResult ConnectResult)
{
    //return;    
}

function AddOnRetrieveGameSettingsForIPDelegate(delegate<OnRetrievedGameSettingsForIP> NewRetrieveIPDelegate)
{
    //return;    
}

function ClearOnRetrieveGameSettingsForIPDelegate(delegate<OnRetrievedGameSettingsForIP> RetrieveIPDelegate)
{
    //return;    
}

function RetrieveGameSettingsForIP(string IPAddress)
{
    //return;    
}

function bool SendPlayerList(const array<PlayerReplicationInfo> Players)
{
    //return ReturnValue;    
}

function int GetNumberOfCurrentPlayersCached()
{
    //return ReturnValue;    
}

delegate OnGetNumberOfCurrentPlayersComplete(int TotalPlayers)
{
    //return;    
}

function AddGetNumberOfCurrentPlayersCompleteDelegate(delegate<OnGetNumberOfCurrentPlayersComplete> GetNumberOfCurrentPlayersCompleteDelegate)
{
    //return;    
}

function ClearGetNumberOfCurrentPlayersCompleteDelegate(delegate<OnGetNumberOfCurrentPlayersComplete> GetNumberOfCurrentPlayersCompleteDelegate)
{
    //return;    
}

function string GetRoomId()
{
    //return ReturnValue;    
}

delegate OnGetRoomIdFromTitleService(QWord RoomId)
{
    //return;    
}

function GetRoomIdFromTitleService(QWord DataId)
{
    //return;    
}

function GetRoomIdFromSessionId(string SessionId)
{
    //return;    
}

function AddGetRoomIdFromTitleServiceDelegate(delegate<OnGetRoomIdFromTitleService> InDelegate)
{
    //return;    
}

function ClearGetRoomIdFromTitleServiceDelegate(delegate<OnGetRoomIdFromTitleService> InDelegate)
{
    //return;    
}

function bool IsAllowedToNetworkHost()
{
    //return ReturnValue;    
}

function RunBandwidthTest()
{
    //return;    
}

function bool GetCurrentSessionMemberInfoAsync(byte LocalUserNum, name SessionName)
{
    //return ReturnValue;    
}

function bool GetCurrentSessionMemberInfo(name SessionName, out array<SessionMemberInfo> OutMemberInfo)
{
    //return ReturnValue;    
}

delegate OnGetSessionMemberInfoComplete(array<SessionMemberInfo> OutMemberInfo, bool bWasSuccessful)
{
    //return;    
}

function AddGetSessionMemberInfoCompleteDelegate(delegate<OnGetSessionMemberInfoComplete> GetSessionMemberInfoCompleteDelegate)
{
    //return;    
}

function ClearGetSessionMemberInfoCompleteDelegate(delegate<OnGetSessionMemberInfoComplete> GetSessionMemberInfoCompleteDelegate)
{
    //return;    
}

function bool GetUserConnectionInfoAsync(array<string> UserNames)
{
    //return ReturnValue;    
}

delegate OnGetUserConnectionInfoComplete(array<SessionMemberInfo> OutMemberInfo, bool bWasSuccessful)
{
    //return;    
}

function AddGetUserConnectionInfoCompleteDelegate(delegate<OnGetUserConnectionInfoComplete> GetGetUserConnectionInfoCompleteDelegate)
{
    //return;    
}

function ClearGetUserConnectionInfoCompleteDelegate(delegate<OnGetUserConnectionInfoComplete> GetGetUserConnectionInfoCompleteDelegate)
{
    //return;    
}
