class UIDataProvider_SettingsArray extends UIDataProvider
    transient
    native(UIPrivate)
    config(Engine)
    hidecategories(Object,UIRoot);

var Settings Settings;
var int SettingsId;
var name SettingsName;
var const string ColumnHeaderText;
var array<IdToStringMapping> Values;
