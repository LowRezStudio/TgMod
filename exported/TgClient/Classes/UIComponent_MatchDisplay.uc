class UIComponent_MatchDisplay extends UIComponent
    native(UIComponent);

const UICOMPONENT_MATCHDISPLAY_BUILDHEADERS_COUNT = 6;
const UICOMPONENT_MATCHDISPLAY_STATSHEADERS_COUNT = 9;
const UICOMPONENT_MATCHDISPLAY_PLAYERS_COUNT = 10;

enum EUICMatchDisplayTabType
{
    EUICMDT_Stats,                  // 0
    EUICMDT_Build,                  // 1
    EUICMDT_MAX                     // 2
};

var GFxObject m_mcBuildHeader;
var GFxObject m_mcStatsHeader;
var UIComponent_List m_pList;
var UIComponent_MatchDisplay.EUICMatchDisplayTabType m_eDisplayMode;
