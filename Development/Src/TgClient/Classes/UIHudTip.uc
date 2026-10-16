class UIHudTip extends TgGfxScene within GFxMoviePlayer
    native(GFxScene)
    config(Engine);

var int m_nHudTipId;
var int m_nHudSpecialTipId;
var int m_nWorldTipId;
var float m_fPromptAnimTimer;
var GFxObject m_mcHudTip;
var GFxObject m_mcHudTipIcon;
var GFxObject m_mcHudTipName;
var GFxObject m_mcHudTipDesc;
var GFxObject m_mcHudSpecialTip;
var GFxObject m_mcHudSpecialTipText;
var GFxObject m_mcHudSpecialTipAnimA;
var GFxObject m_mcHudSpecialTipAnimB;
var GFxObject m_mcHudSpecialTipFrame;
var GFxObject m_mcHudSpecialTipPrompt;
var GFxObject m_mcWorldTip;
var GFxObject m_mcWorldTipIcon;
var GFxObject m_mcWorldTipName;
var GFxObject m_mcWorldTipDesc;

event bool GetScreenCoordinates(Canvas pCanvas, Vector CameraLocation, Vector CameraRotation, Vector ObjectLocation, out Vector ScreenLocation) { }

defaultproperties
{
    m_bVisibleOnLoad=true
    m_bShowCursor=false
    m_bCaptureKeys=false
    m_bCanShake=true
    m_Name="UIHudTip"
}
