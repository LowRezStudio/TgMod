class UIHudScore extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

struct native PayloadStatus
{
    var GFxObject PayloadStatusCon;
    var GFxObject Diamond;
    var GFxObject DiamondTint;
    var GFxObject DashForward;
    var GFxObject DashBackward;
    var float fTargetDashFAlpha;
    var float fTargetDashBAlpha;
    var float fTargetTintAlpha;
    var int nTargetTintFrame;
    var GFxObject PayloadContestedCon;
    var GFxObject ContestedTF;
    var GFxObject ContestedLeft;
    var GFxObject ContestedRight;
    var float fTargetContestedAlpha;

    structdefaultproperties
    {
        PayloadStatusCon=none
        Diamond=none
        DiamondTint=none
        DashForward=none
        DashBackward=none
        fTargetDashFAlpha=0.0000000
        fTargetDashBAlpha=0.0000000
        fTargetTintAlpha=0.0000000
        nTargetTintFrame=0
        PayloadContestedCon=none
        ContestedTF=none
        ContestedLeft=none
        ContestedRight=none
        fTargetContestedAlpha=0.0000000
    }
};

var const float m_fPayloadProgressWidth;
var const float m_fPayloadProgressBuffer;
var int m_nTime;
var int m_nScoreA;
var int m_nScoreB;
var int m_nTicketsFriend;
var int m_nTicketsEnemy;
var int m_nOvertime;
var int m_nPushTime;
var int m_nSetupTime;
var int m_nCaptureA;
var int m_nCaptureB;
var int m_nCaptureTeam;
var int m_nCaptureCount;
var int m_nOvertimeState;
var int m_nTimeRemaining;
var bool m_bPushing;
var bool m_bOvertime;
var bool m_bStarting;
var bool m_bCapturing;
var bool m_bCaptureOvertime;
var bool m_bUseSubtitlePrompt;
var float m_fOvertime;
var float m_fPushTimer;
var float m_fSetupTimer;
var float m_fOvertimeDuration;
var array<GFxObject> m_movieClips;
var GFxObject m_mcSiege;
var GFxObject m_mcSiegeTime;
var GFxObject m_mcSiegeMaxA;
var GFxObject m_mcSiegeMaxB;
var GFxObject m_mcSiegeScoreA;
var GFxObject m_mcSiegeScoreB;
var GFxObject m_mcTicketsFriend;
var GFxObject m_mcTicketsEnemy;
var GFxObject m_mcSiegeScoreFrame;
var GFxObject m_mcSiegePush;
var GFxObject m_mcSiegePushBar;
var GFxObject m_mcSiegePushTip;
var GFxObject m_mcSiegePushTime;
var GFxObject m_mcSiegePushOvertime;
var GFxObject m_mcSiegePushOvertimeBar;
var GFxObject m_mcSiegeCapture;
var GFxObject m_mcSiegeCaptureBarA;
var GFxObject m_mcSiegeCaptureBarB;
var GFxObject m_mcSiegeCaptureIcon;
var GFxObject m_mcSiegeCaptureCount;
var GFxObject m_mcSiegeCaptureScoreA;
var GFxObject m_mcSiegeCaptureScoreB;
var GFxObject m_mcSiegeCaptureOvertime;
var GFxObject m_mcSiegeCaptureOvertimeBar;
var PayloadStatus m_SiegePayloadStatus;
var GFxObject m_mcSiegePushContested;
var GFxObject m_mcSiegePushContestedTF;
var GFxObject m_mcPayload;
var GFxObject m_mcPayloadTime;
var GFxObject m_mcPayloadTitle;
var GFxObject m_mcPayloadScoreA;
var GFxObject m_mcPayloadScoreB;
var GFxObject m_mcPayloadScoreFrame;
var GFxObject m_mcPayloadPush;
var GFxObject m_mcPayloadPushBar;
var GFxObject m_mcPayloadPushTip;
var GFxObject m_mcPayloadPushTime;
var GFxObject m_mcPayloadPushMarker;
var GFxObject m_mcPayloadPushOvertime;
var GFxObject m_mcPayloadPushOvertimeBar;
var PayloadStatus m_PayloadPayloadStatus;
var GFxObject m_mcPayloadPushContested;
var GFxObject m_mcPayloadPushContestedTF;
var GFxObject m_mcActivation;
var GFxObject m_mcActivationTF;
var GFxObject m_mcActivationTitle;
var string m_szCurrentPersistentTitle;
var string m_szCurrentPersistentSubtitle;
var GFxObject m_mcPersistentTitle;
var GFxObject m_mcPersistentSubtitle;
var GFxObject m_mcPersistentSubtitlePrompt;
var GFxObject m_mcTutorialPrompt;
var GFxObject m_mcTutorialPromptBack;

defaultproperties
{
    m_fPayloadProgressWidth=324.0000000
    m_fPayloadProgressBuffer=-162.0000000
    m_nTime=-1
    m_nScoreA=-1
    m_nScoreB=-1
    m_nOvertime=999
    m_nPushTime=999
    m_nSetupTime=-1
    m_nCaptureA=-1
    m_nCaptureB=-1
    m_nCaptureTeam=-1
    m_nCaptureCount=-1
    m_nOvertimeState=-1
    m_bStarting=true
    m_fPushTimer=-1.0000000
    m_UISceneClass=Class'TgClient.UIScene_UIHudScore'
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_TOP
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudScore"
}