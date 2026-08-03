class UIHudCards extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDCARD_SLOTS = 4;
const UIHUDCARD_LOADOUTSIZE = 5;

struct native UICardDisplayEntry
{
    var GFxObject Obj;
    var GFxObject Card;
    var GFxObject Icon;
    var GFxObject PowerLevel;
    var int DeviceID;

    structdefaultproperties
    {
        Obj=none
        Card=none
        Icon=none
        PowerLevel=none
        DeviceID=0
    }
};

struct native UICardDisplayGroup
{
    var UICardDisplayEntry Items[4];
    var UICardDisplayEntry Cards[5];
    var int LastCardsPawnId;

    structdefaultproperties
    {
        Items[0]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Items[1]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Items[2]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Items[3]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Cards[0]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Cards[1]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Cards[2]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Cards[3]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        Cards[4]=(Obj=none,Card=none,Icon=none,PowerLevel=none,DeviceID=0)
        LastCardsPawnId=0
    }
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
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_bCanShake=true
    m_Name="UIHudCards"
}