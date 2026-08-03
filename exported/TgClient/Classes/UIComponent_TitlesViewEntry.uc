class UIComponent_TitlesViewEntry extends UIComponent_Interactable
    native(UIComponent);

var int m_nTitleId;
var protected GFxObject m_mcRarityText;
var protected GFxObject m_mcColorBlock;
var protected GFxObject m_mcFade;
var protected GFxObject m_mcTitle;
var protected GFxObject m_mcLockIcon;
var protected GFxObject m_mcSelected;
var protected GFxObject m_mcEquipped;
var protected AkBaseSoundObject m_scEquip;
var protected AkBaseSoundObject m_scUnequip;
var protected AkBaseSoundObject m_scNotOwned;

defaultproperties
{
    m_scEquip=AkEvent'WW_UI_Default.UI_Menu_Main_OnClick_Positive_Play'
    m_scUnequip=AkEvent'WW_UI_Default.UI_Menu_Main_OnClick_Negative_Play'
    m_scNotOwned=AkEvent'WW_UI_Default.UI_Menu_Main_OnHover_Small_Play'
    m_sLoadName="Entry"
}