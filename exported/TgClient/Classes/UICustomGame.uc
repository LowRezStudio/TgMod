class UICustomGame extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    implements(DelayQueueInterface);

const UICUSTOM_MAPS = 9;
const UICUSTOM_MODES = 3;
const UICUSTOM_GAMES = 7;
const UICUSTOM_SLOTS = 6;
const UICUSTOM_ARROWS = 2;

enum UICustomGameState
{
    UICGS_GAME_LIST,                // 0
    UICGS_CREATING_MAP,             // 1
    UICGS_CREATING_SETTINGS,        // 2
    UICGS_JOINING,                  // 3
    UICGS_LOBBY,                    // 4
    UICGS_GAME_STARTING,            // 5
    UICGS_MAX                       // 6
};

struct native UICustomMapQueue
{
    var int nQueueId;
    var int nMapId;
    var int nName;
    var init string sName;
    var TgObject.TG_GAME_TYPE eGameType;

    structdefaultproperties
    {
        nQueueId=0
        nMapId=0
        nName=0
        sName=""
        eGameType=TG_GAME_TYPE.TGT_UNSET
    }
};

struct native UICustomGameData
{
    var int nId;
    var int nName;
    var int nDraft;
    var int nTotal;
    var int nPlayers;
    var int nMaxPartySizeToJoin;
    var dword dwRegion;
    var bool bPrivate;
    var init string sName;
    var init string sMap;
    var init string sGameMode;
    var init string sOwner;
    var init string sQueueName;
    var TgObject.TG_GAME_TYPE eGameType;

    structdefaultproperties
    {
        nId=0
        nName=0
        nDraft=0
        nTotal=0
        nPlayers=0
        nMaxPartySizeToJoin=0
        dwRegion=()
        bPrivate=false
        sName=""
        sMap=""
        sGameMode=""
        sOwner=""
        sQueueName=""
        eGameType=TG_GAME_TYPE.TGT_UNSET
    }
};

