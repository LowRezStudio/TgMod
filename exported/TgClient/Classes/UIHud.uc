class UIHud extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIHUD_SCENE_PARTY = 0;
const UIHUD_SCENE_CHAT = 1;
const UIHUD_SCENE_PLAYER = 2;
const UIHUD_SCENE_CARDS = 3;
const UIHUD_SCENE_LEVEL = 4;
const UIHUD_SCENE_KILLINFO = 5;
const UIHUD_SCENE_NOTIFY = 6;
const UIHUD_SCENE_BUFFS = 7;
const UIHUD_SCENE_COMBATLOG = 8;
const UIHUD_SCENE_SKILLS = 9;
const UIHUD_SCENE_COUNT = 10;

var TgGfxScene m_mcSubscenes[10];
var GFxObject m_mcPaused;

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bResize=false
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHud"
}