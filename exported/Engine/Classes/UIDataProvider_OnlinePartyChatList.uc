class UIDataProvider_OnlinePartyChatList extends UIDataProvider_OnlinePlayerDataBase
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

var array<OnlinePartyMember> PartyMembersList;
var const localized array<localized string> NatTypes;
var const localized string NickNameCol;
var const localized string NatTypeCol;
var const localized string IsLocalCol;
var const localized string IsInPartyVoiceCol;
var const localized string IsTalkingCol;
var const localized string IsInGameSessionCol;
var const localized string IsPlayingThisGameCol;

event OnRegister(LocalPlayer InPlayer)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    super.OnRegister(InPlayer);
    // End:0xD7
    if(PlayerControllerId != -1)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0xD7
        if(OnlineSub != none)
        {
            PlayerInterface = OnlineSub.PlayerInterface;
            // End:0xD7
            if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
            {
                PlayerInterface.AddLoginChangeDelegate(OnLoginChange);
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
    // End:0xB1
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0xB1
        if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
        {
            PlayerInterface.ClearLoginChangeDelegate(OnLoginChange);
        }
    }
    super.OnUnregister();
    //return;    
}

function OnLoginChange(byte LocalUserNum)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    PartyMembersList.Length = 0;
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xC4
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0xC4
        if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)) && int(PlayerInterface.GetLoginStatus(byte(PlayerControllerId))) > int(0))
        {
        }
    }
    //return;    
}

event RefreshMembersList()
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    // End:0x93
    if(PlayerControllerId != -1)
    {
        OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
        // End:0x93
        if(OnlineSub != none)
        {
            PlayerInterface = OnlineSub.PlayerInterface;
            // End:0x93
            if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
            {
            }
        }
    }
    //return;    
}

defaultproperties
{
    NatTypes[0]="Unknown"
}