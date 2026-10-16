class UIComponent_ScrollBar extends UIComponent_Interactable
    native(UIComponent);

var protected int m_nPageHeight;
var protected int m_nPageWidth;
var protected int m_nNumElements;
var protected float m_fScrollPos;
var protected int m_nNavScrollCBHandle1;
var protected int m_nNavScrollCBHandle2;
var protected TgGFxGroup m_grScroll;
var protected bool m_bScrollVertical;

defaultproperties
{
    m_bScrollVertical=true
}