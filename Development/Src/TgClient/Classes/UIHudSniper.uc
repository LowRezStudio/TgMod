class UIHudSniper extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

const UIHUDSNIPER_PINS = 4;

const UIHUDSNIPER_SIDES = 2;

const UIHUDSNIPER_CHARGES = 4;

const UIHUDSNIPER_BULLETS = 5;

var int m_nAmmo;
var float m_fCharge;
var GFxObject m_mcPins;
var GFxObject m_mcReady;
var GFxObject m_mcFrame;
var GFxObject m_mcAmmoBelt;
var GFxObject m_mcPin[4];
var GFxObject m_mcAmmo[5];
var GFxObject m_mcCharge[2];
var GFxObject m_mcChargeLeft[4];
var GFxObject m_mcChargeRight[4];

defaultproperties
{
    m_eScalingType=UISCALING_FITTALL
    m_eSnappingType=UISNAPPING_TOP
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_Name="UIHudSniper"
}
