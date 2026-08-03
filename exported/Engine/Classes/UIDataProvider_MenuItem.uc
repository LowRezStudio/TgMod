class UIDataProvider_MenuItem extends UIResourceDataProvider
    transient
    native(UIPrivate)
    config(UI)
    perobjectconfig
    hidecategories(Object,UIRoot);

enum EMenuOptionType
{
    MENUOT_ComboReadOnly,           // 0
    MENUOT_ComboNumeric,            // 1
    MENUOT_CheckBox,                // 2
    MENUOT_Slider,                  // 3
    MENUOT_Spinner,                 // 4
    MENUOT_EditBox,                 // 5
    MENUOT_CollectionCheckBox,      // 6
    MENUOT_CollapsingList,          // 7
    MENUOT_MAX                      // 8
};

var config UIDataProvider_MenuItem.EMenuOptionType OptionType;
var config array<config name> OptionSet;
var config string DataStoreMarkup;
var config string DescriptionMarkup;
var config name RequiredGameMode;
var const config localized string FriendlyName;
var string CustomFriendlyName;
var const config localized string Description;
var config bool bEditableCombo;
var config bool bNumericCombo;
var config bool bKeyboardOrMouseOption;
var config bool bOnlineOnly;
var config bool bOfflineOnly;
var() bool bSearchAllInis;
var config bool bRemoveOn360;
var config bool bRemoveOnPC;
var config bool bRemoveOnPS3;
var config bool bRemoveOnDingo;
var config int EditBoxMaxLength;
var config UIRangeData RangeData;
var config array<config name> SchemaCellFields;
var const string IniName;
