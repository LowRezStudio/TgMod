class TgSettingsManager extends TgObject
    native(SettingsUI)
    config(Engine);

struct TgKeyCommand {
    var bool bAllowGamepadAxis;
    var int nPropId;
    var init string sKeyCommand;
    var init string sMirroredCommand;
    var init array<init string> sDefaultKeys;
    structdefaultproperties {}
};

struct TgKeyBind {
    var Pointer pCommand;
    var bool bOverrides;
    var init array<init string> sKeys;
    structdefaultproperties {}
};

struct TgSettingsSet {
    var init array<init TgKeyBind> Keybinds;
    var Pointer CaseSet;
    structdefaultproperties {}
};

var int m_nSelectedChampion;
var array<TgSetting> m_Settings;
var const array<TgKeyCommand> m_Commands;

native exec function string GetKeybindExtended(string sCommand, int nAlt, optional int nBotId=-1);  // Export UTgSettingsManager::execGetKeybindExtended(FFrame&, void* const)

defaultproperties
{
    m_Commands[0]=(bAllowGamepadAxis=true,nPropId=1126,sKeyCommand="GBA_MoveForward",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[1]=(bAllowGamepadAxis=true,nPropId=1127,sKeyCommand="GBA_MoveBackward",sMirroredCommand="GBA_MoveForward",sDefaultKeys=none)
    m_Commands[2]=(bAllowGamepadAxis=true,nPropId=1128,sKeyCommand="GBA_StrafeLeft",sMirroredCommand="GBA_StrafeRight",sDefaultKeys=none)
    m_Commands[3]=(bAllowGamepadAxis=true,nPropId=1129,sKeyCommand="GBA_StrafeRight",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[4]=(bAllowGamepadAxis=true,nPropId=1300,sKeyCommand="GBA_TurnLeft",sMirroredCommand="GBA_TurnRight",sDefaultKeys=none)
    m_Commands[5]=(bAllowGamepadAxis=true,nPropId=1301,sKeyCommand="GBA_TurnRight",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[6]=(bAllowGamepadAxis=true,nPropId=2010,sKeyCommand="GBA_LookUp",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[7]=(bAllowGamepadAxis=true,nPropId=2011,sKeyCommand="GBA_LookDown",sMirroredCommand="GBA_LookUp",sDefaultKeys=none)
    m_Commands[8]=(bAllowGamepadAxis=false,nPropId=1304,sKeyCommand="GBA_AutoRun",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[9]=(bAllowGamepadAxis=false,nPropId=1131,sKeyCommand="GBA_Jump",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[10]=(bAllowGamepadAxis=false,nPropId=1137,sKeyCommand="GBA_Fire",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[11]=(bAllowGamepadAxis=false,nPropId=1305,sKeyCommand="GBA_CancelFire",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[12]=(bAllowGamepadAxis=false,nPropId=1138,sKeyCommand="GBA_Reload",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[13]=(bAllowGamepadAxis=false,nPropId=1306,sKeyCommand="GBA_Ability_1",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[14]=(bAllowGamepadAxis=false,nPropId=1307,sKeyCommand="GBA_Ability_2",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[15]=(bAllowGamepadAxis=false,nPropId=1308,sKeyCommand="GBA_Ability_3",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[16]=(bAllowGamepadAxis=false,nPropId=1965,sKeyCommand="GBA_Emote",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[17]=(bAllowGamepadAxis=false,nPropId=2032,sKeyCommand="GBA_Flourish",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[18]=(bAllowGamepadAxis=false,nPropId=2012,sKeyCommand="GBA_Spray",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[19]=(bAllowGamepadAxis=false,nPropId=1153,sKeyCommand="GBA_VGS",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[20]=(bAllowGamepadAxis=false,nPropId=1964,sKeyCommand="GBA_CommonCards",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[21]=(bAllowGamepadAxis=false,nPropId=1147,sKeyCommand="GBA_Scoreboard",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[22]=(bAllowGamepadAxis=false,nPropId=2015,sKeyCommand="GBA_ScoreBoardToggle",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[23]=(bAllowGamepadAxis=false,nPropId=2014,sKeyCommand="GBA_DeathRecap",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[24]=(bAllowGamepadAxis=false,nPropId=1323,sKeyCommand="GBA_DeathRecapToggle",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[25]=(bAllowGamepadAxis=false,nPropId=2016,sKeyCommand="GBA_SkillInfo",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[26]=(bAllowGamepadAxis=false,nPropId=2017,sKeyCommand="GBA_SkillInfoToggle",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[27]=(bAllowGamepadAxis=false,nPropId=2013,sKeyCommand="GBA_PerCharacterAlt",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[28]=(bAllowGamepadAxis=false,nPropId=2008,sKeyCommand="GBA_PushToTalk",sMirroredCommand="",sDefaultKeys=none)
    m_Commands[29]=(bAllowGamepadAxis=false,nPropId=2022,sKeyCommand="GBA_UpgradeMenu",sMirroredCommand="",sDefaultKeys=none)
}
