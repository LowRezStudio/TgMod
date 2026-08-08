class UIHudCards extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDCARD_SLOTS = 4;

const UIHUDCARD_LOADOUTSIZE = 5;

struct UICardDisplayEntry {
    var GFxObject Obj;
    var GFxObject Card;
    var GFxObject Icon;
    var GFxObject PowerLevel;
    var int DeviceID;
    structdefaultproperties {}
};

struct UICardDisplayGroup {
    var UICardDisplayEntry Items[4];
    var UICardDisplayEntry Cards[5];
    var int LastCardsPawnId;
    structdefaultproperties {}
};

var int m_nCredits;
var int m_nLoadout;
var bool m_bSpectateEnemy;
var float m_fCachedRotationY;
var GFxObject m_grScene;
var GFxObject m_mcCredits;
var GFxObject m_mcLoadout;
var GFxObject m_mcHighlight;
var UICardDisplayGroup m_CardDisplayGroup;

defaultproperties
{
    m_nCredits=-1
    m_nLoadout=-1
    m_fCachedRotationY=-1.0000000
    m_eSnappingType=UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_bCanShake=true
    m_Name="UIHudCards"
}
