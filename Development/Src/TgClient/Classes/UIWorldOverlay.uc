class UIWorldOverlay extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Game);

const UIWORLDOVERLAY_MAXTICKS = 60;

const UIWORLDOVERLAY_HEALTHPERTICK = 250;

enum EDeployableOverlayType {
    EDOT_Targetable,  // 0
    EDOT_Player,  // 1
    EDOT_Deployable,  // 2
};

enum EDeployableOverlayInternalState {
    EDOIS_None,  // 0
    EDOIS_Created,  // 1
    EDOIS_Idle,  // 2
    EDOIS_Active,  // 3
    EDOIS_TimedOut,  // 4
    EDOIS_Destroyed,  // 5
    EDOIS_Inactive,  // 6
};

struct OverlayData {
    var int nId;
    var bool bInit;
    var float fRoll;
    var float fScale;
    var float fTimer;
    var float fAnimX;
    var float fAnimY;
    var float fStartX;
    var float fStartY;
    var Vector vWorldLoc;
    var Vector vScreenLoc;
    var GFxObject pClip;
    structdefaultproperties {}
};

struct UITargetableOverlay {
    var int nLastColorFrame;
    var int nTargetId;
    var bool bInit;
    var bool bEnemy;
    var bool bVisible;
    var bool bOnEdge;
    var bool bHighlight;
    var bool bTraceResult;
    var float fAlpha;
    var float fScale;
    var float fTraceTimer;
    var float fHighlightTimer;
    var Vector vWorldLoc;
    var Vector vScreenLoc;
    var string CachedName;
    var GFxObject pClip;
    var GFxObject pName;
    var GFxObject pCarat;
    var GFxObject pHealingIndicator;
    var GFxObject pIcon;
    var GFxObject pHealthBarParent;
    var UIComponent_HealthBar_Overlay pHealthBar;
    var UIWorldOverlay.EDeployableOverlayType eType;
    structdefaultproperties {}
};

struct UIPlayerOverlay extends UITargetableOverlay {
    var int nMarked;
    var int nStreak;
    var int nUltCharge;
    var float fBarragePercent;
    var GFxObject pMarked;
    var GFxObject pStreak;
    var GFxObject pUltimatePercent;
    var GFxObject pBarrageFrame;
    var GFxObject pBarrageMeter;
    var GFxObject pHuntersMark;
    var GFxObject pLexExecuteMark;
    var GFxObject pLexTargetMark;
    var GFxObject pLexVengeanceMark;
    var GFxObject pLexExecuteGuide;
    var GFxObject pAstroLotus;
    var UIComponent_OracleSoulCharges pSoulCharges;
    var UIComponent_TelepunchTarget pTelepunch;
    var float fHideTimer;
    var bool bInParty;
    var bool bShowPlayerIcon;
    var bool bShowPlayerName;
};

struct UIDeployableOverlay extends UITargetableOverlay {
    var bool bMine;
    var GFxObject pIconParent;
    var GFxObject pLeftArc;
    var GFxObject pRightArc;
    var GFxObject pTopArc;
    var GFxObject pPointer;
    var GFxObject pBarrageFrame;
    var GFxObject pBarrageMeter;
    var float fAnimTime;
    var UIWorldOverlay.EDeployableOverlayInternalState eState;
    var float fDamagePulseTimer;
};

var config bool ShowAllTeamAsParty;
var bool m_bSpectatorShowPlayerIcons;
var int m_nDepth;
var int m_nCritCount;
var int m_nLastValue;
var int m_nLastTargetId;
var int m_nDamageNumberType;
var byte m_eLastTargetType;
var float m_fDelta;
var float m_fRange;
var float m_fInterp;
var float m_fCritSpeed;
var float m_fCritBloom;
var float m_fCritTimer;
var float m_fDamageSpeed;
var float m_fDamageBloom;
var float m_fDamageTimer;
var float m_fStatusTimer;
var float m_fStatusSpeed;
var float m_fStatusBloom;
var float m_fHealingSpeed;
var float m_fHealingBloom;
var float m_fHealingTimer;
var float m_fResolutionModX;
var float m_fResolutionModY;
var array<OverlayData> m_CritData;
var array<OverlayData> m_DamageData;
var array<OverlayData> m_StatusData;
var array<OverlayData> m_HealingData;
var array<UIPlayerOverlay> m_PlayerOverlays;
var array<UIDeployableOverlay> m_DeployableOverlays;

event bool GetScreenCoordinates(float fClipSize, Canvas pCanvas, Vector CameraLocation, Vector CameraRotation, Vector ObjectLocation, out Vector ScreenLocation) { }

defaultproperties
{
    m_fInterp=80.0000000
    m_fCritSpeed=12.0000000
    m_fCritBloom=400.0000000
    m_fCritTimer=1.0000000
    m_fDamageSpeed=12.0000000
    m_fDamageBloom=400.0000000
    m_fDamageTimer=1.0000000
    m_fStatusTimer=1.0000000
    m_fStatusSpeed=20.0000000
    m_fStatusBloom=400.0000000
    m_fHealingSpeed=12.0000000
    m_fHealingBloom=400.0000000
    m_fHealingTimer=1.0000000
    m_fResolutionModX=1.0000000
    m_fResolutionModY=1.0000000
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIWorldOverlay"
}
