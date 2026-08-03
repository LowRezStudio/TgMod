class UIDataStore_InputAlias extends UIDataStore_StringBase
    transient
    native(UIPrivate)
    config(Input)
    hidecategories(Object,UIRoot);

struct native UIInputKeyData
{
    var config RawInputKeyEventData InputKeyData;
    var config string ButtonFontMarkupString;

    structdefaultproperties
    {
        InputKeyData=(InputKeyName="None",ModifierKeyFlags=56)
        ButtonFontMarkupString=""
    }
};

struct native UIDataStoreInputAlias
{
    var config name AliasName;
    var config UIInputKeyData PlatformInputKeys[EInputPlatformType];

    structdefaultproperties
    {
        AliasName="None"
        PlatformInputKeys[0]=(InputKeyData=(InputKeyName="None",ModifierKeyFlags=56),ButtonFontMarkupString="")
        PlatformInputKeys[1]=(InputKeyData=(InputKeyName="None",ModifierKeyFlags=56),ButtonFontMarkupString="")
        PlatformInputKeys[2]=(InputKeyData=(InputKeyName="None",ModifierKeyFlags=56),ButtonFontMarkupString="")
    }
};

var protected config array<config UIDataStoreInputAlias> InputAliases;
var protected native const transient map{VOID,VOID} InputAliasLookupMap;

// Export UUIDataStore_InputAlias::execGetAliasFontMarkup(FFrame&, void* const)
native final function string GetAliasFontMarkup(name DesiredAlias, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execGetAliasFontMarkupByIndex(FFrame&, void* const)
native final function string GetAliasFontMarkupByIndex(int AliasIndex, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execGetAliasInputKeyName(FFrame&, void* const)
native final function name GetAliasInputKeyName(name DesiredAlias, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execGetAliasInputKeyNameByIndex(FFrame&, void* const)
native final function name GetAliasInputKeyNameByIndex(int AliasIndex, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execGetAliasInputKeyData(FFrame&, void* const)
native final function bool GetAliasInputKeyData(out RawInputKeyEventData out_InputKeyData, name DesiredAlias, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execGetAliasInputKeyDataByIndex(FFrame&, void* const)
native final function bool GetAliasInputKeyDataByIndex(out RawInputKeyEventData out_InputKeyData, int AliasIndex, optional UIRoot.EInputPlatformType OverridePlatform = 3);

// Export UUIDataStore_InputAlias::execFindInputAliasIndex(FFrame&, void* const)
native final function int FindInputAliasIndex(name DesiredAlias);

// Export UUIDataStore_InputAlias::execHasAliasMappingForPlatform(FFrame&, void* const)
native final function bool HasAliasMappingForPlatform(name DesiredAlias, UIRoot.EInputPlatformType DesiredPlatform);

defaultproperties
{
    Tag="ButtonCallouts"
}