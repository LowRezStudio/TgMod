class UIDataStore_GameResource extends UIDataStore
    transient
    native(UIPrivate)
    config(Game)
    hidecategories(Object,UIRoot);

struct native GameResourceDataProvider
{
    var config name ProviderTag;
    var config string ProviderClassName;
    var config bool bExpandProviders;
    var transient Class<UIResourceDataProvider> ProviderClass;

    structdefaultproperties
    {
        ProviderTag="None"
        ProviderClassName=""
        bExpandProviders=false
        ProviderClass=none
    }
};

var config array<config GameResourceDataProvider> ElementProviderTypes;
var private native const transient MultiMap_Mirror ListElementProviders;

// Export UUIDataStore_GameResource::execFindProviderTypeIndex(FFrame&, void* const)
native final function int FindProviderTypeIndex(name ProviderTag);

// Export UUIDataStore_GameResource::execGetResourceProviders(FFrame&, void* const)
native final function bool GetResourceProviders(name ProviderTag, out array<UIResourceDataProvider> out_Providers);

defaultproperties
{
    ElementProviderTypes[0]=(ProviderTag="GameTypes",ProviderClassName="Engine.UIGameInfoSummary",bExpandProviders=false,ProviderClass=none)
    Tag="GameResources"
}