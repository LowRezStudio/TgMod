class UIComponent_TitlesView extends UIComponent
    native(UIComponent)
    config(Engine);

var protected array<UIComponent_TitlesViewEntry> m_TitleEntries;
var protected TgGFxGroup m_grTitlesGroup;
var protected GFxObject m_mcTitle;
var protected GFxObject m_mcPlayerTitle;
var protected UIInteractable_Button m_pEquipButton;
var protected UIComponent_TitleTooltip m_pTooltipLeft;
var protected UIComponent_TitleTooltip m_pTooltipRight;
var protected UIComponent_ScrollBar m_pScrollbar;
var protected int m_nLastTooltipIndex;
var const int m_nNumTitlesRows;
var const int m_nNumTitlesCols;

native function FadeIn(GFxObject pObj, optional float fTime=0.0500000, optional float fDelay=0.0000000);  // Export UUIComponent_TitlesView::execFadeIn(FFrame&, void* const)

native function FadeOut(GFxObject pObj, optional float fTime=0.0500000, optional float fDelay=0.0000000);  // Export UUIComponent_TitlesView::execFadeOut(FFrame&, void* const)

defaultproperties
{
    m_nNumTitlesRows=8
    m_nNumTitlesCols=2
    m_sLoadName="Titles"
}
