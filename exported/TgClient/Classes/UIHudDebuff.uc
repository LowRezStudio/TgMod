class UIHudDebuff extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDBUFFS_COUNT = 3;

var int m_nGroup[16];
var GFxObject m_mcDebuff[3];
var GFxObject m_mcDebuffTF[3];
var GFxObject m_mcDebuffIcon[3];
var GFxObject m_mcDebuffTimer[3];
var GFxObject m_mcDebuffTimerBar[3];

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudDebuff"
}