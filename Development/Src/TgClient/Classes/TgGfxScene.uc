class TgGfxScene extends GFxObject within GFxMoviePlayer
    native(GFxScene)
    config(Engine)
    dependson(UIComponent);

const UISCENE_NATIVE_WIDTH = 1920;

const UISCENE_NATIVE_HEIGHT = 1080;

const UI_AUTHORED_WIDTH = 1920;

const UI_AUTHORED_HEIGHT = 1080;

enum GFXOPTION {
    GFXOPTION_NONE,  // 0
    GFXOPTION_BACK,  // 1
    GFXOPTION_MENU,  // 2
    GFXOPTION_APPLY,  // 3
    GFXOPTION_LEAVEQUEUE,  // 4
    GFXOPTION_SOCIAL,  // 5
    GFXOPTION_SELECT,  // 6
    GFXOPTION_ADDCARD,  // 7
    GFXOPTION_REMOVECARD,  // 8
    GFXOPTION_FILTER,  // 9
    GFXOPTION_FILTERCHAMP,  // 10
    GFXOPTION_ADDREMOVE,  // 11
    GFXOPTION_CHAT,  // 12
    GFXOPTION_CHANGEUSER,  // 13
    GFXOPTION_CHANGETAB,  // 14
    GFXOPTION_JOIN,  // 15
    GFXOPTION_PREVIOUS,  // 16
    GFXOPTION_NEXT,  // 17
    GFXOPTION_ACCEPT,  // 18
    GFXOPTION_CANCEL,  // 19
    GFXOPTION_PURCHASE,  // 20
    GFXOPTION_HOME,  // 21
    GFXOPTION_PLAYAGAIN,  // 22
    GFXOPTION_CREATEGAME,  // 23
    GFXOPTION_LOGOUT,  // 24
    GFXOPTION_UNLOCK,  // 25
    GFXOPTION_LEADERBOARD,  // 26
    GFXOPTION_TRADE,  // 27
    GFXOPTION_PURCHASEGEMS,  // 28
    GFXOPTION_MUTEPLAYER,  // 29
    GFXOPTION_UNMUTEPLAYER,  // 30
    GFXOPTION_REROLL_QUEST,  // 31
    GFXOPTION_CLAIM_QUEST,  // 32
    GFXOPTION_CHANGEEMAIL,  // 33
    GFXOPTION_DECLINE,  // 34
    GFXOPTION_VIEWPROFILE,  // 35
    GFXOPTION_INVITE,  // 36
    GFXOPTION_REGION,  // 37
    GFXOPTION_CRAFT,  // 38
    GFXOPTION_DISENCHANT,  // 39
    GFXOPTION_REFRESH,  // 40
    GFXOPTION_PLAYERS,  // 41
    GFXOPTION_MASTERYDETAILS,  // 42
    GFXOPTION_HOLDSELECT,  // 43
    GFXOPTION_VIEWCHAMPIONS,  // 44
    GFXOPTION_VIEWSKILLS,  // 45
    GFXOPTION_PURCHASE_INGAME,  // 46
    GFXOPTION_HOLDPURCHASE,  // 47
    GFXOPTION_CLEAR,  // 48
    GFXOPTION_PREVIEW,  // 49
    GFXOPTION_UNLOCK_ANNPACK,  // 50
    GFXOPTION_CHANGE_AUTOBUY,  // 51
    GFXOPTION_DELETELOADOUT,  // 52
    GFXOPTION_TOGGLETAB,  // 53
    GFXOPTION_PLAY,  // 54
    GFXOPTION_INFO,  // 55
    GFXOPTION_CHANGE_TEAMS,  // 56
    GFXOPTION_KICK,  // 57
};

enum GFXEVENT {
    GFXEVENT_CLICK,  // 0
    GFXEVENT_ROLLOVER,  // 1
    GFXEVENT_ROLLOUT,  // 2
};

