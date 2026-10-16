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

// Export UPComPlayerController::execClientAddCheats(FFrame&, void* const)
native function ClientAddCheats();

simulated function AddCheats()
{
    ClientAddCheats();
    //return;    
}

exec function TestVideoPlayer()
{
    Class'PlatformCommon.PComVideoPlayer'.static.TestVideoPlayer(self);
    //return;    
}

// Export UPComPlayerController::execDumpConfig(FFrame&, void* const)
native exec function DumpConfig();

// Export UPComPlayerController::execGetConfig(FFrame&, void* const)
native exec function string GetConfig(string Key);

// Export UPComPlayerController::execGetConfigInt(FFrame&, void* const)
native exec function int GetConfigInt(string Key);

// Export UPComPlayerController::execGetConfigBool(FFrame&, void* const)
native exec function bool GetConfigBool(string Key);

// Export UPComPlayerController::execSetConfig(FFrame&, void* const)
native exec function SetConfig(string Key, string Value);

// Export UPComPlayerController::execTeamInvite(FFrame&, void* const)
native exec function TeamInvite(string fsName);

// Export UPComPlayerController::execTeamAccept(FFrame&, void* const)
native exec function TeamAccept(bool bAccepted);

// Export UPComPlayerController::execTeamLeave(FFrame&, void* const)
native exec function TeamLeave();

// Export UPComPlayerController::execTeamSetLeader(FFrame&, void* const)
native exec function TeamSetLeader(string fsLeader);

// Export UPComPlayerController::execChallengeCreate(FFrame&, void* const)
native exec function ChallengeCreate(int nQueue, string fsName, optional string fsPassword);

// Export UPComPlayerController::execChallengeJoin(FFrame&, void* const)
native exec function ChallengeJoin(int nQueue, string fsName, optional string fsPassword);

// Export UPComPlayerController::execPlayerRetrievedOSSInventory(FFrame&, void* const)
native function PlayerRetrievedOSSInventory(out array<MarketplaceInventoryItem> Items);

// Export UPComPlayerController::execSendPlayerDLCLicensesToServer(FFrame&, void* const)
native function SendPlayerDLCLicensesToServer();

// Export UPComPlayerController::execPlayerReceivedURLTokenAndSignature(FFrame&, void* const)
native function PlayerReceivedURLTokenAndSignature(byte LocalUserNum, string URL, string Token, string Signature);

event RefreshStoreData()
{
    local byte MediaType;

    // End:0x20B
    if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        OnlineSub.MarketplaceInterface.AddReadAvailableProductsCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnReadAvailableProductsComplete);
        OnlineSub.MarketplaceInterface.AddReadAdditionalProductDetailsCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnReadAdditionalProductDetailsComplete);
        MediaType = 1;
        J0x11F:

        // End:0x1A6 [Loop If]
        if(int(MediaType) < 6)
        {
            OnlineSub.MarketplaceInterface.ResetAvailableProducts(byte(LocalPlayer(Player).ControllerId), MediaType);
            MediaType++;
            // [Loop Continue]
            goto J0x11F;
        }
        OnlineSub.MarketplaceInterface.ReadAvailableProducts(byte(LocalPlayer(Player).ControllerId), "", 1, 1);
    }
    //return;    
}

function OnReadAvailableProductsComplete(OnlineSubsystem.EMediaItemType MediaType)
{
    // End:0x9C
    if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        OnlineSub.MarketplaceInterface.ReadAdditionalDetailsForProducts(byte(LocalPlayer(Player).ControllerId), MediaType);
    }
    //return;    
}

function OnReadAdditionalProductDetailsComplete(OnlineSubsystem.EMediaItemType MediaType)
{
    local byte NextMediaType;

    NextMediaType = MediaType;
    NextMediaType++;
    // End:0x1BC
    if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        // End:0x150
        if(int(NextMediaType) == 6)
        {
            OnlineSub.MarketplaceInterface.ClearReadAvailableProductsCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnReadAvailableProductsComplete);
            OnlineSub.MarketplaceInterface.ClearReadAdditionalProductDetailsCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnReadAdditionalProductDetailsComplete);
            OnAllMarketplaceProductDetailsRead();            
        }
        else
        {
            OnlineSub.MarketplaceInterface.ReadAvailableProducts(byte(LocalPlayer(Player).ControllerId), "", 1, NextMediaType);
        }
    }
    //return;    
}

exec function DumpGameProducts()
{
    DumpStoreCatalog(1);
    //return;    
}

exec function DumpDurables()
{
    DumpStoreCatalog(3);
    //return;    
}

exec function DumpConumables()
{
    DumpStoreCatalog(4);
    //return;    
}

exec function DumpStoreCatalog(OnlineSubsystem.EMediaItemType MediaType)
{
    local int I, J, K;
    local array<MarketplaceProductDetails> AvailableProducts;

    OnlineSub.MarketplaceInterface.GetAvailableProducts(byte(LocalPlayer(Player).ControllerId), MediaType, AvailableProducts);
    I = 0;
    J0x7B:

    // End:0x213 [Loop If]
    if(I < AvailableProducts.Length)
    {
        J = 0;
        J0x9E:

        // End:0x14C [Loop If]
        if(J < AvailableProducts[I].Images.Length)
        {
            K = 0;
            J0xDE:

            // End:0x13E [Loop If]
            if(K < AvailableProducts[I].Images[J].Purposes.Length)
            {
                K++;
                // [Loop Continue]
                goto J0xDE;
            }
            J++;
            // [Loop Continue]
            goto J0x9E;
        }
        J = 0;
        J0x157:

        // End:0x205 [Loop If]
        if(J < AvailableProducts[I].Availabilities.Length)
        {
            K = 0;
            J0x197:

            // End:0x1F7 [Loop If]
            if(K < AvailableProducts[I].Availabilities[J].AcceptablePaymentInstrumentTypes.Length)
            {
                K++;
                // [Loop Continue]
                goto J0x197;
            }
            J++;
            // [Loop Continue]
            goto J0x157;
        }
        I++;
        // [Loop Continue]
        goto J0x7B;
    }
    //return;    
}

