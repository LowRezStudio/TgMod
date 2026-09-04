class UIComponent_TitleTooltip extends UIComponent
    native(UIComponent);

var protected GFxObject m_mcIcon;
var protected GFxObject m_mcDescription;
var protected int m_nLastSetItemID;
var const float m_fTooltipShowDelay;

defaultproperties
{
    m_fTooltipShowDelay=0.5000000
}