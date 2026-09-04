class UIHudNotify extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

struct NotifyData {
    var int nIcon;
    var int nMsgId;
    var int nSound;
    var int nTaskForce;
    var bool bLocal;
    var bool bFriend;
    var init string sSource;
    var init string sTarget;
    var init string sMessage;
    structdefaultproperties {}
};

var float m_fDisplayTimer;
var float m_fKillTime;
var float m_fKillTimer;
var float m_fAlertTime;
var float m_fAlertTimer;
var float m_fAccoladeTime;
var float m_fAccoladeTimer;
var NotifyData m_NewData;
var GFxObject m_mcNotify;
var GFxObject m_mcNotifyTF;
var GFxObject m_mcTeamTF;
var bool m_bRejectMessages;
var AkBaseSoundObject m_scCaptured;
var AkBaseSoundObject m_scGateDestroyed;
var AkBaseSoundObject m_scSiegeDestroyed;
var AkBaseSoundObject m_scGettingCaptured;
var array<NotifyData> m_Kills;
var array<NotifyData> m_Alerts;
var array<NotifyData> m_Accolades;

defaultproperties
{
    m_fKillTime=2.0000000
    m_fAlertTime=2.0000000
    m_fAccoladeTime=2.0000000
    m_scCaptured=AkEvent'UI_InGame_Alert_Point_Captured_1P_Play'
    m_scGateDestroyed=AkEvent'UI_InGame_Alert_Gate_Destroyed_1P_Play'
    m_scSiegeDestroyed=AkEvent'UI_InGame_Alert_Siege_Destroyed_1P_Play'
    m_scGettingCaptured=AkEvent'UI_InGame_Alert_Point_Getting_Captured_1P_Play'
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudNotify"
}
