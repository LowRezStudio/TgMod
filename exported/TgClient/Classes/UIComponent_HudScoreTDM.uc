class UIComponent_HudScoreTDM extends UIComponent
    native(UIComponent);

var int m_nTimeRemaining;
var int m_nMaxScore;
var int m_nScoreA;
var int m_nScoreB;
var GFxObject m_mcTDMTitle;
var GFxObject m_mcTDMTime;
var GFxObject m_mcTDMSubtitle;
var GFxObject m_mcTDMScoreA;
var GFxObject m_mcTDMScoreAScore;
var GFxObject m_mcTDMScoreAScoreTextAnim;
var GFxObject m_mcTDMScoreAScoreTF;
var GFxObject m_mcTDMScoreAScoreAnim;
var GFxObject m_mcTDMScoreAProgress;
var GFxObject m_mcTDMScoreAProgressAnim;
var GFxObject m_mcTDMScoreAProgressAnimAnim;
var GFxObject m_mcTDMScoreB;
var GFxObject m_mcTDMScoreBScore;
var GFxObject m_mcTDMScoreBScoreTextAnim;
var GFxObject m_mcTDMScoreBScoreTF;
var GFxObject m_mcTDMScoreBScoreAnim;
var GFxObject m_mcTDMScoreBProgress;
var GFxObject m_mcTDMScoreBProgressAnim;
var GFxObject m_mcTDMScoreBProgressAnimAnim;
var float m_fTDMScoreATextAnchorX;
var float m_fTDMScoreBTextAnchorX;
var int m_nTaskForceAhead;
var bool m_bFriendlyTaskForceClose;
var bool m_bEnemyTaskForceClose;
var AkEvent m_MatchAlmostOverAkEvent;

defaultproperties
{
    m_MatchAlmostOverAkEvent=AkEvent'WW_UI_Default.UI_InGame_Alert_Onslaught_MatchAlmostOver_Play'
}