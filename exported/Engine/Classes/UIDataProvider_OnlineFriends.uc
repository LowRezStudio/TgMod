class UIDataProvider_OnlineFriends extends UIDataProvider_OnlinePlayerDataBase
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

var array<OnlineFriend> FriendsList;
var const localized string NickNameCol;
var const localized string PresenceInfoCol;
var const localized string FriendStateCol;
var const localized string bIsOnlineCol;
var const localized string bIsPlayingCol;
var const localized string bIsPlayingThisGameCol;
var const localized string bIsJoinableCol;
var const localized string bHasVoiceSupportCol;
var const localized string bHaveInvitedCol;
var const localized string bHasInvitedYouCol;
var const localized string OfflineText;
var const localized string OnlineText;
var const localized string AwayText;
var const localized string BusyText;

event OnRegister(LocalPlayer InPlayer)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    super.OnRegister(InPlayer);
    // End:0x1A8
    if(PlayerControllerId != -1)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0x1A8
        if(OnlineSub != none)
        {
            PlayerInterface = OnlineSub.PlayerInterface;
            // End:0x1A8
            if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
            {
                PlayerInterface.AddLoginChangeDelegate(OnLoginChange);
                PlayerInterface.AddReadFriendsCompleteDelegate(byte(PlayerControllerId), OnFriendsReadComplete);
                // End:0x1A8
                if((int(PlayerInterface.GetLoginStatus(byte(PlayerControllerId))) > int(0)) && !PlayerInterface.IsGuestLogin(byte(PlayerControllerId)))
                {
                    PlayerInterface.ReadFriendsList(byte(PlayerControllerId));
                }
            }
        }
    }
    //return;    
}

event OnUnregister()
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xED
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0xED
        if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
        {
            PlayerInterface.ClearReadFriendsCompleteDelegate(byte(PlayerControllerId), OnFriendsReadComplete);
            PlayerInterface.ClearLoginChangeDelegate(OnLoginChange);
        }
    }
    super.OnUnregister();
    //return;    
}

function OnFriendsReadComplete(bool bWasSuccessful)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    // End:0xC9
    if(bWasSuccessful == true)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0xC6
        if(OnlineSub != none)
        {
            PlayerInterface = OnlineSub.PlayerInterface;
            // End:0xC6
            if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
            {
                PlayerInterface.GetFriendsList(byte(PlayerControllerId), FriendsList);
            }
        }        
    }
    //return;    
}

function OnLoginChange(byte LocalUserNum)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    FriendsList.Length = 0;
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x123
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0x123
        if((NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)) && int(PlayerInterface.GetLoginStatus(byte(PlayerControllerId))) > int(0)) && !PlayerInterface.IsGuestLogin(byte(PlayerControllerId)))
        {
            PlayerInterface.ReadFriendsList(byte(PlayerControllerId));
        }
    }
    //return;    
}

event RefreshFriendsList()
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    // End:0x12A
    if(PlayerControllerId != -1)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0x12A
        if(OnlineSub != none)
        {
            PlayerInterface = OnlineSub.PlayerInterface;
            // End:0x12A
            if((NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)) && int(PlayerInterface.GetLoginStatus(byte(PlayerControllerId))) > int(0)) && !PlayerInterface.IsGuestLogin(byte(PlayerControllerId)))
            {
                PlayerInterface.ReadFriendsList(byte(PlayerControllerId));
            }
        }
    }
    //return;    
}

defaultproperties
{
    NickNameCol="Name"
    PresenceInfoCol="Online Status"
    bIsOnlineCol="Is Online"
    bIsPlayingCol="Is Playing"
    bIsPlayingThisGameCol="Is Playing This Game"
    bIsJoinableCol="Is Joinable"
    bHasVoiceSupportCol="Has Voice Support"
    OfflineText="Offline"
    OnlineText="Online"
    AwayText="Away"
    BusyText="Busy"
}