class UIComponent_Targeter extends UIComponent
    native(UIComponent)
    config(Engine);

var TgPawn_Character m_Target;
var TgGfxScene m_mcOwningScene;
var GFxObject m_mcParent;
var GFxObject m_mcTargeter;
var GFxObject m_mcKey;
var GFxObject m_mcPrompt;
var const string m_sKeybind;
var bool m_bTargeted;
var bool m_bVisible;
var bool m_bShowKeybind;
var bool m_bLOSCheck;
var const bool m_bCenterTargeter;
var float m_fBaseTargeterHeight;
var float m_fScaleMultiplier;
var float m_fMinScale;
var float m_fMaxScale;
var float m_fFadeTime;
var const int m_nTargeterFrame;

defaultproperties
{
    m_bLOSCheck=true
    m_fScaleMultiplier=1.0000000
    m_fMinScale=0.5000000
    m_fMaxScale=2.0000000
    m_fFadeTime=0.2000000
    m_nTargeterFrame=1
}
