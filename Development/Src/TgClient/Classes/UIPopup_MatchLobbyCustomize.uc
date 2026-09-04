class UIPopup_MatchLobbyCustomize extends UIComponent_Popup
    native(UIComponent)
    config(Engine)
    dependson(UIData_LobbySlotItem);

var float m_fStateTimerOut;
var float m_fStateTimerIn;
var int m_nPendingFocus;
var GFxObject m_mcTitle;
var GFxObject m_mcSubtitle;
var GFxObject m_mcClassIcon;
var GFxObject m_mcAutoBuyPrompt;
var UIComponent_Toggle m_AutoBuyToggle;
var UIInteractable_Button m_BackButton;
var UIInteractable_Button m_PrevButton;
var UIInteractable_Button m_NextButton;
var UIComponent_List m_ItemList;
var UIData_LobbySlotItem m_pPurchase;
var UIData_LobbySlotItem.UIChampionCustomizeState m_eState;

defaultproperties
{
    m_sLoadName="Champion"
}
