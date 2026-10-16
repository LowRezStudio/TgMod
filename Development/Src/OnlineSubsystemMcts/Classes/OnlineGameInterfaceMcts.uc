class OnlineGameInterfaceMcts extends OnlineGameInterfaceImpl within OnlineSubsystemCommonImpl
    native
    config(Engine);

enum EMctsMatchmakingType {
    SMT_Invalid,  // 0
    SMT_LAN,  // 1
    SMT_Internet,  // 2
};

var MctsOnlineSettings MctsSettings;
var const OnlineVoiceInterfaceMcts MctsVoiceInt;
var array< delegate<OnGameInviteAccepted> > GameInviteAcceptedDelegates;
var private const OnlineGameSearch InviteGameSearch;
var array< delegate<OnRegisterPlayerComplete> > RegisterPlayerCompleteDelegates;
var array< delegate<OnUnregisterPlayerComplete> > UnregisterPlayerCompleteDelegates;

native function bool UpdateOnlineGame(name SessionName, OnlineGameSettings UpdatedGameSettings, optional bool bShouldRefreshOnlineData=false);  // Export UOnlineGameInterfaceMcts::execUpdateOnlineGame(FFrame&, void* const)

function OnlineGameSettings GetGameSettings(name SessionName) { }

function AddGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate) { }

function ClearGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate) { }

delegate OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult);

native function bool AcceptGameInvite(byte LocalUserNum, name SessionName);  // Export UOnlineGameInterfaceMcts::execAcceptGameInvite(FFrame&, void* const)

native function bool RegisterPlayer(name SessionName, UniqueNetId PlayerID, bool bWasInvited);  // Export UOnlineGameInterfaceMcts::execRegisterPlayer(FFrame&, void* const)

delegate OnRegisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful);

function AddRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate) { }

function ClearRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate) { }

native function bool UnregisterPlayer(name SessionName, UniqueNetId PlayerID);  // Export UOnlineGameInterfaceMcts::execUnregisterPlayer(FFrame&, void* const)

delegate OnUnregisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful);

function AddUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate) { }

function ClearUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate) { }

function bool QueryNonAdvertisedData(int StartAt, int NumberToQuery) { }
