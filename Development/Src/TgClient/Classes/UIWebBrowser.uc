class UIWebBrowser extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var bool m_bAutoClose;
var bool m_bDrawBorder;
var GFxObject m_mcFrame;
var GFxObject m_mcBrowserShape;
var GFxObject m_mcBackButton;
var GFxObject m_mcForwardButton;
var GFxObject m_mcCloseButton;

defaultproperties
{
    m_OptionList[0]=14
    m_OptionList[1]=4
    m_eScalingType=UISCALING_FITTALL
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UIWebBrowser"
}