enum UIBACKGROUNDTYPE {
    UIBT_NONE,  // 0
    UIBT_MAIN,  // 1
    UIBT_CHAMPION,  // 2
    UIBT_DECKS,  // 3
    UIBT_SOCIAL,  // 4
    UIBT_PROFILE,  // 5
    UIBT_LINE,  // 6
    UIBT_PLAIN,  // 7
};

enum UISNAPPINGTYPE {
    UISNAPPING_NONE,  // 0
    UISNAPPING_TOP,  // 1
    UISNAPPING_BOT,  // 2
};

enum UIALIGNINGTYPE {
    UIALIGNING_NONE,  // 0
    UIALIGNING_LEFT,  // 1
    UIALIGNING_RIGHT,  // 2
    UIALIGNING_CENTER,  // 3
};

enum UISCALINGTYPE {
    UISCALING_FITWIDE,  // 0
    UISCALING_FITTALL,  // 1
    UISCALING_OVERSIZE,  // 2
    UISCALING_NONE,  // 3
};

enum UIDISPLAYTYPE {
    UIDISPLAY_ALWAYS,  // 0
    UIDISPLAY_MOUSE,  // 1
    UIDISPLAY_PCONLY,  // 2
    UIDISPLAY_CONSOLE,  // 3
    UIDISPLAY_GAMEPAD,  // 4
};

