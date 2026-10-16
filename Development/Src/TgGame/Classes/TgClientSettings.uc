class TgClientSettings extends Object
    native
    config(Game)
    dependson(TgObject);

enum ECastMode {
    CM_Default,  // 0
    CM_Quick,  // 1
    CM_Instant,  // 2
    CM_Use_Global,  // 3
};

enum EMapPlacement {
    MPLC_Bottom,  // 0
    MPLC_Top,  // 1
};

enum EFriendStateNotifications {
    FSN_Never,  // 0
    FSN_Lobby_Only,  // 1
    FSN_InGame_Only,  // 2
    FSN_Always,  // 3
};

enum ENamePlateName {
    NPN_PlayerName,  // 0
    NPN_GodName,  // 1
    NPN_None,  // 2
};

enum EColorBlindOption {
    CB_None,  // 0
    CB_Protanope,  // 1
    CB_Deuteranope,  // 2
    CB_Tritanope,  // 3
};

enum EAspectRatio {
    SETTINGAR_16x9,  // 0
    SETTINGAR_16x10,  // 1
};

enum EControlIconStyle {
    ECIS_XboxOne,  // 0
    ECIS_PS4,  // 1
};

var () globalconfig float MinimapScaling;
var () globalconfig float UIScaling;
var () globalconfig float HUDScaling;
var () globalconfig float CombatTextScaling;
var () globalconfig float ChatScaling;
var () globalconfig float ChatFadeout;
var () globalconfig TgClientSettings.ENamePlateName OverlayGodName;
var () globalconfig TgClientSettings.EFriendStateNotifications ShowFriendStateNotifications;
var () globalconfig TgObject.ETargetingLineStyle TargetingLineStyle;
var () globalconfig TgObject.ETargetingPreviewStyle TargetingPreviewStyle;
var () globalconfig TgObject.ETargetingReticleStyle TargetingReticleStyle;
var () globalconfig TgObject.ETargetingHighlightStyle TargetingHighlightStyle;
var () globalconfig TgClientSettings.ECastMode CastMode;
var () globalconfig TgClientSettings.EMapPlacement MapPlacement;
var () globalconfig TgClientSettings.EControlIconStyle ControlIconStyle;
var () globalconfig TgClientSettings.EColorBlindOption SelectedColorBlindOption;
var () globalconfig TgClientSettings.EAspectRatio DesiredAspectRatio;
var () globalconfig bool OverlayShowLocalPlayer;
var () globalconfig bool DisableHelpMessages;
var () globalconfig bool ShowInHandTargeting;
var () globalconfig bool DisableTargetingAid;
var () globalconfig bool VerticalTargetingPreviews;
var () globalconfig bool DisableProfanityFilter;
var () globalconfig bool ShowTeamTags;
var () globalconfig bool SpectateDamage;
var () globalconfig bool SpectateHeals;
var () globalconfig bool SpectateCrits;
var () globalconfig bool SpectateGold;
var () globalconfig bool SpectateXP;
var () globalconfig bool SpectateOutlines;
var () globalconfig bool ShowRentNotification;
var () globalconfig bool ShowHUDScore;
var () globalconfig bool ShowHUDEnemy;
var () globalconfig bool ShowHUDStats;
var () globalconfig bool ShowHUDItems;
var () globalconfig bool ShowWardPings;
var () globalconfig bool LoadAssistModeSubLevel;
var () globalconfig bool bTargetingAlwaysShowPreview;
var () globalconfig bool bUseCastQueueing;
var () globalconfig bool bUseFixedPitchMode;
var () globalconfig bool NewUserPromptTutorialMatch;
var () globalconfig bool NewUserFinished;
var () globalconfig bool VendorStoreTopTier;
var () globalconfig bool bEnableHelpPopups;
var () globalconfig bool ColorBlindMode;
var () globalconfig bool ColorBlindModeShader;
var () globalconfig bool ColorBlindModeShaderSimulateMode;
var () globalconfig bool MasterMute;
var () globalconfig bool SFXMute;
var () globalconfig bool MusicMute;
var () globalconfig bool VoiceMute;
var () globalconfig bool MatchNotifierMute;
var () globalconfig bool AllPlayerMute;
var () globalconfig bool bEnableVoiceChat;
var () globalconfig bool bUsePushToTalkForVoiceChat;
var () globalconfig bool QueueWaitRegion;
var () globalconfig bool QueueWaitSolo;
var () globalconfig bool AutoPurchase;
var () globalconfig bool AutoSkill;
var () globalconfig bool bToggleZoom;
var () globalconfig bool DisableJoystickInput;
var () globalconfig bool EnableControllerFeedback;
var () globalconfig bool bEnableHudTeams;
var () globalconfig bool bEnableHudCombat;
var () globalconfig bool bEnableHudHealth;
var () globalconfig bool bEnableHudTeamUI;
var () globalconfig bool bEnableHudMinimap;
var () globalconfig bool bReticleBloom;
var () globalconfig bool bChangeReticleOverEnemy;
var () globalconfig bool bEnableSpecatorPlayerIcons;
var () globalconfig bool bShowSpectatorItems;
var () globalconfig bool bPublicParty;
var globalconfig bool bShownVaultTutorial;
var globalconfig bool bEnableSpectate;
var bool blockNonFriendChat;
var bool newUserFinishedTutorial;
var () globalconfig int TeamTagFormat;
var () globalconfig float FogOfWarDimness;
var () globalconfig float MinimapOpacity;
var () globalconfig int DemoBotId;
var () globalconfig float CastQueueTime;
var () globalconfig float FixedPitchLowerBoundDegrees;
var () globalconfig float FixedPitchUpperBoundDegrees;
var () globalconfig int PlayNowTabId;
var () globalconfig int VendorStoreTabId;
var () globalconfig int VendorStoreTypeId;
var () globalconfig int VendorStoreTypeRecId;
var () globalconfig int LeagueSelection;
var () globalconfig int VPSelection;
var () globalconfig int ColorBlindModeShaderType;
var () globalconfig float MasterVolume;
var () globalconfig float SFXVolume;
var () globalconfig float MusicVolume;
var () globalconfig float VoiceVolume;
var () globalconfig float MatchNotifierVolume;
var () globalconfig float VoiceChatVolume;
var () globalconfig float VoiceChatMicVolume;
var () globalconfig int nAudioPanning;
var () globalconfig float DesiredFOV;
var () globalconfig float fGamma;
var () globalconfig int nEnableHudDamage;
var () globalconfig int nReticleColor;
var () globalconfig int nReticleType;
var () globalconfig int nSpectatorBlueTeamSeriesScore;
var () globalconfig int nSpectatorRedTeamSeriesScore;
var () globalconfig int TwitchServer;
var () globalconfig int TwitchBitrate;
var () globalconfig int TwitchFramerate;
var () globalconfig int TwitchMicVolume;
var () globalconfig int TwitchGameVolume;
var () globalconfig int TwitchResolution;
var () globalconfig int TwitchMicMute;
var () globalconfig int TwitchGameMute;
var () globalconfig int TwitchSaveUsername;
var () globalconfig string TwitchTitle;
var () globalconfig string TwitchUsername;
var globalconfig string DemoVideo;
var globalconfig array<config string> DemoResults;
var globalconfig int CustomGameQueueIndex;
var int loadingPortraitBanner;
var init array<init int> newUserWatchedVideos;
var int ChosenSkinId;
var int ChosenHeadId;
var int ChosenClassId;
var int ChosenWeaponId;
var int ChosenWeaponSkinId;
var int ChosenPedestalId;

