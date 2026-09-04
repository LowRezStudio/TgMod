class UIInteractable_Item extends UIComponent_Interactable
    native(UIComponent)
    config(Engine);

enum DisplayOverride {
    eDO_None,  // 0
    eDO_Owned,  // 1
    eDO_Unowned,  // 2
};

var GFxObject m_mcPrice;
var GFxObject m_mcGlow;
var GFxObject m_mcCTA;
var protected bool m_bShowChampion;

defaultproperties
{
    m_sLoadName="Talent"
    m_sConstructName="Talent"
}
