class UIComponent_LexVengeance extends UIComponent
    native(UIComponent);

const EMBLEM_ALPHA_TIME = 0.17f;
const EMBLEM_SCALEDOWN_TIME = 0.17f;
const EMBLEM_SCALEUP_TIME = 0.04f;
const EMBLEM_SCALEUP_DELAY = 0.2f;
const EMBLEM_MOVE_TIME = 0.17f;
const EMBLEM_MOVE_DELAY = 0.5f;
const EMBLEM_SHIFTX_LEFT = 840.0f;
const EMBLEM_SHIFTX_RIGHT = 860.0f;
const EMBLEM_POSY = 885.0f;
const EMBLEM_ROULETTE_POSX = 960.0f;
const EMBLEM_ROULETTE_POSY = 747.20f;
const EMBLEM_ROULETTE_SCALE_START = 90.0f;
const BOUNTY_OFFSETX = 31.0f;
const KILLSTREAK_OFFSETX = 32.9f;

var UIComponent_LexTarget m_RouletteTarget;
var UIComponent_LexTarget m_Target;
var GFxObject m_mcBounty;
var GFxObject m_mcKillstreak;
var GFxObject m_mcKillstreakText;
var TgPawn_Lex m_Lex;
var UIDataManager m_pUIData;
var UIDataChampion m_CachedTargetChampion;
var array<TgPawn_Character> m_EnemyPawns;
var float m_Timer;
var float m_TimePerFrame;
var bool m_bRouletteSpinning;
var int m_nRouletteIndex;
var float m_fEmblemXPos;
var AkEvent m_FlipbookSound;
var AkEvent m_LockInSound;
var AkEvent m_SwooshSound;
var AkEvent m_FrontlineComment;
var AkEvent m_DamageComment;
var AkEvent m_SupportComment;
var AkEvent m_FlankComment;

event AnimateEmblem()
{
    EndAnim(m_Target.m_mcRoot);
    EndAnim(m_RouletteTarget.m_mcRoot);
    EndAnim(m_Target.m_mcFrameTop);
    EndAnim(m_RouletteTarget.m_mcFrameTop);
    EndAnim(m_Target.m_mcFrameBottom);
    EndAnim(m_RouletteTarget.m_mcFrameBottom);
    EndAnim(m_mcBounty);
    EndAnim(m_mcKillstreak);
    Animate(m_mcBounty, 0.1500000, 2, 0.0000000, 0.0000000, 1, false);
    Animate(m_mcKillstreak, 0.1500000, 2, 0.0000000, 0.0000000, 1, false);
    m_RouletteTarget.m_mcRoot.SetAlpha(0.0000000);
    m_Target.m_mcRoot.SetX(960.0000000);
    m_Target.m_mcRoot.SetY(747.2000000);
    m_Target.m_mcRoot.SetXScale(90.0000000);
    m_Target.m_mcRoot.SetYScale(90.0000000);
    m_Target.m_mcRoot.SetAlpha(0.0000000);
    m_Target.m_mcFrameTop.SetAlpha(0.0000000);
    m_Target.m_mcFrameBottom.SetAlpha(0.0000000);
    m_Target.m_mcFrameTop.SetY(-300.0000000);
    m_Target.m_mcFrameBottom.SetY(250.0000000);
    Animate(m_Target.m_mcRoot, 0.1000000, 5, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1000000, 6, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1000000, 2, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.0333300, 5, 110.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.0333300, 6, 110.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.0999900, 5, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.0999900, 6, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.1000000, 2, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.1000000, 1, -23.2500000, 0.0000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 1, -15.5000000, 0.1000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0666600, 1, -20.7500000, 0.1333000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 5, 110.0000000, 0.0666600, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0999900, 5, 100.0000000, 0.1000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 6, 105.0000000, 0.0666600, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0666600, 5, 100.0000000, 0.1333000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.1000000, 2, 100.0000000, 0.0000000, 0, false);
    Animate(m_Target.m_mcFrameBottom, 0.1000000, 1, 51.6500000, 0.0000000, 0, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 1, 40.0000000, 1.0000000, byte(0.1000000), false);
    Animate(m_Target.m_mcFrameBottom, 0.0666600, 1, 42.0500000, 0.1333000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 5, 110.0000000, 0.0666600, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0999900, 5, 100.0000000, 0.1000000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 6, 105.0000000, 0.0666600, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0666600, 5, 100.0000000, 0.1333000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 0, m_fEmblemXPos, 0.5000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 1, 885.0000000, 0.5000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 5, 42.0000000, 0.5000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 6, 42.0000000, 0.5000000, 1, false);
    Animate(m_mcBounty, 0.2500000, 2, 100.0000000, 0.5000000 + 0.1700000, 1, false);
    Animate(m_mcBounty, 0.2500000, 0, m_fEmblemXPos + 31.0000000, 0.5000000 + 0.1700000, 1, false);
    Animate(m_mcKillstreak, 0.2500000, 0, m_fEmblemXPos + 32.9000000, 0.5000000 + 0.1700000, 1, false);
    //return;    
}

