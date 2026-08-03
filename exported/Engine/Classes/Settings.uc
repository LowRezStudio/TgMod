class Settings extends Object
    abstract
    native;

enum EOnlineDataAdvertisementType
{
    ODAT_DontAdvertise,             // 0
    ODAT_OnlineService,             // 1
    ODAT_QoS,                       // 2
    ODAT_OnlineServiceAndQoS,       // 3
    ODAT_MAX                        // 4
};

enum ESettingsDataType
{
    SDT_Empty,                      // 0
    SDT_Int32,                      // 1
    SDT_Int64,                      // 2
    SDT_Double,                     // 3
    SDT_String,                     // 4
    SDT_Float,                      // 5
    SDT_Blob,                       // 6
    SDT_DateTime,                   // 7
    SDT_UInt32,                     // 8
    SDT_UInt64,                     // 9
    SDT_MAX                         // 10
};

enum EPropertyValueMappingType
{
    PVMT_RawValue,                  // 0
    PVMT_PredefinedValues,          // 1
    PVMT_Ranged,                    // 2
    PVMT_IdMapped,                  // 3
    PVMT_MAX                        // 4
};

struct native LocalizedStringSetting
{
    var int Id;
    var int ValueIndex;
    var Settings.EOnlineDataAdvertisementType AdvertisementType;

    structdefaultproperties
    {
        Id=0
        ValueIndex=0
        AdvertisementType=EOnlineDataAdvertisementType.ODAT_DontAdvertise
    }
};

struct native SettingsData
{
    var const Settings.ESettingsDataType Type;
    var const int Value1;
    var native const transient Pointer Value2;

    structdefaultproperties
    {
        Type=ESettingsDataType.SDT_Empty
        Value1=0
    }
};

struct native SettingsProperty
{
    var int PropertyId;
    var SettingsData Data;
    var Settings.EOnlineDataAdvertisementType AdvertisementType;

    structdefaultproperties
    {
        PropertyId=0
        Data=(Type=ESettingsDataType.SDT_Empty,Value1=0)
        AdvertisementType=EOnlineDataAdvertisementType.ODAT_DontAdvertise
    }
};

struct native StringIdToStringMapping
{
    var const int Id;
    var const localized name Name;
    var const bool bIsWildcard;

    structdefaultproperties
    {
        Id=0
        Name="None"
        bIsWildcard=false
    }
};

struct native LocalizedStringSettingMetaData
{
    var const int Id;
    var const name Name;
    var const localized string ColumnHeaderText;
    var const array<StringIdToStringMapping> ValueMappings;

    structdefaultproperties
    {
        Id=0
        Name="None"
        ColumnHeaderText=""
        ValueMappings=none
    }
};

struct native IdToStringMapping
{
    var const int Id;
    var const localized name Name;

    structdefaultproperties
    {
        Id=0
        Name="None"
    }
};

struct native SettingsPropertyPropertyMetaData
{
    var const int Id;
    var const name Name;
    var const localized string ColumnHeaderText;
    var const Settings.EPropertyValueMappingType MappingType;
    var const array<IdToStringMapping> ValueMappings;
    var const array<SettingsData> PredefinedValues;
    var const float MinVal;
    var const float MaxVal;
    var const float RangeIncrement;

    structdefaultproperties
    {
        Id=0
        Name="None"
        ColumnHeaderText=""
        MappingType=EPropertyValueMappingType.PVMT_RawValue
        ValueMappings=none
        PredefinedValues=none
        MinVal=0.0000000
        MaxVal=0.0000000
        RangeIncrement=0.0000000
    }
};

var array<LocalizedStringSetting> LocalizedSettings;
var array<SettingsProperty> Properties;
var array<LocalizedStringSettingMetaData> LocalizedSettingsMappings;
var array<SettingsPropertyPropertyMetaData> PropertyMappings;

// Export USettings::execSetSettingsDataFloat(FFrame&, void* const)
native static function SetSettingsDataFloat(out SettingsData Data, float InFloat);

