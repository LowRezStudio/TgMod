class UIHome extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine)
    dependson(UILandingPanelManager);

const UIHOME_JSONPANELS = 4;

const UIHOME_CAROUSEL_ASPECT_TOLERANCE = 0.1;

const QUEST_PROGRESS_START = 45;

const QUEST_PROGRESS_END = 316;

struct UINavButton {
    var GFxObject pObj;
    var GFxObject pHighlight;
    var GFxObject pCTA;
    var GFxObject pIcon;
    var GFxObject pTitle;
    structdefaultproperties {}
};

var bool m_bQueued;
var bool m_bDeserter;
var bool m_bLoadingImages;
var float m_fQueuedTime;
var GFxObject m_mcPanels;
var UIInteractable_NavPanel_Play m_PlayPanel;
var UIInteractable_NavPanel_Queued m_QueuedPanel;
var UIInteractable_NavPanel m_StorePanel;
var UIInteractable_NavPanel m_ChampionsPanel;
var UIInteractable_NavPanel m_ChestsPanel;
var UIInteractable_NavPanel m_ActivityCenterPanel;
var UIInteractable_NavPanel m_ProfilePanel;
var UIInteractable_NavPanel_Quests m_QuestsPanel;
var UIInteractable_NavPanel_QuestsLocked m_QuestsLockedPanel;
var UIInteractable_JsonPanel_Carousel m_CarouselPanel;
var UIInteractable_JsonPanel m_JsonPanel[4];
var TgGFxGroup m_grHome;
var init array<init JsonFeatureData> m_FeatureData;

defaultproperties
{
    m_bLoadingImages=true
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_OptionList[2]=0
    m_OptionList[3]=0
    m_nBackground=1
    m_bBlur=true
    m_bAlwaysTick=true
    m_Name="UIHome"
}