native function LoadSettingsOnStartup();  // Export UTgClientSettings::execLoadSettingsOnStartup(FFrame&, void* const)

native function OnSettingsChanged(optional int settingtype, optional bool bSkipSave);  // Export UTgClientSettings::execOnSettingsChanged(FFrame&, void* const)

native function ApplyAudioSettings();  // Export UTgClientSettings::execApplyAudioSettings(FFrame&, void* const)

native function ApplyJoystickSettings();  // Export UTgClientSettings::execApplyJoystickSettings(FFrame&, void* const)

native function ApplySpectatorSettings();  // Export UTgClientSettings::execApplySpectatorSettings(FFrame&, void* const)

native function VerifySettingsAreValid();  // Export UTgClientSettings::execVerifySettingsAreValid(FFrame&, void* const)

native function LoadPlayerSettings();  // Export UTgClientSettings::execLoadPlayerSettings(FFrame&, void* const)

native function LoadPlayerSettingsFromIni();  // Export UTgClientSettings::execLoadPlayerSettingsFromIni(FFrame&, void* const)

native function SavePlayerSettings();  // Export UTgClientSettings::execSavePlayerSettings(FFrame&, void* const)

native function float GetDesiredAspectRatio();  // Export UTgClientSettings::execGetDesiredAspectRatio(FFrame&, void* const)

