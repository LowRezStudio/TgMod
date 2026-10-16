class TgDevice_Weightless extends TgDevice
    native(ChampPip)
    hidecategories(Navigation)
    config(Engine);

var float r_fSprintHorizontalSpeedMod;
var float r_fSprintJumpSpeedMod;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fSprintHorizontalSpeedMod, r_fSprintJumpSpeedMod;
}

native function bool ShouldInterruptLift();  // Export UTgDevice_Weightless::execShouldInterruptLift(FFrame&, void* const)

simulated function float GetHorizontalSpeedMultiplier() { }

simulated function float GetJumpSpeedMultiplier() { }

simulated function float CalcWeightlessHorizontalMultiplier() { }

simulated function float CalcWeightlessJumpMultiplier() { }

simulated event bool CanBeCanceled() { }

simulated function bool ShouldInterruptReloadOnFire() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bPostFireShouldInterruptStealth=false
    m_bAbilityRequiresInhandResync=false
}
