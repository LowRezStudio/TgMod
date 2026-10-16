class UIDataStore_OnlineGameSettings extends UIDataStore_Settings
    abstract
    transient
    native(UIPrivate)
    config(Game)
    hidecategories(Object,UIRoot);

struct native GameSettingsCfg
{
    var Class<OnlineGameSettings> GameSettingsClass;
    var UIDataProvider_Settings Provider;
    var OnlineGameSettings GameSettings;
    var name SettingsName;

    structdefaultproperties
    {
        GameSettingsClass=none
        Provider=none
        GameSettings=none
        SettingsName="None"
    }
};

var const array<GameSettingsCfg> GameSettingsCfgList;
var const Class<UIDataProvider_Settings> SettingsProviderClass;
var int SelectedIndex;

event bool CreateGame(byte ControllerIndex)
{
    local OnlineSubsystem OnlineSub;
    local OnlineGameInterface GameInterface;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0xDF
    if(OnlineSub != none)
    {
        GameInterface = OnlineSub.GameInterface;
        // End:0xDC
        if(NotEqual_InterfaceInterface(GameInterface, OnlineGameInterface(none)))
        {
            return GameInterface.CreateOnlineGame(ControllerIndex, 'Game', GameSettingsCfgList[SelectedIndex].GameSettings);            
        }        
    }
    return false;
    //return ReturnValue;    
}

event OnlineGameSettings GetCurrentGameSettings()
{
    return GameSettingsCfgList[SelectedIndex].GameSettings;
    //return ReturnValue;    
}

event UIDataProvider_Settings GetCurrentProvider()
{
    return GameSettingsCfgList[SelectedIndex].Provider;
    //return ReturnValue;    
}

event SetCurrentByIndex(int NewIndex)
{
    // End:0x56
    if((NewIndex >= 0) && NewIndex < GameSettingsCfgList.Length)
    {
        SelectedIndex = NewIndex;
        RefreshSubscribers(,, true, GetCurrentProvider());        
    }
    //return;    
}

event SetCurrentByName(name SettingsName)
{
    local int Index;

    Index = 0;
    J0x0B:

    // End:0x7A [Loop If]
    if(Index < GameSettingsCfgList.Length)
    {
        // End:0x6C
        if(GameSettingsCfgList[Index].SettingsName == SettingsName)
        {
            SetCurrentByIndex(Index);
            return;
        }
        Index++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

event MoveToNext()
{
    local int NewIndex;

    NewIndex = Min(SelectedIndex + 1, GameSettingsCfgList.Length - 1);
    // End:0x4F
    if(SelectedIndex != NewIndex)
    {
        SetCurrentByIndex(NewIndex);
    }
    //return;    
}

event MoveToPrevious()
{
    local int NewIndex;

    NewIndex = Max(SelectedIndex - 1, 0);
    // End:0x43
    if(SelectedIndex != NewIndex)
    {
        SetCurrentByIndex(NewIndex);
    }
    //return;    
}

event Registered(LocalPlayer PlayerOwner)
{
    super(UIDataStore).Registered(PlayerOwner);
    //return;    
}

event Unregistered(LocalPlayer PlayerOwner)
{
    super(UIDataStore).Unregistered(PlayerOwner);
    //return;    
}

defaultproperties
{
    SettingsProviderClass=Class'Engine.UIDataProvider_Settings'
    Tag="OnlineGameSettings"
}