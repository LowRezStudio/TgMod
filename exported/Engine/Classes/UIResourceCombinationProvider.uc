class UIResourceCombinationProvider extends UIDataProvider
    abstract
    transient
    native(UIPrivate)
    config(Game)
    perobjectconfig
    hidecategories(Object,UIRoot);

var transient UIResourceDataProvider StaticDataProvider;
var transient UIDataProvider_OnlineProfileSettings ProfileProvider;

event InitializeProvider(bool bIsEditor, UIResourceDataProvider InStaticResourceProvider, UIDataProvider_OnlineProfileSettings InProfileProvider)
{
    StaticDataProvider = InStaticResourceProvider;
    ProfileProvider = InProfileProvider;
    //return;    
}

function ClearProviderReferences()
{
    StaticDataProvider = none;
    ProfileProvider = none;
    //return;    
}
