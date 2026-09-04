class UIInputPopup extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

defaultproperties
{
    m_UISceneClass=Class'UIScene_UIPopupInput'
    m_bBlur=true
    m_bIsPopup=true
    m_bAllowSpectatorClickThru=false
    m_Name="UIInputPopup"
}
