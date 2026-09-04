class OnlineProfileSettings extends OnlinePlayerStorage
    native;

enum EProfileSettingID
{
    PSI_Unknown,                    // 0
    PSI_ControllerVibration,        // 1
    PSI_YInversion,                 // 2
    PSI_GamerCred,                  // 3
    PSI_GamerRep,                   // 4
    PSI_VoiceMuted,                 // 5
    PSI_VoiceThruSpeakers,          // 6
    PSI_VoiceVolume,                // 7
    PSI_GamerPictureKey,            // 8
    PSI_GamerMotto,                 // 9
    PSI_GamerTitlesPlayed,          // 10
    PSI_GamerAchievementsEarned,    // 11
    PSI_GameDifficulty,             // 12
    PSI_ControllerSensitivity,      // 13
    PSI_PreferredColor1,            // 14
    PSI_PreferredColor2,            // 15
    PSI_AutoAim,                    // 16
    PSI_AutoCenter,                 // 17
    PSI_MovementControl,            // 18
    PSI_RaceTransmission,           // 19
    PSI_RaceCameraLocation,         // 20
    PSI_RaceBrakeControl,           // 21
    PSI_RaceAcceleratorControl,     // 22
    PSI_GameCredEarned,             // 23
    PSI_GameAchievementsEarned,     // 24
    PSI_EndLiveIds,                 // 25
    PSI_ProfileVersionNum,          // 26
    PSI_ProfileSaveCount,           // 27
    PSI_MAX                         // 28
};

enum EProfileDifficultyOptions
{
    PDO_Normal,                     // 0
    PDO_Easy,                       // 1
    PDO_Hard,                       // 2
    PDO_MAX                         // 3
};

enum EProfileControllerSensitivityOptions
{
    PCSO_Medium,                    // 0
    PCSO_Low,                       // 1
    PCSO_High,                      // 2
    PCSO_MAX                        // 3
};

enum EProfilePreferredColorOptions
{
    PPCO_None,                      // 0
    PPCO_Black,                     // 1
    PPCO_White,                     // 2
    PPCO_Yellow,                    // 3
    PPCO_Orange,                    // 4
    PPCO_Pink,                      // 5
    PPCO_Red,                       // 6
    PPCO_Purple,                    // 7
    PPCO_Blue,                      // 8
    PPCO_Green,                     // 9
    PPCO_Brown,                     // 10
    PPCO_Silver,                    // 11
    PPCO_MAX                        // 12
};

enum EProfileAutoAimOptions
{
    PAAO_Off,                       // 0
    PAAO_On,                        // 1
    PAAO_MAX                        // 2
};

enum EProfileAutoCenterOptions
{
    PACO_Off,                       // 0
    PACO_On,                        // 1
    PACO_MAX                        // 2
};

enum EProfileMovementControlOptions
{
    PMCO_L_Thumbstick,              // 0
    PMCO_R_Thumbstick,              // 1
    PMCO_MAX                        // 2
};

enum EProfileRaceTransmissionOptions
{
    PRTO_Auto,                      // 0
    PRTO_Manual,                    // 1
    PRTO_MAX                        // 2
};

enum EProfileRaceCameraLocationOptions
{
    PRCLO_Behind,                   // 0
    PRCLO_Front,                    // 1
    PRCLO_Inside,                   // 2
    PRCLO_MAX                       // 3
};

enum EProfileRaceBrakeControlOptions
{
    PRBCO_Trigger,                  // 0
    PRBCO_Button,                   // 1
    PRBCO_MAX                       // 2
};

enum EProfileRaceAcceleratorControlOptions
{
    PRACO_Trigger,                  // 0
    PRACO_Button,                   // 1
    PRACO_MAX                       // 2
};

enum EProfileYInversionOptions
{
    PYIO_Off,                       // 0
    PYIO_On,                        // 1
    PYIO_MAX                        // 2
};

enum EProfileXInversionOptions
{
    PXIO_Off,                       // 0
    PXIO_On,                        // 1
    PXIO_MAX                        // 2
};

enum EProfileOmniDirEvadeOptions
{
    PODI_Off,                       // 0
    PODI_On,                        // 1
    PODI_MAX                        // 2
};