enum GFXFUNCTIONS {
    GFXFUNC_NONE,  // 0
    GFXFUNC_RESIZE,  // 1
    GFXFUNC_CLASS,  // 2
    GFXFUNC_ANIMATE,  // 3
    GFXFUNC_SKIN,  // 4
    GFXFUNC_INFO,  // 5
    GFXFUNC_SKILL,  // 6
    GFXFUNC_TOOLTIP_ITEM,  // 7
    GFXFUNC_TOOLTIP_CLASS,  // 8
    GFXFUNC_TOOLTIP_SKILL,  // 9
    GFXFUNC_PURCHASE,  // 10
    GFXFUNC_PREVIEW,  // 11
    GFXFUNC_STAT,  // 12
    GFXFUNC_RESET,  // 13
    GFXFUNC_DETAILS,  // 14
    GFXFUNC_JOIN,  // 15
    GFXFUNC_LEAVE,  // 16
    GFXFUNC_KIT,  // 17
    GFXFUNC_ARMOR,  // 18
    GFXFUNC_BACK,  // 19
    GFXFUNC_EXIT,  // 20
    GFXFUNC_SETTINGS,  // 21
    GFXFUNC_MINIMIZE,  // 22
    GFXFUNC_HOME,  // 23
    GFXFUNC_PLAY,  // 24
    GFXFUNC_STORE,  // 25
    GFXFUNC_PROFILE,  // 26
    GFXFUNC_MOUNT,  // 27
    GFXFUNC_SPELL,  // 28
    GFXFUNC_WEAPON,  // 29
    GFXFUNC_ABILITY,  // 30
    GFXFUNC_ENCHANT,  // 31
    GFXFUNC_LEFT,  // 32
    GFXFUNC_RIGHT,  // 33
    GFXFUNC_SELECT,  // 34
    GFXFUNC_GENERAL,  // 35
    GFXFUNC_ADD,  // 36
    GFXFUNC_SUB,  // 37
    GFXFUNC_ADDSPELL,  // 38
    GFXFUNC_ADDWEAPON,  // 39
    GFXFUNC_ADDENCHANT,  // 40
    GFXFUNC_CARD,  // 41
    GFXFUNC_ADDCARD,  // 42
    GFXFUNC_FRIEND,  // 43
    GFXFUNC_ENEMY,  // 44
    GFXFUNC_SAVE,  // 45
    GFXFUNC_LOGIN,  // 46
    GFXFUNC_ACCEPT,  // 47
    GFXFUNC_DECLINE,  // 48
    GFXFUNC_SUBMIT,  // 49
    GFXFUNC_CANCEL,  // 50
    GFXFUNC_TRAINING,  // 51
    GFXFUNC_BATTLE,  // 52
    GFXFUNC_GOLD,  // 53
    GFXFUNC_SILVER,  // 54
    GFXFUNC_FRIENDS,  // 55
    GFXFUNC_ADD_FRIEND,  // 56
    GFXFUNC_INVITE,  // 57
    GFXFUNC_INVITE_ACCEPT,  // 58
    GFXFUNC_INVITE_DECLINE,  // 59
    GFXFUNC_PARTY,  // 60
    GFXFUNC_REMOVE,  // 61
    GFXFUNC_SCROLL,  // 62
    GFXFUNC_OPTION,  // 63
    GFXFUNC_KEY,  // 64
    GFXFUNC_KEYALT,  // 65
    GFXFUNC_KEYBIND,  // 66
    GFXFUNC_CHAT,  // 67
    GFXFUNC_BOOKNONE,  // 68
    GFXFUNC_BOOKSLOT,  // 69
    GFXFUNC_CARDSLOT,  // 70
    GFXFUNC_PREVIOUS,  // 71
    GFXFUNC_NEXT,  // 72
    GFXFUNC_ITEM,  // 73
    GFXFUNC_SELECT_REGION,  // 74
    GFXFUNC_PLAYER,  // 75
    GFXFUNC_SEARCH,  // 76
    GFXFUNC_RESULT,  // 77
    GFXFUNC_UPGRADE,  // 78
    GFXFUNC_ADDENEMY,  // 79
    GFXFUNC_ADDFRIEND,  // 80
    GFXFUNC_REPORTENEMY,  // 81
    GFXFUNC_REPORTFRIEND,  // 82
    GFXFUNC_CHANGE,  // 83
    GFXFUNC_CREATE,  // 84
    GFXFUNC_CREATEGAME,  // 85
    GFXFUNC_HEAD,  // 86
    GFXFUNC_IMPORT,  // 87
    GFXFUNC_CONFIRM,  // 88
    GFXFUNC_INPUT,  // 89
    GFXFUNC_ROTATE,  // 90
    GFXFUNC_MAP,  // 91
    GFXFUNC_TEAM,  // 92
    GFXFUNC_CHANGETEAM,  // 93
    GFXFUNC_REGION,  // 94
    GFXFUNC_SPECTATE,  // 95
    GFXFUNC_DRAFT,  // 96
    GFXFUNC_BOOST,  // 97
    GFXFUNC_EXCLUSIVE,  // 98
    GFXFUNC_EXCLUSIVE_DETAILS,  // 99
    GFXFUNC_CHEST,  // 100
    GFXFUNC_CHESTSCROLL,  // 101
    GFXFUNC_CHESTDETAILS,  // 102
    GFXFUNC_CHESTPURCHASE,  // 103
    GFXFUNC_CHESTBUYBOOSTER,  // 104
    GFXFUNC_CHESTTOGGLEQUANTITY,  // 105
    GFXFUNC_CHESTPICKQUANTITY,  // 106
    GFXFUNC_PURCHASEGEMS,  // 107
    GFXFUNC_VIEWGAMEPAD,  // 108
    GFXFUNC_SHOWFILTER,  // 109
    GFXFUNC_CLEARFILTER,  // 110
    GFXFUNC_FILTER_RARITY,  // 111
    GFXFUNC_FILTER_OPTIONS,  // 112
    GFXFUNC_SELECT_PREVIOUS_SORT,  // 113
    GFXFUNC_SELECT_NEXT_SORT,  // 114
    GFXFUNC_SHOW_QUESTS,  // 115
    GFXFUNC_DISCARD_QUEST_POPUP,  // 116
    GFXFUNC_DISCARD_QUEST,  // 117
    GFXFUNC_REROLL_QUEST,  // 118
    GFXFUNC_HOVER,  // 119
    GFXFUNC_CLAIM_QUEST,  // 120
    GFXFUNC_REFER,  // 121
    GFXFUNC_TOGGLEMUTE,  // 122
    GFXFUNC_EQUIP,  // 123
    GFXFUNC_INTERACTABLE,  // 124
    GFXFUNC_INTERACTABLE_SCROLL,  // 125
    GFXFUNC_TALENT,  // 126
    GFXFUNC_SLIDER,  // 127
    GFXFUNC_TAB,  // 128
    GFXFUNC_CLEAR_ALL,  // 129
    GFXFUNC_CLEAR_ITEM,  // 130
    GFXFUNC_CLEAR_CATEGORY,  // 131
    GFXFUNC_GOTO,  // 132
    GFXFUNC_EQUIPALL,  // 133
    GFXFUNC_CLOSE,  // 134
};