event GetOSSTokenAndSignature(string URL)
{
    OnlineSub.PlayerInterface.AddURLTokenRetrievedDelegate(byte(LocalPlayer(Player).ControllerId), PlayerReceivedURLTokenAndSignature);
    OnlineSub.PlayerInterface.GetTokenAndSignatureForURL(byte(LocalPlayer(Player).ControllerId), URL);
    //return;    
}

event GetMarketplaceInventory()
{
    // End:0xF1
    if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        OnlineSub.MarketplaceInterface.ResetInventoryItems(byte(LocalPlayer(Player).ControllerId));
        OnlineSub.MarketplaceInterface.ReadInventoryItems(byte(LocalPlayer(Player).ControllerId));
    }
    //return;    
}

function OnReadPlayerMarketplaceInventoryComplete()
{
    local array<MarketplaceInventoryItem> Items;

    // End:0x9C
    if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
    {
        OnlineSub.MarketplaceInterface.GetInventoryItems(byte(LocalPlayer(Player).ControllerId), Items);
    }
    PlayerRetrievedOSSInventory(Items);
    //return;    
}

event OnlineSubsystem.EOnlineEnumerationReadState GetPlayerDLCLicenses(out array<OnlineContent> ContentList)
{
    return OnlineSub.ContentInterface.GetDownloadableContentList(byte(LocalPlayer(Player).ControllerId), ContentList);
    //return ReturnValue;    
}

simulated function OnMarketplaceItemPurchased()
{
    GetMarketplaceInventory();
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
native simulated function ConnectToPeers(out array<SessionMemberInfo> SessionListInfo);

// Export UPComPlayerController::execAcceptPartyInvite(FFrame&, void* const)
native simulated function AcceptPartyInvite(string InviterName);

// Export UPComPlayerController::execShowPrivilegeMessageAndDeclineInvite(FFrame&, void* const)
native simulated function ShowPrivilegeMessageAndDeclineInvite();

// Export UPComPlayerController::execFilterFriendListForPeoplePicker(FFrame&, void* const)
native simulated function FilterFriendListForPeoplePicker(out array<OnlineFriend> FriendList, out array<SessionMemberInfo> SessionMemberList);

// Export UPComPlayerController::execBlockPartySceneInput(FFrame&, void* const)
native function BlockPartySceneInput(bool bBlockInput);

// Export UPComPlayerController::execUpdateMCTSSession(FFrame&, void* const)
native simulated function UpdateMCTSSession(string SessionGuid, bool bIsHost);

// Export UPComPlayerController::execArePartySessionInvitesAllowed(FFrame&, void* const)
native function bool ArePartySessionInvitesAllowed();

function bool ShouldPartySessionsBePublic()
{
    return true;
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
    super(PlayerController).AcknowledgePossession(P);
    // End:0x9B
    if(int(WorldInfo.NetMode) == int(NM_Client))
    {
        // End:0x6D
        if(WorldInfo.IsConsoleBuild(9))
        {
            TryJoinSession();            
        }
        else
        {
            // End:0x9B
            if(WorldInfo.IsConsoleBuild(8))
            {
                RestablishVoiceForReconnect();
            }
        }
    }
    //return;    
}

simulated event QuitToMainMenu()
{
    m_bQuittingToMainMenu = true;
    // End:0x27
    if((CleanupOnlineSubsystemSession(true)) == false)
    {
        FinishQuitToMainMenu();
    }
    //return;    
}

function bool CleanupOnlineSubsystemSession(bool bWasFromMenu)
{
    // End:0x13D
    if((((int(WorldInfo.NetMode) != int(NM_Standalone)) && OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.GameInterface, OnlineGameInterface(none))) && OnlineSub.GameInterface.GetGameSettings(GameSessionName) != none)
    {
        OnlineSub.GameInterface.AddEndOnlineGameCompleteDelegate(OnEndOnlineGameComplete);
        OnlineSub.GameInterface.EndOnlineGame(GameSessionName);
        return true;
    }
    return false;
    //return ReturnValue;    
}

function FinishQuitToMainMenu()
{
    Class'Engine.Engine'.static.StopMovie(true);    
    ConsoleCommand("Disconnect");
    //return;    
}

function OnEndOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    OnlineSub.GameInterface.ClearEndOnlineGameCompleteDelegate(OnEndOnlineGameComplete);
    // End:0xF0
    if(m_bQuittingToMainMenu)
    {
        OnlineSub.GameInterface.AddDestroyOnlineGameCompleteDelegate(OnDestroyOnlineGameComplete);
        // End:0xF0
        if(!OnlineSub.GameInterface.DestroyOnlineGame(GameSessionName))
        {
            OnDestroyOnlineGameComplete(GameSessionName, true);
        }
    }
    //return;    
}

function OnDestroyOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    OnlineSub.GameInterface.ClearDestroyOnlineGameCompleteDelegate(OnDestroyOnlineGameComplete);
    FinishQuitToMainMenu();
    //return;    
}