// Export USettings::execSetSettingsDataInt(FFrame&, void* const)
native static function SetSettingsDataInt(out SettingsData Data, int InInt);

// Export USettings::execSetSettingsDataDateTime(FFrame&, void* const)
native static function SetSettingsDataDateTime(out SettingsData Data, int InInt1, int InInt2);

// Export USettings::execSetSettingsDataBlob(FFrame&, void* const)
native static function SetSettingsDataBlob(out SettingsData Data, out array<byte> InBlob);

// Export USettings::execSetSettingsData(FFrame&, void* const)
native static function SetSettingsData(out SettingsData Data, out SettingsData Data2Copy);

// Export USettings::execEmptySettingsData(FFrame&, void* const)
native static function EmptySettingsData(out SettingsData Data);

// Export USettings::execGetSettingsDataFloat(FFrame&, void* const)
native static function float GetSettingsDataFloat(out SettingsData Data);

// Export USettings::execGetSettingsDataInt(FFrame&, void* const)
native static function int GetSettingsDataInt(out SettingsData Data);

// Export USettings::execGetSettingsDataBlob(FFrame&, void* const)
native static function GetSettingsDataBlob(out SettingsData Data, out array<byte> OutBlob);

// Export USettings::execGetSettingsDataDateTime(FFrame&, void* const)
native static function GetSettingsDataDateTime(out SettingsData Data, out int OutInt1, out int OutInt2);

// Export USettings::execSetStringSettingValue(FFrame&, void* const)
native function SetStringSettingValue(int StringSettingId, int ValueIndex, optional bool bShouldAutoAdd);

// Export USettings::execGetStringSettingValue(FFrame&, void* const)
native function bool GetStringSettingValue(int StringSettingId, out int ValueIndex);

// Export USettings::execIncrementStringSettingValue(FFrame&, void* const)
native function bool IncrementStringSettingValue(int StringSettingId, int Direction, bool bShouldWrap);

// Export USettings::execGetStringSettingValueNames(FFrame&, void* const)
native function bool GetStringSettingValueNames(int StringSettingId, out array<IdToStringMapping> Values);

// Export USettings::execSetStringSettingValueByName(FFrame&, void* const)
native function SetStringSettingValueByName(name StringSettingName, int ValueIndex, bool bShouldAutoAdd);

// Export USettings::execGetStringSettingValueByName(FFrame&, void* const)
native function bool GetStringSettingValueByName(name StringSettingName, out int ValueIndex);

// Export USettings::execGetStringSettingId(FFrame&, void* const)
native function bool GetStringSettingId(name StringSettingName, out int StringSettingId);

// Export USettings::execGetStringSettingName(FFrame&, void* const)
native function name GetStringSettingName(int StringSettingId);

// Export USettings::execGetStringSettingColumnHeader(FFrame&, void* const)
native function string GetStringSettingColumnHeader(int StringSettingId);

// Export USettings::execIsWildcardStringSetting(FFrame&, void* const)
native function bool IsWildcardStringSetting(int StringSettingId);

// Export USettings::execGetStringSettingValueName(FFrame&, void* const)
native function name GetStringSettingValueName(int StringSettingId, int ValueIndex);

// Export USettings::execGetStringSettingValueNameByName(FFrame&, void* const)
native function name GetStringSettingValueNameByName(name StringSettingName);

// Export USettings::execSetStringSettingValueFromStringByName(FFrame&, void* const)
native function bool SetStringSettingValueFromStringByName(name StringSettingName, const out string NewValue);

// Export USettings::execGetPropertyId(FFrame&, void* const)
native function bool GetPropertyId(name PropertyName, out int PropertyId);

// Export USettings::execGetPropertyName(FFrame&, void* const)
native function name GetPropertyName(int PropertyId);

// Export USettings::execGetPropertyColumnHeader(FFrame&, void* const)
native function string GetPropertyColumnHeader(int PropertyId);

