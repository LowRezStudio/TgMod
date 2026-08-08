class UIMenuManager extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var UIComponent_PopupManager m_pPopupManager;

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bResize=false
    m_bAlwaysKeepOpen=true
    m_Name="UIMenuManager"
}
