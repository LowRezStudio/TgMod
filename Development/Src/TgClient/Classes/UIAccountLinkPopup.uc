class UIAccountLinkPopup extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var init string m_sUserEmail;

event SetOSSRecordingEnabled(bool bEnabled) { }

defaultproperties
{
    m_UISceneClass=Class'UIScene_UIAccountLink'
    m_OptionList[0]=245
    m_OptionList[1]=3
    m_OptionList[2]=0
    m_bIsPopup=true
    m_Name="UIAccountLinkPopup"
}
