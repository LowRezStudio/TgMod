class UIComponent_ItemTooltip extends UIComponent
    native(UIComponent)
    config(Engine);

var protected GFxObject m_mcTitle;
var protected GFxObject m_mcSubtitle;
var protected GFxObject m_mcDescription;
var int m_nLastSetItemID;

defaultproperties
{
    m_sLoadName="Tooltip"
}