enum GamepadKeys {
    GAMEPAD_NONE,  // 0
    GAMEPAD_BUTTON_A,  // 1
    GAMEPAD_BUTTON_B,  // 2
    GAMEPAD_BUTTON_X,  // 3
    GAMEPAD_BUTTON_Y,  // 4
    GAMEPAD_BUTTON_MENU,  // 5
    GAMEPAD_BUTTON_LB,  // 6
    GAMEPAD_BUTTON_RB,  // 7
    GAMEPAD_BUTTON_LT,  // 8
    GAMEPAD_BUTTON_RT,  // 9
    GAMEPAD_BUTTON_BUMPERS,  // 10
    GAMEPAD_BUTTON_L_STICK,  // 11
    GAMEPAD_BUTTON_R_STICK,  // 12
    GAMEPAD_BUTTON_DPAD_UNPRESSED,  // 13
    GAMEPAD_BUTTON_DPAD_DOWN,  // 14
    GAMEPAD_BUTTON_DPAD_LEFT,  // 15
    GAMEPAD_BUTTON_DPAD_RIGHT,  // 16
    GAMEPAD_BUTTON_DPAD_UP,  // 17
    GAMEPAD_BUTTON_VIEW,  // 18
    GAMEPAD_BUTTON_L_STICK_ALL_AXIS,  // 19
    GAMEPAD_BUTTON_L_STICK_X_AXIS,  // 20
    GAMEPAD_BUTTON_L_STICK_Y_AXIS,  // 21
    GAMEPAD_BUTTON_R_STICK_ALL_AXIS,  // 22
    GAMEPAD_BUTTON_R_STICK_X_AXIS,  // 23
    GAMEPAD_BUTTON_R_STICK_Y_AXIS,  // 24
};

enum LobbyEvent {
    LOBBY_EVENT_ENTER_QUEUE,  // 0
    LOBBY_EVENT_CHAMPION_LOCKED_IN,  // 1
    LOBBY_EVENT_EVERYONE_LOCKED_IN,  // 2
    LOBBY_EVENT_REENTER_LOBBY,  // 3
};

struct UIDisplayData {
    var byte eType;
    var GFxObject pObj;
    structdefaultproperties {}
};

struct UIITEM_CLIP {
    var GFxObject pObj;
    var GFxObject pSelected;
    var GFxObject pButton;
    var GFxObject pSaleBanner;
    structdefaultproperties {}
};

var Class m_UISceneClass;
var UIScene m_UIScene;
var array<TgGfxScene.GFXOPTION> m_OptionList;
var array<UIDisplayData> m_DisplayData;
var array<GFxObject> m_Blockers;
var array<TgGFxGroup> m_Groups;
var array<GFxObject> m_Prompts;
var TgGfxScene.UIALIGNINGTYPE m_ePromptAlignment;
var TgGfxScene.UISCALINGTYPE m_eScalingType;
var TgGfxScene.UISNAPPINGTYPE m_eSnappingType;
var TgGfxScene.UIALIGNINGTYPE m_eAligningType;
var float m_fPromptOffsetX;
var int m_nHighlight;
var int m_nSelectCount;
var int m_nBackground;
var bool m_bBlur;
var bool m_bBlurForeground;
var bool m_bReshow;
var bool m_bHidden;
var bool m_bDisable;
var bool m_bInitData;
var bool m_bVisibleOnLoad;
var bool m_bResetFocusOnShow;
var bool m_bResetHeaderFocusOnShow;
var bool m_bResize;
var bool m_bIsPopup;
var bool m_bDead;
var bool m_bAlwaysTick;
var bool m_bAcceptsInput;
var bool m_bAllowSpectatorClickThru;
var bool m_bShowCursor;
var bool m_bCaptureKeys;
var bool m_bIsOnline;
var bool m_bPushesSceneFromSubscenes;
var bool m_bCanShake;
var bool m_bShouldShake;
var bool m_bAlwaysKeepOpen;
var bool m_bAllowMultipleOnStack;
var bool m_bAllowLeaveQueueKey;
var float m_fScaling;
var float m_fScale;
var float m_fDeltaTime;
var Vector2D m_CachedPosition;
var string m_Name;
var AkBaseSoundObject m_scShown;
var AkBaseSoundObject m_scHighlight;
var int m_nEventFunc;
var int m_nEventType;
var int m_nEventIndex;
var GFxObject m_pFocus;
var TgGameDataHandler m_pData;
var UIGameMoviePlayer m_pMovie;
var UIDataManager m_pUIData;
var GFxObject m_mcHeaderBumper[2];
var TgGFxGroup m_grHeader;
var array<int> m_nFocusedGroupStack;

