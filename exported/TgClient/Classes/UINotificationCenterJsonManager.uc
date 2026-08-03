class UINotificationCenterJsonManager extends PComUIManagerBase
    native;

struct native TabInfo
{
    var init string sTitle;
    var init string sUrl;

    structdefaultproperties
    {
        sTitle=""
        sUrl=""
    }
};

var array<TabInfo> m_WebPanelUrls;
var UIGameMoviePlayer m_pMovie;