exec event ChooseThisControllerForSessionScout(bool bCustomMatch, int MaxPlayers, bool bPrivate, optional out array<UniqueNetId> ReservedMembers)
{
    local OnlineGameSettings NewGameSettings;

    // End:0x26B
    if(!OnlineSub.IsInSession(GameSessionName))
    {
        NewGameSettings = new Class'Engine.OnlineGameSettings';
        NewGameSettings.bAllowInvites = bCustomMatch;
        NewGameSettings.bPublic = bCustomMatch && !bPrivate;
        NewGameSettings.NumPublicConnections = MaxPlayers;
        NewGameSettings.ReservedMembers = ReservedMembers;
        NewGameSettings.SessionTemplateName = OnlineSub.DefaultSessionTemplateName;
        NewGameSettings.OwningPlayerId = PlayerReplicationInfo.ConsoleUniqueId;
        NewGameSettings.OwningPlayerName = PlayerReplicationInfo.PlayerName;
        OnlineSub.GameInterface.AddCreateOnlineGameCompleteDelegate(OnCreateOnlineGameComplete);
        OnlineSub.GameInterface.CreateOnlineGame(byte(LocalPlayer(Player).ControllerId), GameSessionName, NewGameSettings);        
    }
    //return;    
}

simulated function OnCreateOnlineGameComplete(name SessionName, bool bWasSuccessful)
{
    local byte PlatformSpecificInfo[80];
    local WorldInfo.EConsoleType ConsoleType;

    OnlineSub.GameInterface.ClearCreateOnlineGameCompleteDelegate(OnCreateOnlineGameComplete);
    OnlineSub.GameInterface.ReadPlatformSpecificSessionInfoBySessionName(GameSessionName, PlatformSpecificInfo);
    // End:0xC0
    if(WorldInfo.IsConsoleBuild(9))
    {
        ConsoleType = 9;        
    }
    else
    {
        // End:0xF0
        if(WorldInfo.IsConsoleBuild(8))
        {
            ConsoleType = 8;
        }
    }
    // End:0x126
    if(bWasSuccessful && int(ConsoleType) == int(9))
    {
        MCTSSetSessionId(PlatformSpecificInfo);
    }
    //return;    
}

reliable client simulated event ReceiveSessionInfo(byte PlatformSpecificInfo[80], WorldInfo.EConsoleType ConsoleType)
{
    local OnlineGameSearch NewGameSearch;

    NewGameSearch = new Class'Engine.OnlineGameSearch';
    // End:0x18D
    if((!OnlineSub.IsInSession(GameSessionName) && WorldInfo.IsConsoleBuild(ConsoleType)) && OnlineSub.GameInterface.BindPlatformSpecificSessionToSearch(0, NewGameSearch, PlatformSpecificInfo))
    {
        OnlineSub.GameInterface.AddJoinOnlineGameCompleteDelegate(OnJoinOnlineGameCompleteForReceivedSessionInfo);
        OnlineSub.GameInterface.JoinOnlineGame(byte(LocalPlayer(Player).ControllerId), GameSessionName, NewGameSearch.Results[0]);
    }
    //return;    
}

simulated function OnJoinOnlineGameCompleteForReceivedSessionInfo(name SessionName, bool bWasSuccessful)
{
    local OnlineGameSettings GS;

    GS = OnlineSub.GameInterface.GetGameSettings(GameSessionName);
    // End:0xD0
    if(GS != none)
    {
        GS.bAllowInvites = (GS.bPublic && int(WorldInfo.NetMode) == int(NM_Standalone)) && IsInCustomMatch();
    }
    // End:0x143
    if((GS != none) && GS.bPublic)
    {
        OnlineSub.GameInterface.UpdateOnlineGame(GameSessionName, none);
    }
    OnlineSub.GameInterface.ClearJoinOnlineGameCompleteDelegate(OnJoinOnlineGameCompleteForReceivedSessionInfo);
    // End:0x1A3
    if(IsReconnect())
    {
        RestablishVoiceForReconnect();        
    }
    else
    {
        EstablishPeers();
    }
    //return;    
}

simulated event RestablishVoiceForReconnect()
{
    // End:0xD5
    if((int(WorldInfo.NetMode) == int(NM_Client)) || int(WorldInfo.NetMode) == int(NM_Standalone))
    {
        OnlineSub.VoiceInterface.RegisterLocalTalker(byte(LocalPlayer(Player).ControllerId), 0);
        // End:0xD5
        if(IsReconnect())
        {
            ServerReEstablishP2PConnections();
            EstablishPeers();
        }
    }
    //return;    
}

// Export UPComPlayerController::execIsReconnect(FFrame&, void* const)
native simulated function bool IsReconnect();

reliable server function ServerReEstablishP2PConnections()
{
    local PComPlayerController PC;

    // End:0x63
    foreach WorldInfo.AllControllers(Class'PlatformCommon.PComPlayerController', PC)
    {
        // End:0x62
        if(PC != self)
        {
            PC.ClientRestablishP2PConnections();
        }        
    }    
    //return;    
}

reliable client simulated function ClientRestablishP2PConnections()
{
    EstablishPeers();
    //return;    
}

event RegisterOnlineDelegates()
{
    local LocalPlayer LP;
    local int I;

    LP = LocalPlayer(Player);
    super(PlayerController).RegisterOnlineDelegates();
    // End:0x370
    if((OnlineSub != none) && LP != none)
    {
        // End:0x27B
        if((NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none)) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterfaceEx, OnlinePlayerInterfaceEx(none))) && NotEqual_InterfaceInterface(OnlineSub.GameInterface, OnlineGameInterface(none)))
        {
            I = 0;
            J0xF4:

            // End:0x163 [Loop If]
            if(I < 24)
            {
                OnlineSub.PlayerInterface.AddLoginStatusChangeDelegate(OnLoginStatusChange, byte(I));
                I++;
                // [Loop Continue]
                goto J0xF4;
            }
            OnlineSub.SystemInterface.AddConnectionStatusChangeDelegate(OnConnectionStatusChange);
            OnlineSub.PlayerInterface.AddCurrentUserChangedDelegate(OnCurrentUserChanged);
            OnlineSub.PlayerInterfaceEx.AddPlayerTalkingDelegate(OnRemoteTalkerStatusChange);
            OnlineSub.GameInterface.AddMultiplayerSessionChangeDelegate(OnMultiplayerSessionChange);
        }
        // End:0x370
        if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
        {
            OnlineSub.MarketplaceInterface.AddMarketplaceItemPurchasedDelegate(OnMarketplaceItemPurchased);
            I = 0;
            J0x301:

            // End:0x370 [Loop If]
            if(I < 24)
            {
                OnlineSub.MarketplaceInterface.AddReadInventoryItemsCompleteDelegate(byte(I), OnReadPlayerMarketplaceInventoryComplete);
                I++;
                // [Loop Continue]
                goto J0x301;
            }
        }
    }
    //return;    
}