// Export USettings::execGetPropertyAsString(FFrame&, void* const)
native function string GetPropertyAsString(int PropertyId);

// Export USettings::execGetPropertyAsStringByName(FFrame&, void* const)
native function string GetPropertyAsStringByName(name PropertyName);

// Export USettings::execSetPropertyFromStringByName(FFrame&, void* const)
native function bool SetPropertyFromStringByName(name PropertyName, const out string NewValue);

// Export USettings::execSetFloatProperty(FFrame&, void* const)
native function SetFloatProperty(int PropertyId, float Value);

// Export USettings::execGetFloatProperty(FFrame&, void* const)
native function bool GetFloatProperty(int PropertyId, out float Value);

// Export USettings::execSetIntProperty(FFrame&, void* const)
native function SetIntProperty(int PropertyId, int Value);

// Export USettings::execGetIntProperty(FFrame&, void* const)
native function bool GetIntProperty(int PropertyId, out int Value);

// Export USettings::execSetStringProperty(FFrame&, void* const)
native function SetStringProperty(int PropertyId, string Value);

// Export USettings::execGetStringProperty(FFrame&, void* const)
native function bool GetStringProperty(int PropertyId, out string Value);

// Export USettings::execSetPropertyValueId(FFrame&, void* const)
native function bool SetPropertyValueId(int PropertyId, int ValueId);

// Export USettings::execGetPropertyValueId(FFrame&, void* const)
native function bool GetPropertyValueId(int PropertyId, out int ValueId);

// Export USettings::execGetPropertyType(FFrame&, void* const)
native function Settings.ESettingsDataType GetPropertyType(int PropertyId);

// Export USettings::execUpdateStringSettings(FFrame&, void* const)
native function UpdateStringSettings(const out array<LocalizedStringSetting> Settings, optional bool bShouldAddIfMissing = true);

// Export USettings::execUpdateProperties(FFrame&, void* const)
native function UpdateProperties(const out array<SettingsProperty> Props, optional bool bShouldAddIfMissing = true);

// Export USettings::execHasProperty(FFrame&, void* const)
native function bool HasProperty(int PropertyId);

// Export USettings::execHasStringSetting(FFrame&, void* const)
native function bool HasStringSetting(int SettingId);

// Export USettings::execGetPropertyMappingType(FFrame&, void* const)
native function bool GetPropertyMappingType(int PropertyId, out Settings.EPropertyValueMappingType OutType);

// Export USettings::execGetPropertyRange(FFrame&, void* const)
native function bool GetPropertyRange(int PropertyId, out float OutMinValue, out float OutMaxValue, out float RangeIncrement, out byte bFormatAsInt);

// Export USettings::execSetRangedPropertyValue(FFrame&, void* const)
native function bool SetRangedPropertyValue(int PropertyId, float NewValue);

// Export USettings::execGetRangedPropertyValue(FFrame&, void* const)
native function bool GetRangedPropertyValue(int PropertyId, out float OutValue);

// Export USettings::execGetQoSAdvertisedProperties(FFrame&, void* const)
native function GetQoSAdvertisedProperties(out array<SettingsProperty> QoSProps);

// Export USettings::execGetQoSAdvertisedStringSettings(FFrame&, void* const)
native function GetQoSAdvertisedStringSettings(out array<LocalizedStringSetting> QoSSettings);

// Export USettings::execAppendDataBindingsToURL(FFrame&, void* const)
native function AppendDataBindingsToURL(out string URL);

// Export USettings::execAppendPropertiesToURL(FFrame&, void* const)
native function AppendPropertiesToURL(out string URL);

// Export USettings::execAppendContextsToURL(FFrame&, void* const)
native function AppendContextsToURL(out string URL);

// Export USettings::execBuildURL(FFrame&, void* const)
native function BuildURL(out string URL);

// Export USettings::execUpdateFromURL(FFrame&, void* const)
native function UpdateFromURL(const out string URL, GameInfo Game);
