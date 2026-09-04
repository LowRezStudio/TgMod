class UIComponent_LexVengeance extends UIComponent
    native(UIComponent)
    config(Engine);

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

event AnimateEmblem() { }

event AnimateEmblemAbilityActivated() { }

defaultproperties
{
    m_TimePerFrame=0.1000000
}
