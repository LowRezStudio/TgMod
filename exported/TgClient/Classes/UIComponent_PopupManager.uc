class UIComponent_PopupManager extends UIComponent
    native(UIComponent);

struct native PopupInfo
{
    var UIComponent_Popup pPopup;
    var UIData pPopupData;

    structdefaultproperties
    {
        pPopup=none
        pPopupData=none
    }
};

var init array<init PopupInfo> m_PopupStack;
var int m_nCloseCurrentPopupHandle;
var bool m_bAllowPopups;

defaultproperties
{
    m_bAllowPopups=true
}