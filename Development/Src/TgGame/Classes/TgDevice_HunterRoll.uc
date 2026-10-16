class TgDevice_HunterRoll extends TgDevice_Charge
    hidecategories(Navigation)
    config(Engine);

var bool m_bRolledBackward;

simulated function Rotator GetChargeDirection() { }

state DeviceFiring {}

defaultproperties
{
    m_bCanLeftClickCancel=false
    m_bPostFireShouldInterruptStealth=false
}