event ClearOnlineDelegates()
{
    local LocalPlayer LP;
    local int I;

    LP = LocalPlayer(Player);
    super(PlayerController).ClearOnlineDelegates();
    // End:0x370
    if((OnlineSub != none) && LP != none)
    {
        // End:0x27B
        if((NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none)) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterfaceEx, OnlinePlayerInterfaceEx(none))) && NotEqual_InterfaceInterface(OnlineSub.GameInterface, OnlineGameInterface(none)))
        {
            I = 0;
            J0xF4:

            // End:0x163 [Loop If]
            if(I < 24)
            {
                OnlineSub.PlayerInterface.ClearLoginStatusChangeDelegate(OnLoginStatusChange, byte(I));
                I++;
                // [Loop Continue]
                goto J0xF4;
            }
            OnlineSub.SystemInterface.ClearConnectionStatusChangeDelegate(OnConnectionStatusChange);
            OnlineSub.PlayerInterface.ClearCurrentUserChangedDelegate(OnCurrentUserChanged);
            OnlineSub.PlayerInterfaceEx.ClearPlayerTalkingDelegate(OnRemoteTalkerStatusChange);
            OnlineSub.GameInterface.ClearMultiplayerSessionChangeDelegate(OnMultiplayerSessionChange);
        }
        // End:0x370
        if(NotEqual_InterfaceInterface(OnlineSub.MarketplaceInterface, OnlineMarketplaceInterface(none)))
        {
            OnlineSub.MarketplaceInterface.ClearMarketplaceItemPurchasedDelegate(OnMarketplaceItemPurchased);
            I = 0;
            J0x301:

            // End:0x370 [Loop If]
            if(I < 24)
            {
                OnlineSub.MarketplaceInterface.ClearReadInventoryItemsCompleteDelegate(byte(I), OnReadPlayerMarketplaceInventoryComplete);
                I++;
                // [Loop Continue]
                goto J0x301;
            }
        }
    }
    //return;    
}

function OnMultiplayerSessionChange(name SessionName, SessionUpdateInfo SessionChanges)
{
    local array<SessionMemberInfo> JoinedMembers;
    local int I;
    local bool bRecreateSession;
    local OnlineGameSettings GS;

    // End:0x1C0
    if(SessionName == GameSessionName)
    {
        OnlineSub.GameInterface.GetCurrentSessionMemberInfo(GameSessionName, JoinedMembers);
        OnlineSub.PlayerInterface.AddPrivilegeCheckedForUsersDelegate(OnGetVoicePermissionsForUsersComplete);
        OnlineSub.PlayerInterface.CanCommunicateVoiceWithUsers(byte(LocalPlayer(Player).ControllerId), JoinedMembers);
        I = 0;
        J0x116:

        // End:0x1BD [Loop If]
        if(I < SessionChanges.MembersLeft.Length)
        {
            OnlineSub.VoiceInterface.UnregisterRemoteTalker(SessionChanges.MembersLeft[I].PlayerNetId);
            I++;
            // [Loop Continue]
            goto J0x116;
        }        
    }
    else
    {
        // End:0x3B5
        if(SessionName == PartySessionName)
        {
            // End:0x391
            if(SessionChanges.bMemberJoinedOrLeft && SessionChanges.MembersLeft.Length > 0)
            {
                OnlineSub.GameInterface.GetCurrentSessionMemberInfo(PartySessionName, JoinedMembers);
                I = JoinedMembers.Length - 1;
                J0x27A:

                // End:0x2DD [Loop If]
                if(I >= 0)
                {
                    // End:0x2CF
                    if(int(JoinedMembers[I].MemberStatus) != int(3))
                    {
                        JoinedMembers.Remove(I, 1);
                    }
                    I--;
                    // [Loop Continue]
                    goto J0x27A;
                }
                GS = OnlineSub.GameInterface.GetGameSettings(PartySessionName);
                // End:0x391
                if((((JoinedMembers.Length <= 1) && GS != none) && IsHostOfParty()) && GS.bPublic != (ShouldPartySessionsBePublic()))
                {
                    bRecreateSession = true;
                }
            }
            // End:0x3AB
            if(bRecreateSession)
            {
                DestroyPartySession();                
            }
            else
            {
                UpdatePartyUI();
            }
        }
    }
    //return;    
}

// Export UPComPlayerController::execIsPackageInstalled(FFrame&, void* const)
native function bool IsPackageInstalled();

// Export UPComPlayerController::execIsInGame(FFrame&, void* const)
native function bool IsInGame();

// Export UPComPlayerController::execLogoutPlayer(FFrame&, void* const)
native function LogoutPlayer();

event PairLoggedInUserAndCurrentController()
{
    local LocalPlayer LP;
    local int LoggedInPlayerIndex;

    LP = LocalPlayer(Player);
    // End:0x134
    if(((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none))) && LP != none)
    {
        OnlineSub.PlayerInterface.GetControllerIdFromNetId(OnlineSub.LoggedInPlayerNetId, LoggedInPlayerIndex);
        OnlineSub.PlayerInterface.PairUserAndControllerAtIndex(byte(LoggedInPlayerIndex), byte(LP.ControllerId), -1);
    }
    //return;    
}