event AnimateEmblemAbilityActivated()
{
    EndAnim(m_Target.m_mcRoot);
    EndAnim(m_RouletteTarget.m_mcRoot);
    EndAnim(m_Target.m_mcFrameTop);
    EndAnim(m_RouletteTarget.m_mcFrameTop);
    EndAnim(m_Target.m_mcFrameBottom);
    EndAnim(m_RouletteTarget.m_mcFrameBottom);
    EndAnim(m_mcBounty);
    EndAnim(m_mcKillstreak);
    Animate(m_mcBounty, 0.1500000, 2, 0.0000000, 0.0000000, 1, false);
    Animate(m_mcKillstreak, 0.1500000, 2, 0.0000000, 0.0000000, 1, false);
    m_RouletteTarget.m_mcIcon.SetAlpha(75.0000000);
    m_Target.m_mcIcon.SetAlpha(0.0000000);
    m_Target.m_mcRoot.SetAlpha(0.0000000);
    m_Target.m_mcRoot.SetX(960.0000000);
    m_Target.m_mcRoot.SetY(747.2000000);
    m_Target.m_mcRoot.SetXScale(100.0000000);
    m_Target.m_mcRoot.SetYScale(100.0000000);
    m_Target.m_mcFrameTop.SetAlpha(0.0000000);
    m_Target.m_mcFrameBottom.SetAlpha(0.0000000);
    m_Target.m_mcFrameTop.SetY(-300.0000000);
    m_Target.m_mcFrameBottom.SetY(250.0000000);
    m_RouletteTarget.m_mcRoot.SetX(960.0000000);
    m_RouletteTarget.m_mcRoot.SetY(747.2000000);
    m_RouletteTarget.m_mcRoot.SetXScale(90.0000000);
    m_RouletteTarget.m_mcRoot.SetYScale(90.0000000);
    Animate(m_RouletteTarget.m_mcRoot, 0.1000000, 5, 100.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.1000000, 6, 100.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.1000000, 2, 100.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.0333300, 5, 110.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.0333300, 6, 110.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.0999900, 5, 100.0000000, 0.0000000, 1, false);
    Animate(m_RouletteTarget.m_mcRoot, 0.0999900, 6, 100.0000000, 0.0000000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1000000, 2, 100.0000000, 0.8500000, 1, false);
    Animate(m_Target.m_mcIcon, 0.1500000, 2, 100.0000000, 0.8500000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.1000000, 1, -21.9000000, 0.9000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 1, -15.5000000, 1.0000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0666600, 1, -20.7500000, 1.0333000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.1000000, 2, 100.0000000, 0.9000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 5, 110.0000000, 0.9666000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0999900, 5, 100.0000000, 1.0000000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0333300, 6, 105.0000000, 0.9666000, 1, false);
    Animate(m_Target.m_mcFrameTop, 0.0666600, 5, 100.0000000, 1.0333000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.1000000, 1, 51.6500000, 0.9000000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 1, 42.3000000, 1.0000000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0666600, 1, 42.0500000, 1.0333000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.1000000, 2, 100.0000000, 0.9000000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 5, 110.0000000, 0.9666000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0999900, 5, 100.0000000, 1.0000000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0333300, 6, 105.0000000, 0.9666000, 1, false);
    Animate(m_Target.m_mcFrameBottom, 0.0666600, 6, 100.0000000, 1.0333000, 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 0, m_fEmblemXPos, 0.5000000 + float(1), 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 1, 885.0000000, 0.5000000 + float(1), 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 5, 42.0000000, 0.5000000 + float(1), 1, false);
    Animate(m_Target.m_mcRoot, 0.1700000, 6, 42.0000000, 0.5000000 + float(1), 1, false);
    Animate(m_mcBounty, 0.2500000, 2, 100.0000000, (0.5000000 + 0.1700000) + float(1), 1, false);
    Animate(m_mcBounty, 0.2500000, 0, m_fEmblemXPos + 31.0000000, (0.5000000 + 0.1700000) + float(1), 1, false);
    Animate(m_mcKillstreak, 0.2500000, 0, m_fEmblemXPos + 32.9000000, (0.5000000 + 0.1700000) + float(1), 1, false);
    //return;    
}

defaultproperties
{
    m_TimePerFrame=0.1000000
}