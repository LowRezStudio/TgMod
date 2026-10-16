class TgDevice_ShellShield extends TgDevice
    native(ChampMakoa)
    hidecategories(Navigation)
    config(Engine);

var bool r_bHasHalfshell;
var bool c_bHalfShellFXOn;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_bHasHalfshell;
}

native function SetFireMode(int nFireModeNum, optional bool ForceSet=false);  // Export UTgDevice_ShellShield::execSetFireMode(FFrame&, void* const)

simulated event OnDeployableSpawned(TgDeployable deployable) { }

event OnDeployableDestroyed(TgDeployable deployable) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function ShellShieldFireLockout() { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_DeviceTimerBarType=DTBT_PostHit
    m_bDeployAtFeetOnFailure=true
    m_bCooldownAfterDeployDeath=true
    m_fDeployZForgiveness=0.0000000
    m_fBottomlessPitCheck=0.0000000
    m_fDeployZOffset=-40.0000000
}