event GetControllerIdFromNetId(UniqueNetId PlayerID, out int ControllerId)
{
    // End:0x8D
    if((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none)))
    {
        OnlineSub.PlayerInterface.GetControllerIdFromNetId(PlayerID, ControllerId);
    }
    //return;    
}

simulated event LostP2PConnection(UniqueNetId UniqueId)
{
    OnlineSub.VoiceInterface.UnregisterRemoteTalker(UniqueId);
    SetTimer(4.0000000, false, 'EstablishPeers');
    //return;    
}

simulated exec event EstablishPeers()
{
    // End:0xAC
    if(WorldInfo.IsConsoleBuild(8))
    {
        OnlineSub.GameInterface.AddGetUserConnectionInfoCompleteDelegate(OnGetUserConnectionInfoComplete);
        OnlineSub.GameInterface.GetUserConnectionInfoAsync(GetUserNamesForPS4P2PConnections());        
    }
    else
    {
        // End:0x17D
        if(WorldInfo.IsConsoleBuild(9))
        {
            OnlineSub.GameInterface.AddGetSessionMemberInfoCompleteDelegate(OnGetSessionMemberInfoComplete);
            OnlineSub.GameInterface.GetCurrentSessionMemberInfoAsync(byte(LocalPlayer(Player).ControllerId), GameSessionName);
        }
    }
    //return;    
}

// Export UPComPlayerController::execCloseConnectionsToInvalidPeers(FFrame&, void* const)
native simulated function CloseConnectionsToInvalidPeers(array<SessionMemberInfo> SessionListInfo);

// Export UPComPlayerController::execGetUserNamesForPS4P2PConnections(FFrame&, void* const)
native simulated function array<string> GetUserNamesForPS4P2PConnections();

simulated function OnGetUserConnectionInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful)
{
    OnlineSub.GameInterface.ClearGetUserConnectionInfoCompleteDelegate(OnGetUserConnectionInfoComplete);
    // End:0x66
    if(bWasSuccessful)
    {
        ConnectToPeers(SessionListInfo);
    }
    CloseConnectionsToInvalidPeers(SessionListInfo);
    //return;    
}

simulated function OnGetSessionMemberInfoComplete(array<SessionMemberInfo> SessionListInfo, bool bWasSuccessful)
{
    OnlineSub.GameInterface.ClearGetSessionMemberInfoCompleteDelegate(OnGetSessionMemberInfoComplete);
    // End:0x100
    if(bWasSuccessful)
    {
        OnlineSub.PlayerInterface.AddPrivilegeCheckedForUsersDelegate(OnGetVoicePermissionsForUsersComplete);
        OnlineSub.PlayerInterface.CanCommunicateVoiceWithUsers(byte(LocalPlayer(Player).ControllerId), SessionListInfo);
    }
    //return;    
}

simulated function OnGetVoicePermissionsForUsersComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, array<PermissionsResult> Results)
{
    local array<SessionMemberInfo> SessionListInfo;
    local int I;

    OnlineSub.PlayerInterface.ClearPrivilegeCheckedForUsersDelegate(OnGetVoicePermissionsForUsersComplete);
    // End:0xFE
    if(int(Privilege) == int(3))
    {
        I = 0;
        J0x65:

        // End:0xEB [Loop If]
        if(I < Results.Length)
        {
            // End:0xDD
            if(Results[I].bHasPermission)
            {
                SessionListInfo.AddItem(Results[I].User);                
            }
            ++I;
            // [Loop Continue]
            goto J0x65;
        }
        ConnectToPeers(SessionListInfo);
    }
    //return;    
}

