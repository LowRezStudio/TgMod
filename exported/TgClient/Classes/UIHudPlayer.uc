class UIHudPlayer extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

var int m_nStreak;
var int m_nProfile;
var bool m_bInCombat;
var bool m_bShowCombat;
var bool m_bSpectateEnemy;
var float m_fCombatTime;
var float m_fCombatPercent;
var float m_CachedRotation;
var GFxObject m_mcIcon;
var GFxObject m_grScene;
var UIComponent_HealthBar_Player m_HealthBar;
var GFxObject m_mcCombat;
var GFxObject m_mcCombatBar;
var GFxObject m_mcStreak;
var GFxObject m_mcStreakBack;
var GFxObject m_mcStreakTitle;
var GFxObject m_mcStreakSubtitle;
var GFxObject m_mcDebugText;
var init string m_sSpectatorName;
var init string m_sSpectatorTeam;
var GFxObject m_mcSpectatorGroup;
var GFxObject m_mcSpectatorNameTF;
var GFxObject m_mcSpectatorTeam;
var GFxObject m_mcSpectatorTeamAdd;
var GFxObject m_mcSpectatorBG;

defaultproperties
{
    m_CachedRotation=-1.0000000
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_bCanShake=true
    m_Name="UIHudPlayer"
}