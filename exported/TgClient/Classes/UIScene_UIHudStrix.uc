class UIScene_UIHudStrix extends UIScene
    native(UIComponent);

const UIHUDSTRIX_BULLETS = 5;

var int m_nAmmo;
var GFxObject m_mcAmmo[5];
var GFxObject m_mcScope;
var GFxObject m_mcOuterScope;
var bool m_bViewTargetOwl;
var float m_fColorTransitionAmt;
var float m_fColorTransitionPerSec;
var const LinearColor m_ColorTransitionMultiplier;
var const LinearColor m_ColorTransitionAdditive;
var int m_nScopeColorTransitionCBHandle;

defaultproperties
{
    m_ColorTransitionMultiplier=(R=0.2000000,G=0.0000000,B=1.0000000,A=1.0000000)
    m_ColorTransitionAdditive=(R=0.1500000,G=0.0000000,B=0.4000000,A=0.0000000)
}