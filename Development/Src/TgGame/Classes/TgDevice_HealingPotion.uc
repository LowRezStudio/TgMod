class TgDevice_HealingPotion extends TgDevice
    hidecategories(Navigation)
    config(Engine);

var bool s_bQueueDetonation;
var bool m_bAttemptingToDetonate;

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function LockOutOtherDevices() { }

simulated function DetonationGracePeriod() { }

simulated function FireAmmunition() { }

reliable client simulated event ClientStartCooldown(int nMode, float fCooldownTimeOverride) { }

reliable client simulated event ClientEndCooldown() { }

simulated function UpdateActiveProjectiles(optional TgProjectile Proj) { }

simulated function bool InterceptSlotPressed(TgPlayerController TgController) { }

singular simulated function bool TryDetonate() { }

reliable server event ServerTryDetonate() { }

reliable server event InterruptFiring() { }

reliable client simulated event ClientInterrupt() { }

function ScaleAbilityRadius() { }

state DeviceFiring {}

defaultproperties
{
    m_bAimThroughReticule=true
    m_IndividualOffhandCooldownTime=0.5000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=-35.0000000,Z=-20.0000000)
}
