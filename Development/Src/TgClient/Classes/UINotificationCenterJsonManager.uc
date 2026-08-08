class UINotificationCenterJsonManager extends PComUIManagerBase
    native
    config(Engine);

struct TabInfo {
    var init string sTitle;
    var init string sUrl;
    structdefaultproperties {}
};

var array<TabInfo> m_WebPanelUrls;
var UIGameMoviePlayer m_pMovie;
