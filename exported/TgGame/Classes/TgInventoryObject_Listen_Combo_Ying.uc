class TgInventoryObject_Listen_Combo_Ying extends TgInventoryObject_Listen_Combo
    native(Inventory);

var float m_fCombo1MaxDuration;
var float m_fCombo1BonusDamagePercent;
var float m_fCombo2BonusDamage;
var array<Actor> m_MarkedTargets;
var array<float> m_fMarkTimes;
var Actor m_InhandTarget;
var int m_nInhandHits;
var int m_nCombo1DeviceId;

defaultproperties
{
    m_nCombo1DeviceId=13284
}