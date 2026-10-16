class TgGfxTeamInvite extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIINVITE_BUTTONS = 2;
const UIINVITE_INVITESPAM_PERIOD = 2.6;
const UIINVITE_INVITECOUNTER_MAXLEN = 64;

var int m_nQueue;
var float m_fTimerWidth;
var float m_fTimeoutTime;
var float m_fTimeoutTimer;
var GFxObject m_mcTimer;
var GFxObject m_mcSubtitle;
var GFxObject m_mcButton[2];
var native map{VOID,VOID} m_fInviteTimestamps;

defaultproperties
{
    m_fTimeoutTime=30.0000000
    m_UISceneClass=Class'TgClient.UIScene_SceneAsPopup'
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UITeamInvite"
}