class TgDevice_Whirl extends TgDevice_Charge
    hidecategories(Navigation)
    config(Engine);

simulated function Rotator GetChargeDirection() { }

state DeviceFiring {}

defaultproperties
{
    m_bCanLeftClickCancel=false
}