delegate DelegateEvent(GFxObject pObj, int nEvent);

native function ReceiveEvent(GFxObject pObj, int nEvent);  // Export UTgGfxScene::execReceiveEvent(FFrame&, void* const)

event Focus(GFxObject pObj) { }

event Rollover(GFxObject pObj) { }

event Rollout(GFxObject pObj) { }

event Click(GFxObject pObj) { }

native function Animate(GFxObject pObj, float fTime, UIComponent.UIANIMTYPE eType, float fValue, optional float fDelay=0.0000000, optional byte eQuad=1, optional bool bEndCurrentAnim=true);  // Export UTgGfxScene::execAnimate(FFrame&, void* const)

native function CancelAnim(GFxObject pObj);  // Export UTgGfxScene::execCancelAnim(FFrame&, void* const)

native function EndAnim(GFxObject pObj, UIComponent.UIANIMTYPE eType);  // Export UTgGfxScene::execEndAnim(FFrame&, void* const)

native function bool IsAnimating(GFxObject pObj);  // Export UTgGfxScene::execIsAnimating(FFrame&, void* const)

native function bool IsAnimatingType(GFxObject pObj, UIComponent.UIANIMTYPE eType);  // Export UTgGfxScene::execIsAnimatingType(FFrame&, void* const)

native function FadeIn(GFxObject pObj, optional float fTime=0.1000000, optional float fDelay=0.0000000);  // Export UTgGfxScene::execFadeIn(FFrame&, void* const)

native function FadeOut(GFxObject pObj, optional float fTime=0.1000000, optional float fDelay=0.0000000);  // Export UTgGfxScene::execFadeOut(FFrame&, void* const)

native function Highlight(GFxObject pObj, bool bShow, optional float fTime=0.1000000);  // Export UTgGfxScene::execHighlight(FFrame&, void* const)

native function SlamInAnim(GFxObject pObj, optional float fDelay=0.0000000);  // Export UTgGfxScene::execSlamInAnim(FFrame&, void* const)

native function SlamOutAnim(GFxObject pObj, optional float fDelay=0.0000000);  // Export UTgGfxScene::execSlamOutAnim(FFrame&, void* const)

event HandleAnimState(int nAnimState, optional int nAnimGroup=0) { }

defaultproperties
{
    m_UISceneClass=Class'UIScene'
    m_ePromptAlignment=UIALIGNING_CENTER
    m_nHighlight=-1
    m_bInitData=true
    m_bResetHeaderFocusOnShow=true
    m_bResize=true
    m_bAcceptsInput=true
    m_bAllowSpectatorClickThru=true
    m_bShowCursor=true
    m_bCaptureKeys=true
    m_bAllowMultipleOnStack=true
    m_bAllowLeaveQueueKey=true
    m_fScaling=1.0000000
    m_CachedPosition=(X=-1.0000000,Y=-1.0000000)
    m_scShown=AkEvent'UI_Menu_Panel_SlideIn_Play'
    m_scHighlight=AkEvent'UI_Menu_Checkbox_Off_Play'
}
