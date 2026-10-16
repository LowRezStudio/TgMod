class UISettings extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const GFXSETTINGS_BUTTONS = 7;

const GFXSETTINGS_OPTIONS = 12;

const GFXSETTINGS_KEYBINDS = 12;

const GFXSETTINGS_KEYBINDS_COLUMNS = 2;

enum UISETTINGS_CATEGORY {
    UISC_VIDEO,  // 0
    UISC_AUDIO,  // 1
    UISC_HUD,  // 2
    UISC_CONTROLS,  // 3
    UISC_GAMEPAD,  // 4
    UISC_KEYBINDS,  // 5
    UISC_SPECTATOR,  // 6
};

enum UISETTINGS_APPLYCHANGESDIALOG {
    UISA_DIALOG_NULL,  // 0
    UISA_DIALOG_YES,  // 1
    UISA_DIALOG_NO,  // 2
};

struct KeybindOption {
    var GFxObject Obj;
    var GFxObject Base;
    var GFxObject Focus;
    var GFxObject Command;
    var GFxObject Key[2];
    var GFxObject KeyButton[2];
    structdefaultproperties {}
};

struct SettingOption {
    var GFxObject Obj;
    var GFxObject Base;
    var GFxObject Type;
    var GFxObject TypeTF;
    var GFxObject Left;
    var GFxObject Right;
    var GFxObject Focus;
    var GFxObject Color;
    var GFxObject Slider;
    var GFxObject SliderTF;
    var GFxObject SliderTitle;
    structdefaultproperties {}
};

var UIComponent_Dropdown m_ChampionDropdown;
var int m_eType;
var int m_nHighlightOption;
var int m_nOptionCount;
var int m_nCaptureAlt;
var int m_nScrollIndex;
var bool m_bOptionFocus;
var bool m_bKeybindFocus;
var bool m_bCaptureKeybind;
var bool m_bSettingsChanged;
var bool m_bIsInResetPrompt;
var float m_fDelayTimer;
var UISettings.UISETTINGS_APPLYCHANGESDIALOG m_eApplyChanges;
var int m_nCommandIndex;
var GFxObject m_Title;
var GFxObject m_Frame;
var GFxObject m_Reset;
var GFxObject m_mcBack;
var GFxObject m_Blocker;
var GFxObject m_mcIcon;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderGlow;
var GFxObject m_KeybindPopup;
var GFxObject m_KeybindPopupTF;
var GFxObject m_KeybindCancel;
var GFxObject m_KeybindBlocker;
var GFxObject m_ApplyChanges;
var GFxObject m_ApplyChangesYes;
var GFxObject m_ApplyChangesNo;
var GFxObject m_ApplyChangesBlocker;
var SettingOption m_Option[12];
var KeybindOption m_Keybind[12];
var GFxObject m_ExitButton;
var GFxObject m_AcceptButton;
var GFxObject m_mcScrollBar;
var GFxObject m_mcHeaderButton[7];
var GFxObject m_mcHeaderButtonCTA[7];
var GFxObject m_mcHeaderButtonLine[7];
var GFxObject m_mcHeaderButtonGlow[7];
var GFxObject m_mcHeaderButtonBounds[7];
var GFxObject m_mcHeaderButtonShadow[7];
var GFxObject m_mcHeaderButtonSelected[7];
var GFxObject m_mcHeaderButtonHighlight[7];
var TgGFxGroup m_grOptions;
var TgGFxGroup m_grKeybinds;
var TgGFxGroup m_grTeams;
var TgGFxGroup m_grButtons;
var TgGFxGroup m_grGamepadButtons;
var GFxObject m_mcGamepad;
var GFxObject m_mcGamepadButtons;
var GFxObject m_mcGamepadImage;
var GFxObject m_Spectator;
var GFxObject m_mcSpectatorTeamNameBlue;
var GFxObject m_mcSpectatorTeamNameRed;
var GFxObject m_mcSafeFrame;
var array<int> m_DelayedUpdates;
var array<int> m_VideoTypes;
var array<int> m_HudTypes;
var array<int> m_AudioTypes;
var array<int> m_ControlTypes;
var array<int> m_SpectatorTypes;

defaultproperties
{
    m_VideoTypes[0]=0
    m_VideoTypes[1]=1
    m_VideoTypes[2]=2
    m_VideoTypes[3]=3
    m_VideoTypes[4]=4
    m_VideoTypes[5]=5
    m_VideoTypes[6]=6
    m_VideoTypes[7]=7
    m_VideoTypes[8]=8
    m_VideoTypes[9]=9
    m_VideoTypes[10]=10
    m_VideoTypes[11]=11
    m_VideoTypes[12]=12
    m_HudTypes[0]=38
    m_HudTypes[1]=15
    m_HudTypes[2]=16
    m_HudTypes[3]=18
    m_HudTypes[4]=46
    m_HudTypes[5]=17
    m_HudTypes[6]=19
    m_HudTypes[7]=54
    m_HudTypes[8]=20
    m_HudTypes[9]=21
    m_HudTypes[10]=44
    m_HudTypes[11]=51
    m_HudTypes[12]=55
    m_AudioTypes[0]=22
    m_AudioTypes[1]=23
    m_AudioTypes[2]=24
    m_AudioTypes[3]=25
    m_AudioTypes[4]=26
    m_AudioTypes[5]=52
    m_AudioTypes[6]=49
    m_AudioTypes[7]=50
    m_AudioTypes[8]=47
    m_AudioTypes[9]=48
    m_ControlTypes[0]=29
    m_ControlTypes[1]=45
    m_ControlTypes[2]=31
    m_ControlTypes[3]=32
    m_ControlTypes[4]=33
    m_ControlTypes[5]=34
    m_ControlTypes[6]=35
    m_ControlTypes[7]=36
    m_ControlTypes[8]=37
    m_ControlTypes[9]=27
    m_ControlTypes[10]=28
    m_ControlTypes[11]=30
    m_ControlTypes[12]=53
    m_SpectatorTypes[0]=40
    m_SpectatorTypes[1]=41
    m_SpectatorTypes[2]=42
    m_SpectatorTypes[3]=43
    m_UISceneClass=Class'UIScene_UISettings'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_bBlur=true
    m_bAllowSpectatorClickThru=false
    m_Name="UISettings"
}
