class OnlineGameInterfaceImpl extends Object within OnlineSubsystemCommonImpl
    native
    config(Engine)
    implements(OnlineGameInterface);

var OnlineSubsystemCommonImpl OwningSubsystem;
var const OnlineGameSettings GameSettings;
var const OnlineGameSearch GameSearch;
var array< delegate<OnCreateOnlineGameComplete> > CreateOnlineGameCompleteDelegates;
var array< delegate<OnUpdateOnlineGameComplete> > UpdateOnlineGameCompleteDelegates;
var array< delegate<OnDestroyOnlineGameComplete> > DestroyOnlineGameCompleteDelegates;
var array< delegate<OnJoinOnlineGameComplete> > JoinOnlineGameCompleteDelegates;
var array< delegate<OnMigrateOnlineGameComplete> > MigrateOnlineGameCompleteDelegates;
var array< delegate<OnJoinMigratedOnlineGameComplete> > JoinMigratedOnlineGameCompleteDelegates;
var array< delegate<OnRecalculateSkillRatingComplete> > RecalculateSkillRatingCompleteDelegates;
var array< delegate<OnStartOnlineGameComplete> > StartOnlineGameCompleteDelegates;
var array< delegate<OnEndOnlineGameComplete> > EndOnlineGameCompleteDelegates;
var array< delegate<OnFindOnlineGamesComplete> > FindOnlineGamesCompleteDelegates;
var array< delegate<OnCancelFindOnlineGamesComplete> > CancelFindOnlineGamesCompleteDelegates;
var const OnlineSubsystem.ELanBeaconState LanBeaconState;
var const byte LanNonce[8];
var const config int LanAnnouncePort;
var const config int LanGameUniqueId;
var const config int LanPacketPlatformMask;
var float LanQueryTimeLeft;
var config float LanQueryTimeout;
var native const transient Pointer LanBeacon;
var private native const transient Pointer SessionInfo;
//var delegate<OnFindOnlineGamesComplete> __OnFindOnlineGamesComplete__Delegate;
//var delegate<OnCreateOnlineGameComplete> __OnCreateOnlineGameComplete__Delegate;
//var delegate<OnUpdateOnlineGameComplete> __OnUpdateOnlineGameComplete__Delegate;
//var delegate<OnDestroyOnlineGameComplete> __OnDestroyOnlineGameComplete__Delegate;
//var delegate<OnCancelFindOnlineGamesComplete> __OnCancelFindOnlineGamesComplete__Delegate;
//var delegate<OnJoinOnlineGameComplete> __OnJoinOnlineGameComplete__Delegate;
//var delegate<OnCreateOnlineGameWithPartyComplete> __OnCreateOnlineGameWithPartyComplete__Delegate;
//var delegate<OnMatchmakeOnlineGameWithPartyComplete> __OnMatchmakeOnlineGameWithPartyComplete__Delegate;
//var delegate<OnAddSessionMemberComplete> __OnAddSessionMemberComplete__Delegate;
//var delegate<OnMultiplayerSessionChange> __OnMultiplayerSessionChange__Delegate;
//var delegate<OnUpdateSessionPropertiesComplete> __OnUpdateSessionPropertiesComplete__Delegate;
//var delegate<OnGameSessionReady> __OnGameSessionReady__Delegate;
//var delegate<OnAcceptPendingGameSessionComplete> __OnAcceptPendingGameSessionComplete__Delegate;
//var delegate<OnGamePlayersChanged> __OnGamePlayersChanged__Delegate;
//var delegate<OnMatchStatusChanged> __OnMatchStatusChanged__Delegate;
//var delegate<OnQuerySessionsForUserComplete> __OnQuerySessionsForUserComplete__Delegate;
//var delegate<OnRegisterPlayerComplete> __OnRegisterPlayerComplete__Delegate;
//var delegate<OnUnregisterPlayerComplete> __OnUnregisterPlayerComplete__Delegate;
//var delegate<OnRetrievedGameSettingsForIP> __OnRetrievedGameSettingsForIP__Delegate;
//var delegate<OnStartOnlineGameComplete> __OnStartOnlineGameComplete__Delegate;
//var delegate<OnEndOnlineGameComplete> __OnEndOnlineGameComplete__Delegate;
//var delegate<OnArbitrationRegistrationComplete> __OnArbitrationRegistrationComplete__Delegate;
//var delegate<OnGameInviteAccepted> __OnGameInviteAccepted__Delegate;
//var delegate<OnRecalculateSkillRatingComplete> __OnRecalculateSkillRatingComplete__Delegate;
//var delegate<OnMigrateOnlineGameComplete> __OnMigrateOnlineGameComplete__Delegate;
//var delegate<OnJoinMigratedOnlineGameComplete> __OnJoinMigratedOnlineGameComplete__Delegate;
//var delegate<OnQosStatusChanged> __OnQosStatusChanged__Delegate;
//var delegate<OnGetNumberOfCurrentPlayersComplete> __OnGetNumberOfCurrentPlayersComplete__Delegate;
//var delegate<OnGetRoomIdFromTitleService> __OnGetRoomIdFromTitleService__Delegate;
//var delegate<OnGetSessionMemberInfoComplete> __OnGetSessionMemberInfoComplete__Delegate;
//var delegate<OnGetUserConnectionInfoComplete> __OnGetUserConnectionInfoComplete__Delegate;

