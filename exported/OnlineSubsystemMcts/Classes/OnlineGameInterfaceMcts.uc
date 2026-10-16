class OnlineGameInterfaceMcts extends OnlineGameInterfaceImpl within OnlineSubsystemCommonImpl
    native
    config(Engine);

enum EMctsMatchmakingType
{
    SMT_Invalid,                    // 0
    SMT_LAN,                        // 1
    SMT_Internet,                   // 2
    SMT_MAX                         // 3
};

var MctsOnlineSettings MctsSettings;
var const OnlineVoiceInterfaceMcts MctsVoiceInt;
var array< delegate<OnGameInviteAccepted> > GameInviteAcceptedDelegates;
var private const OnlineGameSearch InviteGameSearch;
var array< delegate<OnRegisterPlayerComplete> > RegisterPlayerCompleteDelegates;
var array< delegate<OnUnregisterPlayerComplete> > UnregisterPlayerCompleteDelegates;
//var delegate<OnGameInviteAccepted> __OnGameInviteAccepted__Delegate;
//var delegate<OnRegisterPlayerComplete> __OnRegisterPlayerComplete__Delegate;
//var delegate<OnUnregisterPlayerComplete> __OnUnregisterPlayerComplete__Delegate;

// Export UOnlineGameInterfaceMcts::execUpdateOnlineGame(FFrame&, void* const)
native function bool UpdateOnlineGame(name SessionName, OnlineGameSettings UpdatedGameSettings, optional bool bShouldRefreshOnlineData = false);

function OnlineGameSettings GetGameSettings(name SessionName)
{
    local int SessionIndex;

    // End:0x21
    if(SessionName == 'Game')
    {
        return GameSettings;
    }
    SessionIndex = Outer.Sessions.Find('SessionName', SessionName);
    // End:0xAE
    if(SessionIndex != -1)
    {
        return Outer.Sessions[SessionIndex].GameSettings;
    }
    return none;
    //return ReturnValue;    
}

function AddGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate)
{
    // End:0x3E
    if(GameInviteAcceptedDelegates.Find(GameInviteAcceptedDelegate) == -1)
    {
        GameInviteAcceptedDelegates[GameInviteAcceptedDelegates.Length] = GameInviteAcceptedDelegate;
    }
    //return;    
}

function ClearGameInviteAcceptedDelegate(byte LocalUserNum, delegate<OnGameInviteAccepted> GameInviteAcceptedDelegate)
{
    local int RemoveIndex;

    RemoveIndex = GameInviteAcceptedDelegates.Find(GameInviteAcceptedDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        GameInviteAcceptedDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

delegate OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult)
{
    //return;    
}

// Export UOnlineGameInterfaceMcts::execAcceptGameInvite(FFrame&, void* const)
native function bool AcceptGameInvite(byte LocalUserNum, name SessionName);

// Export UOnlineGameInterfaceMcts::execRegisterPlayer(FFrame&, void* const)
native function bool RegisterPlayer(name SessionName, UniqueNetId PlayerID, bool bWasInvited);

delegate OnRegisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful)
{
    //return;    
}

function AddRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate)
{
    // End:0x3E
    if(RegisterPlayerCompleteDelegates.Find(RegisterPlayerCompleteDelegate) == -1)
    {
        RegisterPlayerCompleteDelegates[RegisterPlayerCompleteDelegates.Length] = RegisterPlayerCompleteDelegate;
    }
    //return;    
}

function ClearRegisterPlayerCompleteDelegate(delegate<OnRegisterPlayerComplete> RegisterPlayerCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = RegisterPlayerCompleteDelegates.Find(RegisterPlayerCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        RegisterPlayerCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

// Export UOnlineGameInterfaceMcts::execUnregisterPlayer(FFrame&, void* const)
native function bool UnregisterPlayer(name SessionName, UniqueNetId PlayerID);

delegate OnUnregisterPlayerComplete(name SessionName, UniqueNetId PlayerID, bool bWasSuccessful)
{
    //return;    
}

function AddUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate)
{
    // End:0x3E
    if(UnregisterPlayerCompleteDelegates.Find(UnregisterPlayerCompleteDelegate) == -1)
    {
        UnregisterPlayerCompleteDelegates[UnregisterPlayerCompleteDelegates.Length] = UnregisterPlayerCompleteDelegate;
    }
    //return;    
}

function ClearUnregisterPlayerCompleteDelegate(delegate<OnUnregisterPlayerComplete> UnregisterPlayerCompleteDelegate)
{
    local int RemoveIndex;

    RemoveIndex = UnregisterPlayerCompleteDelegates.Find(UnregisterPlayerCompleteDelegate);
    // End:0x48
    if(RemoveIndex != -1)
    {
        UnregisterPlayerCompleteDelegates.Remove(RemoveIndex, 1);
    }
    //return;    
}

function bool QueryNonAdvertisedData(int StartAt, int NumberToQuery)
{
    return false;
    //return ReturnValue;    
}