function OnReadSaveGameData(bool bWasSuccessful, byte LocalUserNum, string SaveFileName) { }

event bool ConditionalReadSaveGameData(int PlayerID, string SaveFileName) { }

event bool GetSaveGameDataViaInterface(byte LocalUserNum, const out string SaveFileName, out byte bIsValid, out array<byte> SaveGameData) { }

event bool WriteSaveGameDataViaInterface(byte LocalUserNum, const out string SaveFileName, const out array<byte> SaveGameData, string Title, string SubTitle, string Description) { }

native function OverrideVoiceInGameSettings(bool bOverride);  // Export UTgClientSettings::execOverrideVoiceInGameSettings(FFrame&, void* const)

native function TgClientSettings.ECastMode GetCastMode(optional int nCharId, optional TgObject.TG_EQUIP_POINT EquipPoint=0);  // Export UTgClientSettings::execGetCastMode(FFrame&, void* const)

native function SetCastMode(TgClientSettings.ECastMode castModeVal, optional int nCharId, optional TgObject.TG_EQUIP_POINT EquipPoint=0);  // Export UTgClientSettings::execSetCastMode(FFrame&, void* const)

event bool UpdatePlayerMuteSetting(bool PlayerMuteSetting) { }

defaultproperties
{
    MinimapScaling=1.0000000
    UIScaling=1.0000000
    HUDScaling=1.0000000
    CombatTextScaling=1.2000000
    ChatScaling=1.0000000
    ChatFadeout=2.0000000
    ShowFriendStateNotifications=FSN_Always
    ShowInHandTargeting=true
    VerticalTargetingPreviews=true
    ShowTeamTags=true
    ShowRentNotification=true
    ShowHUDScore=true
    ShowHUDEnemy=true
    ShowHUDStats=true
    ShowHUDItems=true
    ShowWardPings=true
    bTargetingAlwaysShowPreview=true
    NewUserPromptTutorialMatch=true
    VendorStoreTopTier=true
    bEnableHelpPopups=true
    bEnableVoiceChat=true
    bUsePushToTalkForVoiceChat=true
    AutoPurchase=true
    AutoSkill=true
    EnableControllerFeedback=true
    bEnableHudHealth=true
    bEnableHudTeamUI=true
    bEnableHudMinimap=true
    bReticleBloom=true
    bEnableSpecatorPlayerIcons=true
    bShowSpectatorItems=true
    bEnableSpectate=true
    FogOfWarDimness=0.4000000
    MinimapOpacity=0.7000000
    FixedPitchLowerBoundDegrees=-45.0000000
    FixedPitchUpperBoundDegrees=-8.0000000
    PlayNowTabId=-1
    ColorBlindModeShaderType=1
    MasterVolume=1.0000000
    SFXVolume=1.0000000
    MusicVolume=1.0000000
    VoiceVolume=1.0000000
    MatchNotifierVolume=0.5000000
    VoiceChatVolume=1.0000000
    VoiceChatMicVolume=1.0000000
    DesiredFOV=100.0000000
    nEnableHudDamage=2
    nSpectatorBlueTeamSeriesScore=-1
    nSpectatorRedTeamSeriesScore=-1
}
