class UIPopup_MatchLobbyCustomizeNew extends UIComponent_Popup
    native(UIComponent);

var float m_fStateTimerOut;
var float m_fStateTimerIn;
var bool m_bDimmedItemSlots;
var GFxObject m_mcChampionItemSelect;
var UIInteractable_Button m_BackButton;
var UIInteractable_Button m_CollectionsButton;
var UIInteractable_Button m_PreviousButton;
var UIInteractable_Button m_NextButton;
var GFxObject m_mcCollectionsButtonSelected;
var GFxObject m_mcNoCollectionsTF;
var TgGFxGroup m_grEquipSlots;
var UIComponent_List m_EquipSlotList;
var UIComponent_List m_ItemList;
var UIData_LobbySlotItem m_pPurchase;
var GFxObject m_mcAutoBuyPrompt;
var UIComponent_Toggle m_AutoBuyToggle;
var UIData_LobbySlotItem.UIChampionCustomizeState m_eState;
var UIData_LobbySlotItem.UIChampionCustomizeState m_eSelectedSlot;

defaultproperties
{
    m_sLoadName="ChampionNew"
}