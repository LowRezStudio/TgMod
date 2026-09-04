class UIHudRecap extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDRECAP_PLAYERS = 3;

var int m_nRespawnTime;
var bool m_bRecap;
var bool m_bRespawning;
var bool m_bHaveDeathData;
var GFxObject m_mcSkipKillcamPrompt;
var GFxObject m_mcRecap;
var GFxObject m_mcRecapMask[3];
var GFxObject m_mcRecapPlayer[3];
var GFxObject m_mcTopBar;
var GFxObject m_mcBotBar;
var GFxObject m_mcTopShadow;
var GFxObject m_mcBotShadow;
var GFxObject m_mcViewRecapPrompt;
var GFxObject m_mcRespawn;
var GFxObject m_mcButtonTF;
var GFxObject m_mcRespawnTF;
var GFxObject m_mcPlayer[3];

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_Name="UIHudRecap"
}