class UIDataStore_DynamicResource extends UIDataStore
    transient
    native(UIPrivate)
    config(Game)
    hidecategories(Object,UIRoot);

struct native DynamicResourceProviderDefinition
{
    var config name ProviderTag;
    var config string ProviderClassName;
    var transient Class<UIResourceCombinationProvider> ProviderClass;

    structdefaultproperties
    {
        ProviderTag="None"
        ProviderClassName=""
        ProviderClass=none
    }
};

var transient UIDataProvider_OnlineProfileSettings ProfileProvider;
var transient UIDataStore_GameResource GameResourceDataStore;
var config array<config DynamicResourceProviderDefinition> ResourceProviderDefinitions;
var private native const transient MultiMap_Mirror ResourceProviders;

// Export UUIDataStore_DynamicResource::execFindProviderTypeIndex(FFrame&, void* const)
native final function int FindProviderTypeIndex(name ProviderTag);

// Export UUIDataStore_DynamicResource::execGetResourceProviders(FFrame&, void* const)
native final function bool GetResourceProviders(name ProviderTag, out array<UIResourceCombinationProvider> out_Providers);

// Export UUIDataStore_DynamicResource::execOnLoginChange(FFrame&, void* const)
native final function OnLoginChange(byte LocalUserNum);

event Registered(LocalPlayer PlayerOwner)
{
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;
    local UIDataStore_OnlinePlayerData PlayerProfileDS;

    super.Registered(PlayerOwner);
    PlayerProfileDS = UIDataStore_OnlinePlayerData(Class'Engine.UIRoot'.static.StaticResolveDataStore(Class'Engine.UIDataStore_OnlinePlayerData'.default.Tag, PlayerOwner));
    // End:0xA3
    if(PlayerProfileDS != none)
    {
        ProfileProvider = PlayerProfileDS.ProfileProvider;
    }
    GameResourceDataStore = UIDataStore_GameResource(Class'Engine.UIRoot'.static.StaticResolveDataStore(Class'Engine.UIDataStore_GameResource'.default.Tag, PlayerOwner));
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x1AD
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0x1AD
        if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
        {
            PlayerInterface.AddLoginChangeDelegate(OnLoginChange);
        }
    }
    //return;    
}

event Unregistered(LocalPlayer PlayerOwner)
{
    local int TypeIndex, ProviderIndex;
    local array<UIResourceCombinationProvider> ProviderInstances;
    local OnlineSubsystem OnlineSub;
    local OnlinePlayerInterface PlayerInterface;

    super.Unregistered(PlayerOwner);
    GameResourceDataStore = none;
    TypeIndex = 0;
    J0x29:

    // End:0xE5 [Loop If]
    if(TypeIndex < ResourceProviderDefinitions.Length)
    {
        // End:0xD7
        if(GetResourceProviders(ResourceProviderDefinitions[TypeIndex].ProviderTag, ProviderInstances))
        {
            ProviderIndex = 0;
            J0x88:

            // End:0xD7 [Loop If]
            if(ProviderIndex < ProviderInstances.Length)
            {
                ProviderInstances[ProviderIndex].ClearProviderReferences();
                ProviderIndex++;
                // [Loop Continue]
                goto J0x88;
            }
        }
        TypeIndex++;
        // [Loop Continue]
        goto J0x29;
    }
    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x196
    if(OnlineSub != none)
    {
        PlayerInterface = OnlineSub.PlayerInterface;
        // End:0x196
        if(NotEqual_InterfaceInterface(PlayerInterface, OnlinePlayerInterface(none)))
        {
            PlayerInterface.ClearLoginChangeDelegate(OnLoginChange);
        }
    }
    //return;    
}

defaultproperties
{
    Tag="DynamicGameResource"
}