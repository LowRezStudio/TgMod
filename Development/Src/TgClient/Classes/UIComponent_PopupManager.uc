class UIComponent_PopupManager extends UIComponent
    native(UIComponent)
    config(Engine);

struct PopupInfo {
    var UIComponent_Popup pPopup;
    var UIData pPopupData;
    structdefaultproperties {}
};

var init array<init PopupInfo> m_PopupStack;
var int m_nCloseCurrentPopupHandle;
var bool m_bAllowPopups;

defaultproperties
{
    m_bAllowPopups=true
}
