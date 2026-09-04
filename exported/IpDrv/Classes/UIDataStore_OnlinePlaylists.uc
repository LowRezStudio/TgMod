class UIDataStore_OnlinePlaylists extends UIDataStore
    transient
    native(UIPrivate)
    config(Game)
    hidecategories(Object,UIRoot);

const RANKEDPROVIDERTAG = "PlaylistsRanked";
const UNRANKEDPROVIDERTAG = "PlaylistsUnranked";
const RECMODEPROVIDERTAG = "PlaylistsRecMode";
const PRIVATEPROVIDERTAG = "PlaylistsPrivate";

var config string ProviderClassName;
var transient Class<UIResourceDataProvider> ProviderClass;
var const array<UIResourceDataProvider> RankedDataProviders;
var const array<UIResourceDataProvider> UnrankedDataProviders;
var const array<UIResourceDataProvider> RecModeDataProviders;
var const array<UIResourceDataProvider> PrivateDataProviders;
var OnlinePlaylistManager PlaylistMan;

event Init()
{
    local OnlineSubsystem OnlineSub;

    OnlineSub = Class'Engine.GameEngine'.static.GetOnlineSubsystem();
    // End:0x99
    if((OnlineSub != none) && OnlineSub.Patcher != none)
    {
        PlaylistMan = OnlinePlaylistManager(OnlineSub.GetNamedInterface('PlaylistManager'));
    }
    //return;    
}

// Export UUIDataStore_OnlinePlaylists::execGetResourceProviders(FFrame&, void* const)
native final function bool GetResourceProviders(name ProviderTag, out array<UIResourceDataProvider> out_Providers);

// Export UUIDataStore_OnlinePlaylists::execGetPlaylistProvider(FFrame&, void* const)
native final function bool GetPlaylistProvider(name ProviderTag, int ProviderIndex, out UIResourceDataProvider out_Provider);

static function OnlinePlaylistProvider GetOnlinePlaylistProvider(name ProviderTag, int PlaylistId, optional out int ProviderIndex)
{
    local UIDataStore_OnlinePlaylists PlaylistDS;
    local array<UIResourceDataProvider> Providers;
    local OnlinePlaylistProvider OPP;

    ProviderIndex = -1;
    PlaylistDS = UIDataStore_OnlinePlaylists(Class'Engine.UIRoot'.static.StaticResolveDataStore(Class'IpDrv.UIDataStore_OnlinePlaylists'.default.Tag));
    // End:0x12E
    if(PlaylistDS != none)
    {
        PlaylistDS.GetResourceProviders(ProviderTag, Providers);
        ProviderIndex = 0;
        J0xAC:

        // End:0x12E [Loop If]
        if(ProviderIndex < Providers.Length)
        {
            OPP = OnlinePlaylistProvider(Providers[ProviderIndex]);
            // End:0x120
            if(OPP.PlaylistId == PlaylistId)
            {
                return OPP;
            }
            ProviderIndex++;
            // [Loop Continue]
            goto J0xAC;
        }
    }
    return none;
    //return ReturnValue;    
}

event int GetMatchTypeForPlaylistId(int PlaylistId)
{
    // End:0x38
    if(PlaylistMan != none)
    {
        return PlaylistMan.GetMatchType(PlaylistId);
    }
    return -1;
    //return ReturnValue;    
}

defaultproperties
{
    Tag="OnlinePlaylists"
}