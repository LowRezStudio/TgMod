class UIComponent_OracleSoulCharges extends UIComponent
    native(UIComponent)
    config(Engine);

enum SoulChargesAnimEvent {
    SoulChargesAE_Show,  // 0
    SoulChargesAE_Hide,  // 1
    SoulChargesAE_Increase,  // 2
    SoulChargesAE_Decrease,  // 3
    SoulChargesAE_MaxStacks,  // 4
};

var TgPawn m_CurrentViewPawn;
var TgPawn m_CurrentTargetPawn;
var GFxObject m_mcText;
var GFxObject m_mcIcon;
var GFxObject m_mcAnim;
var GFxObject m_mcMaxStacks;
var bool m_bIsHiding;
var bool m_bEnabled;
var int m_nCurrentSoulCharges;

event float HandleAnimEvent(int nEventType, optional array<float> fExtraData) { }