delegate OnFindOnlineGamesComplete(bool bWasSuccessful)
{
    //return;    
}

function OnlineGameSettings GetGameSettings(name SessionName)
{
    return GameSettings;
    //return ReturnValue;    
}

function OnlineGameSearch GetGameSearch()
{
    return GameSearch;
    //return ReturnValue;    
}

// Export UOnlineGameInterfaceImpl::execCreateOnlineGame(FFrame&, void* const)
native function bool CreateOnlineGame(byte HostingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings);

delegate OnCreateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddCreateOnlineGameCompleteDelegate(delegate<OnCreateOnlineGameComplete> CreateOnlineGameCompleteDelegate)
{
    // End:0x3E
    if(CreateOnlineGameCompleteDelegates.Find(CreateOnlineGameCompleteDelegate) == -1)
    {
        CreateOnlineGameCompleteDelegates[CreateOnlineGameCompleteDelegates.Length] = CreateOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearCreateOnlineGameCompleteDelegate(delegate<OnCreateOnlineGameComplete> CreateOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = CreateOnlineGameCompleteDelegates.Find(CreateOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        CreateOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
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
    // End:0x3E
    if(UpdateOnlineGameCompleteDelegates.Find(UpdateOnlineGameCompleteDelegate) == -1)
    {
        UpdateOnlineGameCompleteDelegates[UpdateOnlineGameCompleteDelegates.Length] = UpdateOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearUpdateOnlineGameCompleteDelegate(delegate<OnUpdateOnlineGameComplete> UpdateOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = UpdateOnlineGameCompleteDelegates.Find(UpdateOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        UpdateOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceImpl::execDestroyOnlineGame(FFrame&, void* const)
native function bool DestroyOnlineGame(name SessionName);

delegate OnDestroyOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddDestroyOnlineGameCompleteDelegate(delegate<OnDestroyOnlineGameComplete> DestroyOnlineGameCompleteDelegate)
{
    // End:0x3E
    if(DestroyOnlineGameCompleteDelegates.Find(DestroyOnlineGameCompleteDelegate) == -1)
    {
        DestroyOnlineGameCompleteDelegates[DestroyOnlineGameCompleteDelegates.Length] = DestroyOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearDestroyOnlineGameCompleteDelegate(delegate<OnDestroyOnlineGameComplete> DestroyOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = DestroyOnlineGameCompleteDelegates.Find(DestroyOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        DestroyOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceImpl::execFindOnlineGames(FFrame&, void* const)
native function bool FindOnlineGames(byte SearchingPlayerNum, OnlineGameSearch SearchSettings);

function AddFindOnlineGamesCompleteDelegate(delegate<OnFindOnlineGamesComplete> FindOnlineGamesCompleteDelegate)
{
    // End:0x3E
    if(FindOnlineGamesCompleteDelegates.Find(FindOnlineGamesCompleteDelegate) == -1)
    {
        FindOnlineGamesCompleteDelegates[FindOnlineGamesCompleteDelegates.Length] = FindOnlineGamesCompleteDelegate;
    }
    //return;    
}

function ClearFindOnlineGamesCompleteDelegate(delegate<OnFindOnlineGamesComplete> FindOnlineGamesCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = FindOnlineGamesCompleteDelegates.Find(FindOnlineGamesCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        FindOnlineGamesCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceImpl::execCancelFindOnlineGames(FFrame&, void* const)
native function bool CancelFindOnlineGames();

delegate OnCancelFindOnlineGamesComplete(bool bWasSuccessful)
{
    //return;    
}

function AddCancelFindOnlineGamesCompleteDelegate(delegate<OnCancelFindOnlineGamesComplete> CancelFindOnlineGamesCompleteDelegate)
{
    // End:0x3E
    if(CancelFindOnlineGamesCompleteDelegates.Find(CancelFindOnlineGamesCompleteDelegate) == -1)
    {
        CancelFindOnlineGamesCompleteDelegates[CancelFindOnlineGamesCompleteDelegates.Length] = CancelFindOnlineGamesCompleteDelegate;
    }
    //return;    
}

function ClearCancelFindOnlineGamesCompleteDelegate(delegate<OnCancelFindOnlineGamesComplete> CancelFindOnlineGamesCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = CancelFindOnlineGamesCompleteDelegates.Find(CancelFindOnlineGamesCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        CancelFindOnlineGamesCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceImpl::execFreeSearchResults(FFrame&, void* const)
native function bool FreeSearchResults(OnlineGameSearch Search);

// Export UOnlineGameInterfaceImpl::execJoinOnlineGame(FFrame&, void* const)
native function bool JoinOnlineGame(byte PlayerNum, name SessionName, const out OnlineGameSearchResult DesiredGame);

function bool JoinOnlineGameBySessionHandle(byte PlayerNum, name SessionName, const string InSessionGuid)
{
    //return ReturnValue;    
}

// Export UOnlineGameInterfaceImpl::execOnMapChangePending(FFrame&, void* const)
native function OnMapChangePending();

// Export UOnlineGameInterfaceImpl::execOnMapChangeComplete(FFrame&, void* const)
native function OnMapChangeComplete();

function bool JoinOnlineGameByMatchingParams(QWord RoomId, out OnlineGameSettings JoinedGameSettings)
{
    //return ReturnValue;    
}

function bool IsJoinOperationInProgress()
{
    return false;
    //return ReturnValue;    
}

function bool SetRankedReadyStatus(bool bReady)
{
    //return ReturnValue;    
}

function bool IsCurrentRoomOwner()
{
    return false;
    //return ReturnValue;    
}

delegate OnJoinOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddJoinOnlineGameCompleteDelegate(delegate<OnJoinOnlineGameComplete> JoinOnlineGameCompleteDelegate)
{
    // End:0x3E
    if(JoinOnlineGameCompleteDelegates.Find(JoinOnlineGameCompleteDelegate) == -1)
    {
        JoinOnlineGameCompleteDelegates[JoinOnlineGameCompleteDelegates.Length] = JoinOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearJoinOnlineGameCompleteDelegate(delegate<OnJoinOnlineGameComplete> JoinOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = JoinOnlineGameCompleteDelegates.Find(JoinOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        JoinOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

function bool CreateOnlineGameWithParty(byte ScoutingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings)
{
    return false;
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
    return false;
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
    return false;
    //return ReturnValue;    
}

function bool InitiatedSessionSearch(name SessionName)
{
    return false;
    //return ReturnValue;    
}

function bool CreateOnlineSessionWithTemplate(byte ScoutingPlayerNum, name SessionName, OnlineGameSettings NewGameSettings, string TemplateName, string SessionKeyword)
{
    return false;
    //return ReturnValue;    
}

function bool AddSessionMemberByString(byte ScoutingPlayerNum, name SessionName, string Member)
{
    return false;
    //return ReturnValue;    
}

function bool AddSessionMember(byte ScoutingPlayerNum, name SessionName, UniqueNetId Member)
{
    return false;
    //return ReturnValue;    
}

function bool AddSessionMembers(byte ScoutingPlayerNum, name SessionName, array<UniqueNetId> Members)
{
    return false;
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
    return false;
    //return ReturnValue;    
}

function LeaveAllOnlineSessions(optional bool bClearSessionIfHost = false)
{
    //return;    
}

function bool QuerySessionsForUser(byte LocalPlayerNum)
{
    return false;
    //return ReturnValue;    
}

function bool QuerySessionsByKeyword(byte LocalPlayerNum, string Keyword, OnlineGameSearch SearchSettings)
{
    return false;
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

// Export UOnlineGameInterfaceImpl::execGetResolvedConnectString(FFrame&, void* const)
native function bool GetResolvedConnectString(name SessionName, out string ConnectInfo);

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

// Export UOnlineGameInterfaceImpl::execStartOnlineGame(FFrame&, void* const)
native function bool StartOnlineGame(name SessionName);

delegate OnStartOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddStartOnlineGameCompleteDelegate(delegate<OnStartOnlineGameComplete> StartOnlineGameCompleteDelegate)
{
    // End:0x3E
    if(StartOnlineGameCompleteDelegates.Find(StartOnlineGameCompleteDelegate) == -1)
    {
        StartOnlineGameCompleteDelegates[StartOnlineGameCompleteDelegates.Length] = StartOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearStartOnlineGameCompleteDelegate(delegate<OnStartOnlineGameComplete> StartOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = StartOnlineGameCompleteDelegates.Find(StartOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        StartOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceImpl::execEndOnlineGame(FFrame&, void* const)
native function bool EndOnlineGame(name SessionName);

delegate OnEndOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    //return;    
}

function AddEndOnlineGameCompleteDelegate(delegate<OnEndOnlineGameComplete> EndOnlineGameCompleteDelegate)
{
    // End:0x3E
    if(EndOnlineGameCompleteDelegates.Find(EndOnlineGameCompleteDelegate) == -1)
    {
        EndOnlineGameCompleteDelegates[EndOnlineGameCompleteDelegates.Length] = EndOnlineGameCompleteDelegate;
    }
    //return;    
}

function ClearEndOnlineGameCompleteDelegate(delegate<OnEndOnlineGameComplete> EndOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = EndOnlineGameCompleteDelegates.Find(EndOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        EndOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
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
    // End:0x36
    if(MigrateOnlineGameCompleteDelegates.Find(MigrateOnlineGameCompleteDelegate) == -1)
    {
        MigrateOnlineGameCompleteDelegates.AddItem(MigrateOnlineGameCompleteDelegate);
    }
    //return;    
}

function ClearMigrateOnlineGameCompleteDelegate(delegate<OnMigrateOnlineGameComplete> MigrateOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = MigrateOnlineGameCompleteDelegates.Find(MigrateOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        MigrateOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
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
    // End:0x36
    if(JoinMigratedOnlineGameCompleteDelegates.Find(JoinMigratedOnlineGameCompleteDelegate) == -1)
    {
        JoinMigratedOnlineGameCompleteDelegates.AddItem(JoinMigratedOnlineGameCompleteDelegate);
    }
    //return;    
}

function ClearJoinMigratedOnlineGameCompleteDelegate(delegate<OnJoinMigratedOnlineGameComplete> JoinMigratedOnlineGameCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = JoinMigratedOnlineGameCompleteDelegates.Find(JoinMigratedOnlineGameCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        JoinMigratedOnlineGameCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

function bool QueryNonAdvertisedData(int StartAt, int NumberToQuery)
{
    //return ReturnValue;    
}

// Export UOnlineGameInterfaceImpl::execReadPlatformSpecificSessionInfo(FFrame&, void* const)
native function bool ReadPlatformSpecificSessionInfo(const out OnlineGameSearchResult DesiredGame, out byte PlatformSpecificInfo[80]);

// Export UOnlineGameInterfaceImpl::execReadPlatformSpecificSessionInfoBySessionName(FFrame&, void* const)
native function bool ReadPlatformSpecificSessionInfoBySessionName(name SessionName, out byte PlatformSpecificInfo[80]);

// Export UOnlineGameInterfaceImpl::execBindPlatformSpecificSessionToSearch(FFrame&, void* const)
native function bool BindPlatformSpecificSessionToSearch(byte SearchingPlayerNum, OnlineGameSearch SearchSettings, byte PlatformSpecificInfo[80]);

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

function bool GetNumberOfCurrentPlayers()
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

function bool SendPlayerList(const array<PlayerReplicationInfo> Players)
{
    //return ReturnValue;    
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
    return true;
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

function AddGetUserConnectionInfoCompleteDelegate(delegate<OnGetUserConnectionInfoComplete> GetUserConnectionInfoCompleteDelegate)
{
    //return;    
}

function ClearGetUserConnectionInfoCompleteDelegate(delegate<OnGetUserConnectionInfoComplete> GetUserConnectionInfoCompleteDelegate)
{
    //return;    
}

defaultproperties
{
    LanAnnouncePort=14001
    LanQueryTimeout=5.0000000
}