event UnregisterP2PEnemiesForCustomMatch(array<UniqueNetId> EnemyIds)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x79 [Loop If]
    if(I < EnemyIds.Length)
    {
        OnlineSub.VoiceInterface.UnregisterRemoteTalker(EnemyIds[I]);
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated exec event CreatePartySession()
{
    local OnlineGameSettings NewGameSettings;

    // End:0x27
    if(!WorldInfo.IsConsoleBuild())
    {
        return;
    }
    // End:0x21B
    if(!OnlineSub.IsInSession(PartySessionName))
    {
        NewGameSettings = new Class'Engine.OnlineGameSettings';
        NewGameSettings.bAllowInvites = true;
        NewGameSettings.bPublic = ShouldPartySessionsBePublic();
        NewGameSettings.NumPublicConnections = m_nMaxPartyPublicConnections;
        NewGameSettings.SessionTemplateName = OnlineSub.PartySessionTemplateName;
        NewGameSettings.OwningPlayerId = PlayerReplicationInfo.ConsoleUniqueId;
        OnlineSub.GameInterface.AddCreateOnlineGameCompleteDelegate(OnCreatePartySessionComplete);
        m_bPartySessionCreateInProgress = true;
        OnlineSub.GameInterface.CreateOnlineGame(byte(LocalPlayer(Player).ControllerId), PartySessionName, NewGameSettings);
    }
    //return;    
}

simulated function OnCreatePartySessionComplete(name SessionName, bool bSuccessful)
{
    // End:0x8B
    if(SessionName == PartySessionName)
    {
        OnlineSub.GameInterface.ClearCreateOnlineGameCompleteDelegate(OnCreatePartySessionComplete);
        m_bPartySessionCreateInProgress = false;
        // End:0x8B
        if(bSuccessful)
        {
            TogglePartySessionInvitesAllowed(true);
            UpdateMCTSWithNewPartyInfo();
        }
    }
    //return;    
}

event InvitePlayerToPartyByName(string InPlayerName)
{
    local UniqueNetId IgnoredId;

    // End:0x9D
    if(WorldInfo.IsConsoleBuild(8))
    {
        OnlineSub.PlayerInterface.SendGameInviteToFriend(byte(LocalPlayer(Player).ControllerId), PartySessionName, IgnoredId, InPlayerName);
    }
    //return;    
}

event InvitePlayerToParty(UniqueNetId InPlayerId)
{
    OnlineSub.PlayerInterface.SendGameInviteToFriend(byte(LocalPlayer(Player).ControllerId), PartySessionName, InPlayerId);
    //return;    
}

simulated exec event DestroyPartySession()
{
    m_bPartyDestroyInProgress = true;
    OnlineSub.GameInterface.AddDestroyOnlineGameCompleteDelegate(OnPartySessionDestroyed);
    OnlineSub.GameInterface.DestroyOnlineGame(PartySessionName);
    //return;    
}

simulated function OnPartySessionDestroyed(name SessionName, bool bWasSuccessful)
{
    // End:0xB5
    if(SessionName == PartySessionName)
    {
        m_bPartyDestroyInProgress = false;
        UpdateMCTSWithNewPartyInfo();
        OnlineSub.GameInterface.ClearDestroyOnlineGameCompleteDelegate(OnPartySessionDestroyed);
        // End:0xB5
        if((myHUD != none) && !myHUD.IsInState('Disconnected'))
        {
            CreatePartySession();
        }
    }
    //return;    
}

simulated function OnGameInviteAccepted(const out OnlineGameSearchResult InviteResult)
{
    local bool bPartySession;
    local name SessionName;
    local OnlineGameSettings GS;
    local OnlineSubsystem.EFeaturePrivilegeLevel Hint;
    local int InvitedPlayerControllerId;

    // End:0x76
    if(InviteResult.GameSettings.SessionTemplateName ~= OnlineSub.PartySessionTemplateName)
    {
        bPartySession = true;
        SessionName = PartySessionName;        
    }
    else
    {
        // End:0xDD
        if(InviteResult.GameSettings.SessionTemplateName ~= OnlineSub.DefaultSessionTemplateName)
        {
            SessionName = GameSessionName;
        }
    }
    // End:0x1B7
    if(OnlineSub.IsInSession(SessionName))
    {
        GS = OnlineSub.GameInterface.GetGameSettings(SessionName);
        // End:0x1B7
        if((GS != none) && GS.SessionGuid == InviteResult.GameSettings.SessionGuid)
        {
            return;
        }
    }
    // End:0x1D2
    if(!IsPackageInstalled())
    {
        ShowPackageNotInstalledForPartyInviteWarning();
        return;
    }
    // End:0x21F
    if(InviteResult.GameSettings.NumOpenPublicConnections <= 0)
    {
        ShowPartyFullWarning(bPartySession);
        return;
    }
    m_PendingInviteResult = InviteResult;
    // End:0x2CF
    if(bPartySession)
    {
        m_bPartySessionJoinInProgress = true;
        OnlineSub.GameInterface.AddDestroyOnlineGameCompleteDelegate(OnGameDestroyedForPartyJoin);
        OnlineSub.GameInterface.DestroyOnlineGame(PartySessionName);
    }
    // End:0x40A
    if(InviteResult.GameSettings.SessionTemplateName == "")
    {
        OnlineSub.PlayerInterface.GetControllerIdFromNetId(InviteResult.GameSettings.OwningPlayerId, InvitedPlayerControllerId);
        OnlineSub.PlayerInterface.AddPrivilegeLevelCheckedDelegate(OnAlternatePrivilegeLevelCheckedComplete);
        OnlineSub.PlayerInterface.CanPlayOnline(byte(InvitedPlayerControllerId), Hint);        
    }
    else
    {
        // End:0x523
        if(!bPartySession)
        {
            LeaveMatchQueue();
            OnlineSub.PlayerInterface.GetControllerIdFromNetId(InviteResult.GameSettings.OwningPlayerId, InvitedPlayerControllerId);
            OnlineSub.PlayerInterface.AddPrivilegeLevelCheckedDelegate(OnPrivilegeCheckForGameSessionJoin);
            OnlineSub.PlayerInterface.CanPlayOnline(byte(InvitedPlayerControllerId), Hint);
        }
    }
    //return;    
}

simulated function OnAlternatePrivilegeLevelCheckedComplete(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
{
    OnlineSub.PlayerInterface.ClearPrivilegeLevelCheckedDelegate(OnAlternatePrivilegeLevelCheckedComplete);
    // End:0x89
    if((int(Privilege) == int(0)) && int(PrivilegeLevel) == int(0))
    {
        ShowPrivilegeMessageAndDeclineInvite();
        m_bPartySessionJoinInProgress = false;        
    }
    else
    {
        ShowPartyNoLongerAvailableWarning();
    }
    //return;    
}

simulated function OnGameDestroyedForPartyJoin(name SessionName, bool bWasSuccessful)
{
    local OnlineSubsystem.EFeaturePrivilegeLevel Hint;
    local int InvitedPlayerControllerId;

    // End:0x167
    if(SessionName == PartySessionName)
    {
        UpdateMCTSWithNewPartyInfo();
        OnlineSub.GameInterface.ClearDestroyOnlineGameCompleteDelegate(OnGameDestroyedForPartyJoin);
        OnlineSub.PlayerInterface.GetControllerIdFromNetId(m_PendingInviteResult.GameSettings.OwningPlayerId, InvitedPlayerControllerId);
        OnlineSub.PlayerInterface.AddPrivilegeLevelCheckedDelegate(OnPrivilegeLevelCheckedCompleteForPartyJoin);
        OnlineSub.PlayerInterface.CanPlayOnline(byte(InvitedPlayerControllerId), Hint);
    }
    //return;    
}

simulated function OnPrivilegeLevelCheckedCompleteForPartyJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
{
    local OnlineGameSearchResult EmptyResult;

    OnlineSub.PlayerInterface.ClearPrivilegeLevelCheckedDelegate(OnPrivilegeLevelCheckedCompleteForPartyJoin);
    // End:0x89
    if((int(Privilege) == int(0)) && int(PrivilegeLevel) == int(0))
    {
        ShowPrivilegeMessageAndDeclineInvite();
        m_bPartySessionJoinInProgress = false;        
    }
    else
    {
        OnlineSub.PreLogin();
        OnlineSub.GameInterface.AddJoinOnlineGameCompleteDelegate(OnJoinSessionForReceivedInviteComplete);
        OnlineSub.GameInterface.JoinOnlineGame(LocalUserNum, PartySessionName, m_PendingInviteResult);
        m_PendingInviteResult = EmptyResult;
    }
    //return;    
}

simulated function OnPrivilegeCheckForGameSessionJoin(byte LocalUserNum, OnlineSubsystem.EFeaturePrivilege Privilege, OnlineSubsystem.EFeaturePrivilegeLevel PrivilegeLevel, bool bDiffersFromHint)
{
    local OnlineGameSearchResult EmptyResult;

    OnlineSub.PlayerInterface.ClearPrivilegeLevelCheckedDelegate(OnPrivilegeCheckForGameSessionJoin);
    // End:0x73
    if((int(Privilege) == int(0)) && int(PrivilegeLevel) == int(0))
    {        
    }
    else
    {
        OnlineSub.PreLogin();
        OnlineSub.GameInterface.AddJoinOnlineGameCompleteDelegate(OnJoinSessionForReceivedInviteComplete);
        OnlineSub.GameInterface.JoinOnlineGame(LocalUserNum, GameSessionName, m_PendingInviteResult);
        m_PendingInviteResult = EmptyResult;
    }
    //return;    
}

simulated function OnJoinSessionForReceivedInviteComplete(name SessionName, bool bWasSuccessful)
{
    OnlineSub.GameInterface.ClearJoinOnlineGameCompleteDelegate(OnJoinSessionForReceivedInviteComplete);
    // End:0x14F
    if(bWasSuccessful)
    {
        m_bPartySessionJoinInProgress = false;
        // End:0xE9
        if((myHUD != none) && myHUD.IsInState('Disconnected'))
        {
            // End:0xCD
            if(SessionName == PartySessionName)
            {
                OnlineSub.bCameFromAutoLogin = true;
            }
            // End:0xE6
            if(!TryAutoLogin())
            {
                TryAutoLoginDelayed();
            }            
        }
        else
        {
            // End:0x121
            if(SessionName == PartySessionName)
            {
                UpdateMCTSWithNewPartyInfo();
                TryOpenPartyUI();
                UpdatePartyUI();                
            }
            else
            {
                // End:0x14C
                if(SessionName == GameSessionName)
                {
                    JoinCustomMatchFromInvite();
                    EstablishPeers();
                }
            }
        }        
    }
    else
    {
        m_bPartySessionJoinInProgress = false;
        ShowPartyNoLongerAvailableWarning();
    }
    //return;    
}

event JoinCustomMatchFromInvite()
{
    SetTimer(1.0000000, false, 'JoinCustomMatchForInviteDelay');
    //return;    
}

function JoinCustomMatchForInviteDelay()
{
    local OnlineGameSettings GS;

    GS = OnlineSub.GameInterface.GetGameSettings(GameSessionName);
    // End:0x8A
    if(GS != none)
    {
        ChallengeJoin(0, GS.SessionGuid, "Password");
    }
    //return;    
}

simulated exec event bool ShowPeoplePickerUI()
{
    local byte LocalUserNum;
    local array<SessionMemberInfo> SessionMemberList;
    local int OpenPartySlots;
    local array<OnlineFriend> FriendsList;

    FriendsList.Length = 0;
    // End:0x1C2
    if(WorldInfo.IsConsoleBuild(8))
    {
        OnlineSub.GameInterface.GetCurrentSessionMemberInfo(PartySessionName, SessionMemberList);
        OpenPartySlots = 5 - SessionMemberList.Length;
        OpenPartySlots = Clamp(OpenPartySlots, 0, 4);
        OnlineSub.PlayerInterfaceEx.AddPeoplePickerCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnPeoplePickerComplete);
        OnlineSub.PlayerInterfaceEx.ShowPeoplePickerUI(byte(LocalPlayer(Player).ControllerId), FriendsList, OpenPartySlots, Localize("TgGfxParty", "party_joinquestion", "GFxTranslation"));
        return true;
    }
    // End:0x2CB
    if((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterface, OnlinePlayerInterface(none)))
    {
        LocalUserNum = byte(LocalPlayer(Player).ControllerId);
        OnlineSub.PlayerInterface.AddReadFriendsCompleteDelegate(LocalUserNum, OnReadFriendsListComplete);
        return OnlineSub.PlayerInterface.ReadFriendsList(LocalUserNum);
    }
    return false;
    //return ReturnValue;    
}

function OnReadFriendsListComplete(bool bWasSuccessful)
{
    local array<OnlineFriend> FriendsList;
    local byte LocalUserNum;
    local string PeoplePickerText;
    local int OpenPartySlots;
    local array<SessionMemberInfo> SessionMemberList;

    LocalUserNum = byte(LocalPlayer(Player).ControllerId);
    OnlineSub.PlayerInterface.ClearReadFriendsCompleteDelegate(LocalUserNum, OnReadFriendsListComplete);
    // End:0xA0
    if(!bWasSuccessful)
    {
        ShowUnableToReadFriendsListWarning();
        return;        
    }
    else
    {
        PeoplePickerText = Localize("TgGfxParty", "party_peoplepickertext", "GFxTranslation");
        OnlineSub.PlayerInterface.GetFriendsList(LocalUserNum, FriendsList);
        OnlineSub.GameInterface.GetCurrentSessionMemberInfo(PartySessionName, SessionMemberList);
        FilterFriendListForPeoplePicker(FriendsList, SessionMemberList);
        OpenPartySlots = 5 - SessionMemberList.Length;
        OpenPartySlots = Clamp(OpenPartySlots, 0, 4);
        // End:0x2A3
        if(OpenPartySlots > 0)
        {
            // End:0x299
            if(FriendsList.Length > 0)
            {
                BlockPartySceneInput(true);
                OnlineSub.PlayerInterfaceEx.AddPeoplePickerCompleteDelegate(LocalUserNum, OnPeoplePickerComplete);
                OnlineSub.PlayerInterfaceEx.ShowPeoplePickerUI(LocalUserNum, FriendsList, OpenPartySlots, PeoplePickerText);                
            }
            else
            {
                ShowNoFriendsForPartyInviteWarning();
            }
        }
    }
    //return;    
}

function OnPeoplePickerComplete(bool bWasSuccessful, array<OnlineFriend> PeoplePicked)
{
    local int I;
    local UniqueNetId ZeroId;

    // End:0x148
    if((OnlineSub != none) && NotEqual_InterfaceInterface(OnlineSub.PlayerInterfaceEx, OnlinePlayerInterfaceEx(none)))
    {
        OnlineSub.PlayerInterfaceEx.ClearPeoplePickerCompleteDelegate(byte(LocalPlayer(Player).ControllerId), OnPeoplePickerComplete);
        m_LastPendingPartyInviteId = ZeroId;
        // End:0x148
        if(bWasSuccessful && PeoplePicked.Length > 0)
        {
            I = 0;
            J0xF2:

            // End:0x148 [Loop If]
            if(I < PeoplePicked.Length)
            {
                InvitePlayerToParty(PeoplePicked[I].UniqueId);
                I++;
                // [Loop Continue]
                goto J0xF2;
            }
        }
    }
    //return;    
}

simulated event bool IsHostOfParty()
{
    return OnlineSub.GameInterface.IsHostOfSession(PartySessionName);
    //return ReturnValue;    
}

simulated event UpdateMCTSWithNewPartyInfo()
{
    local OnlineGameSettings GS;
    local bool bIsHost;
    local string SessionGuid;

    GS = OnlineSub.GameInterface.GetGameSettings(PartySessionName);
    // End:0x94
    if(GS != none)
    {
        SessionGuid = GS.SessionGuid;
        bIsHost = IsHostOfParty();
    }
    UpdateMCTSSession(SessionGuid, bIsHost);
    //return;    
}

simulated event TogglePartySessionInvitesAllowed(bool bAllowed)
{
    local OnlineGameSettings GS;
    local bool bInCustomQueue;

    GS = OnlineSub.GameInterface.GetGameSettings(GameSessionName);
    // End:0x87
    if((GS != none) && GS.bAllowInvites)
    {
        bInCustomQueue = true;
    }
    GS = OnlineSub.GameInterface.GetGameSettings(PartySessionName);
    // End:0x1A9
    if((((!bInCustomQueue && GS != none) && IsHostOfParty()) && !m_bPartySessionCreateInProgress) && GS.bAllowInvites != bAllowed)
    {
        GS.bAllowInvites = bAllowed;
        OnlineSub.GameInterface.UpdateOnlineGame(PartySessionName, none);
    }
    //return;    
}

simulated event ToggleGameSessionInvitesAllowed(bool bAllowed)
{
    local OnlineGameSettings GS;

    GS = OnlineSub.GameInterface.GetGameSettings(GameSessionName);
    // End:0x188
    if(((GS != none) && GS.bAllowInvites != bAllowed) && GS.bPublic || OnlineSub.GameInterface.IsHostOfSession(GameSessionName))
    {
        GS.bAllowInvites = bAllowed;
        // End:0x148
        if(!bAllowed)
        {
            GS.bPublic = false;
        }
        OnlineSub.GameInterface.UpdateOnlineGame(GameSessionName, none);
    }
    //return;    
}

simulated event SetAsNewPartyHost()
{
    local OnlineGameSettings GS;

    GS = OnlineSub.GameInterface.GetGameSettings(PartySessionName);
    // End:0x10F
    if((GS != none) && !m_bPartySessionCreateInProgress)
    {
        GS.OwningPlayerId = PlayerReplicationInfo.ConsoleUniqueId;
        GS.bAllowInvites = ArePartySessionInvitesAllowed();
        OnlineSub.GameInterface.UpdateOnlineGame(PartySessionName, none);
    }
    //return;    
}

event TryAutoLoginDelayed()
{
    SetTimer(0.2000000, false, 'TryAutoLogin');
    //return;    
}

// Export UPComPlayerController::execTryAutoLogin(FFrame&, void* const)
native function bool TryAutoLogin();

reliable client simulated event ClientPlayInputLightingEffect(name InPresetName, optional bool bUseOverrideStartTime = false, optional float OverrideStartTime = 0.0000000)
{
    PlayInputLightingEffect(InPresetName, bUseOverrideStartTime, OverrideStartTime);
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
    ClientPlayInputLightingEffect(InPresetName);
    //return;    
}

defaultproperties
{
    PartySessionName="Party"
    GameSessionName="Game"
    InputClass=Class'PlatformCommon.PComPlayerInput'
    // Reference: CylinderComponent'PlatformCommon.Default__PComPlayerController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GamePlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}