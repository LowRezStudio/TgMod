class OnlinePlayerStorage extends Object
    native;

enum EOnlineProfilePropertyOwner
{
    OPPO_None,                      // 0
    OPPO_OnlineService,             // 1
    OPPO_Game,                      // 2
    OPPO_MAX                        // 3
};

enum EOnlinePlayerStorageAsyncState
{
    OPAS_NotStarted,                // 0
    OPAS_Read,                      // 1
    OPAS_Write,                     // 2
    OPAS_Finished,                  // 3
    OPAS_MAX                        // 4
};

struct native OnlineProfileSetting
{
    var OnlinePlayerStorage.EOnlineProfilePropertyOwner Owner;
    var SettingsProperty ProfileSetting;

    structdefaultproperties
    {
        Owner=EOnlineProfilePropertyOwner.OPPO_None
        ProfileSetting=(PropertyId=0,Data=(Type=ESettingsDataType.SDT_Empty,Value1=0),AdvertisementType=EOnlineDataAdvertisementType.ODAT_DontAdvertise)
    }
};

var const int VersionNumber;
var const int VersionSettingsId;
var const int SaveCountSettingId;
var array<OnlineProfileSetting> ProfileSettings;
var array<SettingsPropertyPropertyMetaData> ProfileMappings;
var const OnlinePlayerStorage.EOnlinePlayerStorageAsyncState AsyncState;
var int DeviceID;

// Export UOnlinePlayerStorage::execGetProfileSettingId(FFrame&, void* const)
native function bool GetProfileSettingId(name ProfileSettingName, out int ProfileSettingId);

// Export UOnlinePlayerStorage::execGetProfileSettingName(FFrame&, void* const)
native function name GetProfileSettingName(int ProfileSettingId);

// Export UOnlinePlayerStorage::execGetProfileSettingColumnHeader(FFrame&, void* const)
native function string GetProfileSettingColumnHeader(int ProfileSettingId);

// Export UOnlinePlayerStorage::execFindProfileSettingIndex(FFrame&, void* const)
native final function int FindProfileSettingIndex(int ProfileSettingId);

// Export UOnlinePlayerStorage::execFindProfileMappingIndex(FFrame&, void* const)
native final function int FindProfileMappingIndex(int ProfileSettingId);

// Export UOnlinePlayerStorage::execFindProfileMappingIndexByName(FFrame&, void* const)
native final function int FindProfileMappingIndexByName(name ProfileSettingName);

// Export UOnlinePlayerStorage::execFindDefaultProfileMappingIndexByName(FFrame&, void* const)
native static final function int FindDefaultProfileMappingIndexByName(name ProfileSettingName);

// Export UOnlinePlayerStorage::execIsProfileSettingIdMapped(FFrame&, void* const)
native function bool IsProfileSettingIdMapped(int ProfileSettingId);

// Export UOnlinePlayerStorage::execGetProfileSettingValue(FFrame&, void* const)
native function bool GetProfileSettingValue(int ProfileSettingId, out string Value, optional int ValueMapID = -1);

// Export UOnlinePlayerStorage::execGetProfileSettingValueName(FFrame&, void* const)
native function name GetProfileSettingValueName(int ProfileSettingId);

// Export UOnlinePlayerStorage::execGetProfileSettingValues(FFrame&, void* const)
native function bool GetProfileSettingValues(int ProfileSettingId, out array<name> Values);

// Export UOnlinePlayerStorage::execGetProfileSettingValueByName(FFrame&, void* const)
native function bool GetProfileSettingValueByName(name ProfileSettingName, out string Value);

// Export UOnlinePlayerStorage::execSetProfileSettingValueByName(FFrame&, void* const)
native function bool SetProfileSettingValueByName(name ProfileSettingName, const out string NewValue);

// Export UOnlinePlayerStorage::execSetProfileSettingValue(FFrame&, void* const)
native function bool SetProfileSettingValue(int ProfileSettingId, const out string NewValue);

// Export UOnlinePlayerStorage::execGetProfileSettingValueId(FFrame&, void* const)
native function bool GetProfileSettingValueId(int ProfileSettingId, out int ValueId, optional out int ListIndex);

// Export UOnlinePlayerStorage::execGetProfileSettingValueFromListIndex(FFrame&, void* const)
native function bool GetProfileSettingValueFromListIndex(int ProfileSettingId, int ListIndex, out int Value);

// Export UOnlinePlayerStorage::execGetProfileSettingValueInt(FFrame&, void* const)
native function bool GetProfileSettingValueInt(int ProfileSettingId, out int Value);

// Export UOnlinePlayerStorage::execGetProfileSettingValueFloat(FFrame&, void* const)
native function bool GetProfileSettingValueFloat(int ProfileSettingId, out float Value);

// Export UOnlinePlayerStorage::execSetProfileSettingValueId(FFrame&, void* const)
native function bool SetProfileSettingValueId(int ProfileSettingId, int Value);

// Export UOnlinePlayerStorage::execSetProfileSettingValueInt(FFrame&, void* const)
native function bool SetProfileSettingValueInt(int ProfileSettingId, int Value);

// Export UOnlinePlayerStorage::execSetProfileSettingValueFloat(FFrame&, void* const)
native function bool SetProfileSettingValueFloat(int ProfileSettingId, float Value);

// Export UOnlinePlayerStorage::execGetProfileSettingMappingType(FFrame&, void* const)
native function bool GetProfileSettingMappingType(int ProfileId, out Settings.EPropertyValueMappingType OutType);

// Export UOnlinePlayerStorage::execGetProfileSettingMappingIds(FFrame&, void* const)
native static function bool GetProfileSettingMappingIds(int ProfileId, out array<int> Ids);

// Export UOnlinePlayerStorage::execGetProfileSettingRange(FFrame&, void* const)
native function bool GetProfileSettingRange(int ProfileId, out float OutMinValue, out float OutMaxValue, out float RangeIncrement, out byte bFormatAsInt);

// Export UOnlinePlayerStorage::execSetRangedProfileSettingValue(FFrame&, void* const)
native function bool SetRangedProfileSettingValue(int ProfileId, float NewValue);

// Export UOnlinePlayerStorage::execGetRangedProfileSettingValue(FFrame&, void* const)
native function bool GetRangedProfileSettingValue(int ProfileId, out float OutValue);

// Export UOnlinePlayerStorage::execAddSettingInt(FFrame&, void* const)
native function AddSettingInt(int SettingId);

// Export UOnlinePlayerStorage::execAddSettingFloat(FFrame&, void* const)
native function AddSettingFloat(int SettingId);

// Export UOnlinePlayerStorage::execSetToDefaults(FFrame&, void* const)
native event SetToDefaults();

// Export UOnlinePlayerStorage::execAppendVersionToSettings(FFrame&, void* const)
native function AppendVersionToSettings();

// Export UOnlinePlayerStorage::execGetVersionNumber(FFrame&, void* const)
native function int GetVersionNumber();

// Export UOnlinePlayerStorage::execSetDefaultVersionNumber(FFrame&, void* const)
native function SetDefaultVersionNumber();

defaultproperties
{
    VersionNumber=-1
    SaveCountSettingId=1
    DeviceID=-1
}