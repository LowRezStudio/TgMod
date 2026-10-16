class UIComponent_OwlStealthBar extends UIComponent
    native(UIComponent)
    config(Engine);

var GFxObject m_mcThreshold;
var GFxObject m_mcStealthBarMask;
var GFxObject m_mcTrailingStealthBarMask;
var GFxObject m_mcStealthActive;
var bool m_bStealthActive;
var float m_fActivationCost;