var private native const noexport Pointer VfTable_IDelayQueueInterface;
var int m_nMapIndex;
var int m_nTeamIndex;
var int m_nDraftIndex;
var int m_nQueueIndex;
var int m_nRegionIndex;
var int m_nScrollIndex;
var int m_nSpectateIndex;
var bool m_bValidJoin;
var bool m_bValidCreate;
var UICustomGame.UICustomGameState m_eState;
var GFxObject m_mcHeader;
var GFxObject m_mcHeaderBack;
var GFxObject m_mcHeaderTitle;
var GFxObject m_mcGames;
var GFxObject m_mcGamesCreate;
var GFxObject m_mcGamesCreateKey;
var GFxObject m_mcGamesRefresh;
var GFxObject m_mcGamesScrollBar;
var GFxObject m_mcGame[7];
var GFxObject m_mcGameJoin[7];
var GFxObject m_mcGameLock[7];
var GFxObject m_mcGameName[7];
var GFxObject m_mcGameDraft[7];
var GFxObject m_mcGameOwner[7];
var GFxObject m_mcGameMode[7];
var GFxObject m_mcGameMap[7];
var GFxObject m_mcGamePlayers[7];
var TgGFxGroup m_grGames;
var GFxObject m_mcCreate;
var GFxObject m_mcCreateMapMode;
var GFxObject m_mcCreateSettings;
var GFxObject m_mcCreateDone;
var GFxObject m_mcCreateCancel;
var GFxObject m_mcCreateMap[9];
var GFxObject m_mcCreateMapIcon[9];
var GFxObject m_mcCreateMapName[9];
var UIInteractable_Button m_mcCreateModeTab[3];
var GFxObject m_mcCreateBumper[2];
var GFxObject m_mcCreateScrollBar;
var GFxObject m_mcCreateSettingName;
var GFxObject m_mcCreateSettingNameHighlight;
var GFxObject m_mcCreateSettingPass;
var GFxObject m_mcCreateSettingPassHighlight;
var GFxObject m_mcCreateSettingDraft;
var GFxObject m_mcCreateSettingDraftHighlight;
var GFxObject m_mcCreateSettingDraftArrow[2];
var GFxObject m_mcCreateSettingRegion;
var GFxObject m_mcCreateSettingRegionHighlight;
var GFxObject m_mcCreateSettingRegionArrow[2];
var GFxObject m_mcCreateSettingSpectate;
var GFxObject m_mcCreateSettingSpectateHighlight;
var GFxObject m_mcCreateSettingSpectateArrow[2];
var GFxObject m_mcCreateSettingTeamSize;
var GFxObject m_mcCreateSettingTeamSizeHighlight;
var GFxObject m_mcCreateSettingTeamSizeArrow[2];
var GFxObject m_mcCreateSettingSpectatePass;
var GFxObject m_mcCreateSettingSpectatePassHighlight;
var GFxObject m_mcCreateSettingMap;
var GFxObject m_mcCreateSettingMapIcon;
var GFxObject m_mcCreateSettingMapName;
var GFxObject m_mcCreateSettingMapMode;
var TgGFxGroup m_grCreateMaps;
var TgGFxGroup m_grCreateSettings;
var GFxObject m_mcLobby;
var GFxObject m_mcLobbyName;
var GFxObject m_mcLobbyDone;
var GFxObject m_mcLobbyDraft;
var GFxObject m_mcLobbyCancel;
var GFxObject m_mcLobbyRegion;
var GFxObject m_mcLobbyMapIcon;
var GFxObject m_mcLobbyMapName;
var GFxObject m_mcLobbyMapMode;
var GFxObject m_mcLobbySpectate;
var GFxObject m_mcLobbyStarting;
var GFxObject m_mcLobbyTeamSize;
var GFxObject m_mcLobbyMapDetails;
var GFxObject m_mcLobbyRed[6];
var GFxObject m_mcLobbyRedName[6];
var GFxObject m_mcLobbyRedEquipableTitle[6];
var GFxObject m_mcLobbyRedLevel[6];
var GFxObject m_mcLobbyRedLeader[6];
var UIInteractable_Button m_mcLobbyRedFrame[6];
var UIInteractable_Button m_mcLobbyRedKick[6];
var GFxObject m_mcLobbyRedSwap[6];
var GFxObject m_mcLobbyBlue[6];
var GFxObject m_mcLobbyBlueName[6];
var GFxObject m_mcLobbyBlueEquipableTitle[6];
var GFxObject m_mcLobbyBlueLevel[6];
var GFxObject m_mcLobbyBlueLeader[6];
var UIInteractable_Button m_mcLobbyBlueFrame[6];
var UIInteractable_Button m_mcLobbyBlueKick[6];
var GFxObject m_mcLobbyBlueSwap[6];
var TgGFxGroup m_grLobby;
var GFxObject m_mcPopup;
var GFxObject m_mcPopupDone;
var GFxObject m_mcPopupTitle;
var GFxObject m_mcPopupCancel;
var GFxObject m_mcPopupSubtitle;
var GFxObject m_mcPopupInput;
var TgGFxGroup m_grPopup;
var array<UICustomMapQueue> m_FilteredCustomMapQueues;
var array<UICustomGameData> m_FilteredCustomGames;
var array<UICustomMapQueue> m_RawCustomMapQueues;
var array<UICustomGameData> m_RawCustomGames;
var int m_nCustomGamesListRegionIndex;
var UIComponent_Dropdown m_RegionDropdown;
var int m_nCurrentGameTypeIndex;
var int m_nHighlightedPlayerIndex;
var int m_nHighlightedPlayerTaskforce;
var dword m_dwPendingHighlightPlayerId;

defaultproperties
{
    m_nCustomGamesListRegionIndex=-1
    m_UISceneClass=Class'TgClient.UIScene_UICustomGame'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_OptionList[3]=0
    m_OptionList[4]=0
    m_OptionList[5]=0
    m_OptionList[6]=0
    m_nBackground=1
    m_bBlur=true
    m_bIsOnline=true
    m_bAllowLeaveQueueKey=false
    m_Name="UICustomGame"
}