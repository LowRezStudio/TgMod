class UIDataStore_StringAliasMap extends UIDataStore_StringBase
    transient
    native(UIPrivate)
    config(Game)
    hidecategories(Object,UIRoot);

struct native UIMenuInputMap
{
    var name FieldName;
    var name Set;
    var string MappedText;

    structdefaultproperties
    {
        FieldName="None"
        Set="None"
        MappedText=""
    }
};

var config array<config UIMenuInputMap> MenuInputMapArray;
var private native const transient Map_Mirror MenuInputSets;
var const transient int PlayerIndex;

// Export UUIDataStore_StringAliasMap::execGetPlayerOwner(FFrame&, void* const)
native final function LocalPlayer GetPlayerOwner();

// Export UUIDataStore_StringAliasMap::execFindMappingWithFieldName(FFrame&, void* const)
native final function int FindMappingWithFieldName(optional string FieldName = "", optional string SetName = "");

// Export UUIDataStore_StringAliasMap::execGetStringWithFieldName(FFrame&, void* const)
native function int GetStringWithFieldName(string FieldName, out string MappedString);

defaultproperties
{
    PlayerIndex=-1
    Tag="StringAliasMap"
}