class UIComponent_HoldPrompt extends UIComponent
    native(UIComponent);

const UICOMPONENT_HOLDPURCHASE_RADIALFRAMES = 360;

var UIComponent_GamepadKey m_pGamepadKey;
var GFxObject m_mcRadialMask;
var GFxObject m_mcTF;
var float m_fHoldTimer;
var float m_fHoldDuration;
var float m_fFadeOutDelay;
var float m_fFadeOutDuration;
var float m_fFadeOutTimer;
var bool m_bListening;
var bool m_bHolding;
var bool m_bPrimed;

defaultproperties
{
    m_fHoldDuration=1.0000000
    m_sLoadName="PressAndHold"
}