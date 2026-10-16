class UIDataStore_MenuItems extends UIDataStore_GameResource
    transient
    native(UIPrivate)
    config(UI)
    hidecategories(Object,UIRoot);

var const name CurrentGameSettingsTag;
var private native const transient MultiMap_Mirror OptionProviders;
var transient array<UIDataProvider_MenuItem> DynamicProviders;

function OnGameSettingsChanged(UIDataProvider SourceProvider, optional name PropTag)
{
    local UIDataStore_OnlineGameSettings GameSettingsDataStore;

    GameSettingsDataStore = UIDataStore_OnlineGameSettings(SourceProvider);
    // End:0x5B
    if((GameSettingsDataStore != none) && PropTag == 'SelectedIndex')
    {
        RefreshSubscribers(CurrentGameSettingsTag, true, self);
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
    CurrentGameSettingsTag="CurrentGameSettings"
    Tag="MenuItems"
}