enum EProfileControllerVibrationToggleOptions
{
    PCVTO_Off,                      // 0
    PCVTO_IgnoreThis,               // 1
    PCVTO_IgnoreThis2,              // 2
    PCVTO_On,                       // 3
    PCVTO_MAX                       // 4
};

enum EProfileVoiceThruSpeakersOptions
{
    PVTSO_Off,                      // 0
    PVTSO_On,                       // 1
    PVTSO_Both,                     // 2
    PVTSO_MAX                       // 3
};

var array<int> ProfileSettingIds;
var array<OnlineProfileSetting> DefaultSettings;
var const array<IdToStringMapping> OwnerMappings;

// Export UOnlineProfileSettings::execGetProfileSettingDefaultId(FFrame&, void* const)
native function bool GetProfileSettingDefaultId(int ProfileSettingId, out int DefaultId, out int ListIndex);

// Export UOnlineProfileSettings::execGetProfileSettingDefaultInt(FFrame&, void* const)
native function bool GetProfileSettingDefaultInt(int ProfileSettingId, out int DefaultInt);

// Export UOnlineProfileSettings::execGetProfileSettingDefaultFloat(FFrame&, void* const)
native function bool GetProfileSettingDefaultFloat(int ProfileSettingId, out float DefaultFloat);

// Export UOnlineProfileSettings::execSetToDefaults(FFrame&, void* const)
native event SetToDefaults();

// Export UOnlineProfileSettings::execAppendVersionToReadIds(FFrame&, void* const)
native function AppendVersionToReadIds();

event ModifyAvailableProfileSettings()
{
    //return;    
}

defaultproperties
{
    OwnerMappings[0]=(Id=0,Name="None")
    OwnerMappings[1]=(Id=1,Name="Online Service Setting")
    OwnerMappings[2]=(Id=2,Name="Game Setting")
    VersionSettingsId=26
    ProfileMappings[0]=(Id=1,Name="Controller Vibration",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_IdMapped,ValueMappings=/* ERROR: System.Exception */,Id=3,Name="Off")
    ProfileMappings[1]=(Id=0,Name="On")
    ProfileMappings[2]=(PredefinedValues=none,MinVal=0.0000000,MaxVal=0.0000000,RangeIncrement=0.0000000)
    ProfileMappings[3]=(Id=2,Name="Invert Y",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_IdMapped,ValueMappings=/* ERROR: System.Exception */,Id=0,Name="Off")
    ProfileMappings[4]=(Id=1,Name="On")
    ProfileMappings[5]=(PredefinedValues=none,MinVal=0.0000000,MaxVal=0.0000000,RangeIncrement=0.0000000)
    ProfileMappings[6]=(Id=5,Name="Mute Voice",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_IdMapped,ValueMappings=/* ERROR: System.Exception */,Id=0,Name="No")
    ProfileMappings[7]=(Id=1,Name="Yes")
    ProfileMappings[8]=(PredefinedValues=none,MinVal=0.0000000,MaxVal=0.0000000,RangeIncrement=0.0000000)
    ProfileMappings[9]=(Id=6,Name="Voice Via Speakers",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_IdMapped,ValueMappings=/* ERROR: System.Exception */,Id=0,Name="Off")
    ProfileMappings[10]=(Id=1,Name="On")
    ProfileMappings[11]=(Id=2,Name="Both")
    ProfileMappings[12]=(PredefinedValues=none,MinVal=0.0000000,MaxVal=0.0000000,RangeIncrement=0.0000000)
    ProfileMappings[13]=(Id=7,Name="Voice Volume",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_RawValue,ValueMappings=none,PredefinedValues=none,MinVal=0.0000000,MaxVal=0.0000000,RangeIncrement=0.0000000)
    ProfileMappings[14]=(Id=12,Name="Difficulty Level",ColumnHeaderText="",MappingType=EPropertyValueMappingType.PVMT_IdMapped,ValueMappings=/* ERROR: System.Exception */,Id=0,Name="Normal")
    ProfileMappings[15]=(Id=1,Name="Easy")
}