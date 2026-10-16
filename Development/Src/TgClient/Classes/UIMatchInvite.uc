class UIMatchInvite extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIMATCHINVITE_PLAYERS = 10;

var int m_nAccepted;
var bool m_bFailed;
var bool m_bAccepted;
var float m_fTimerWidth;
var float m_fTimeoutTime;
var float m_fTimeoutTimer;
var float m_fFailedTime;
var float m_fFailedTimer;
var float m_fInviteGracePeriod;
var GFxObject m_mcStandard;
var GFxObject m_mcStandardFade;
var GFxObject m_mcStandardBacks;
var GFxObject m_mcStandardTimer;
var GFxObject m_mcStandardTimerBack;
var GFxObject m_mcStandardButton;
var GFxObject m_mcStandardBlocker;
var GFxObject m_mcStandardWaiting;
var GFxObject m_mcStandardJoining;
var GFxObject m_mcStandardSpinner;
var GFxObject m_mcStandardSubtitle;
var GFxObject m_mcStandardFailedTF;
var GFxObject m_mcStandardPrompt;
var GFxObject m_mcStandardPlayer[10];
var GFxObject m_mcStandardFailed[10];
var GFxObject m_mcVote;
var GFxObject m_mcVoteFade;
var GFxObject m_mcVoteTimer;
var GFxObject m_mcVoteTimerBack;
var GFxObject m_mcVoteTitle;
var GFxObject m_mcVoteButton[4];
var GFxObject m_mcVoteBox[4];
var GFxObject m_mcVoteBoxName[4];
var GFxObject m_mcVoteBoxGame[4];
var GFxObject m_mcVoteBoxShadow[4];
var GFxObject m_mcVoteBlocker;
var GFxObject m_mcVoteWaiting;
var GFxObject m_mcVoteJoining;
var GFxObject m_mcVoteSpinner;
var GFxObject m_mcVoteSubtitle;
var GFxObject m_mcVoteFailedTF;
var GFxObject m_mcVotePlayer[10];
var GFxObject m_mcVoteFailed[10];
var TgGFxGroup m_grScene;
var AkBaseSoundObject m_akShown;
var AkBaseSoundObject m_akSelect;
var ForceFeedbackWaveform m_QueuePopWaveform;

defaultproperties
{
    m_fTimeoutTime=30.0000000
    m_fFailedTime=5.0000000
    m_fInviteGracePeriod=1.0000000
    m_akShown=AkEvent'UI_Lobby_MatchFound_Play'
    m_akSelect=AkEvent'UI_Lobby_MatchInvite_PlayerJoin_Play'
    m_QueuePopWaveform=ForceFeedbackWaveform'QueuePopForceFeedback'
    m_UISceneClass=Class'UIScene_SceneAsPopup'
    m_OptionList[0]=1
    m_nBackground=1
    m_bBlur=true
    m_bIsPopup=true
    m_Name="UIMatchInvite"
}
