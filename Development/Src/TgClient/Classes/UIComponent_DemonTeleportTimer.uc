class UIComponent_DemonTeleportTimer extends UIComponent
    native(UIComponent)
    config(Engine);

var GFxObject m_mcTimerMask;
var TgPawn_Demon m_CachedViewedDemon;
var float m_fCurrentTimerPct;
var bool m_bVisible;
