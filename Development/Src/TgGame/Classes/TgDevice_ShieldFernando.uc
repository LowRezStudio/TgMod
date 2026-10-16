class TgDevice_ShieldFernando extends TgDevice_Toggle
    native(ChampFernando)
    hidecategories(Navigation)
    config(Engine);

native function bool HasEnoughPowerPool(byte FireModeNum);  // Export UTgDevice_ShieldFernando::execHasEnoughPowerPool(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_ShieldFernando::execMustBeOnGroundToFire(FFrame&, void* const)

function InitMaxHealth() { }

function CancelSafetyPeriodTimer() { }

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_bForce3PViewWhileFiring=true
    m_fDeployZOffset=-30.0000000
}
