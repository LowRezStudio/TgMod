class TgDevice_Withdraw extends TgDevice_ChargeBackward
    native(ChampLongbow)
    hidecategories(Navigation)
    config(Engine);

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Withdraw::execMustBeOnGroundToFire(FFrame&, void* const)

simulated event bool ShouldInterruptInhand() { }

state DeviceFiring {}

defaultproperties
{
    m_bBuildupShouldInterruptStealth=false
    m_bPreFireShouldInterruptStealth=false
    m_bFireShouldInterruptStealth=false
    m_bPostFireShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_bForce3PViewWhileFiring=false
}
