class UIHudKillFeed extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUDKILLFEED_START_Y_POS = 800.0;
const UIHUDKILLFEED_ALTERNATE_Y_POS = 700.0;
const UIHUDKILLFEED_Y_SPACING = 50.0;

struct native UIKILLFEED_DATA
{
    var GFxObject pObj;
    var float fTimer;

    structdefaultproperties
    {
        pObj=none
        fTimer=0.0000000
    }
};

var int m_nDepth;
var string m_sEntryName;
var array<UIKILLFEED_DATA> m_Entries;

defaultproperties
{
    m_sEntryName="Entry"
    m_eSnappingType=UISNAPPINGTYPE.UISNAPPING_BOT
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudKillFeed"
}