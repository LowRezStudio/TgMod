class UIScene_UIPopupPartyManager extends UIScene_SceneAsPopup
    native(UIComponent)
    config(Engine);

const UICOMPONENT_PARTYMANAGERLIST_TITLECOUNT = 2;

const UICOMPONENT_PARTYMANAGERLIST_MEMBERCOUNT = 6;

enum UIPPM_State {
    UIPPM_NONE,  // 0
    UIPPM_PARTYKICK,  // 1
    UIPPM_FRIENDINVITE,  // 2
};

var UIComponent_Interactable m_pCloseButton;
var UIComponent_List m_pList;
var GFxObject m_mcTitle[2];
var UIScene_UIPopupPartyManager.UIPPM_State m_eState;
var int m_nRequiredPartySize;
var Object m_pPostPartyKickResponse;

defaultproperties
{
    m_nRequiredPartySize=-1
}
