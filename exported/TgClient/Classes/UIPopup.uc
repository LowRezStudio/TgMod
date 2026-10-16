class UIPopup extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

defaultproperties
{
    m_UISceneClass=Class'TgClient.UIScene_UIPopupGeneric'
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_nBackground=1
    m_bBlur=true
    m_bIsPopup=true
    m_bAlwaysTick=true
    m_bAllowSpectatorClickThru=false
    m_Name="UIPopup"
}