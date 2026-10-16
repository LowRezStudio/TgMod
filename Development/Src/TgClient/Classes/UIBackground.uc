class UIBackground extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIBACKGROUND_TYPES = 8;

var byte m_eState;
var float m_fAnimationDelay;
var float m_fAnimationTimer;
var GFxObject m_mcAnimation;
var GFxObject m_mcImage[8];

defaultproperties
{
    m_fAnimationDelay=10.0000000
    m_bVisibleOnLoad=true
    m_Name="UIBackground"
}
