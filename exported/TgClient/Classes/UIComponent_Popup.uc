class UIComponent_Popup extends UIComponent_Interactable
    native(UIComponent);

var UIComponent m_pItem;
var TgGFxGroup m_grScene;
var int m_nCallbackOnBackHandle;
var bool m_bCanHidePopup;
var bool m_bFadeWithShowHide;

defaultproperties
{
    m_bCanHidePopup=true
    m_bFadeWithShowHide=true
}