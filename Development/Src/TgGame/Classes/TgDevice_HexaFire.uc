class TgDevice_HexaFire extends TgDevice_HitPulse
    native(ChampRuckus)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine)
    dependson(TgObject);

var () Vector m_vProjectileSpawnOffset2;
var bool m_bFireLeftWeapon;
var TgPawn_Ruckus m_CachedRuckus;

native function GetCachedAim(out AimData Aim);  // Export UTgDevice_HexaFire::execGetCachedAim(FFrame&, void* const)

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_HexaFire::execGetMoveSpeedMultiplier(FFrame&, void* const)

simulated function bool HasCachedRuckus() { }

simulated event Vector GetProjectileSpawnOffset() { }

simulated event bool CanJumpWhileFiring() { }

simulated event bool CanBeCanceled() { }

simulated function FireAmmunition() { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function bool ShouldInterruptReloadOnFire() { }

state DeviceFiring {}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=30.0000000,Y=-30.0000000,Z=15.0000000)
    m_DeviceTimerBarType=DTBT_PersistTime
    m_bAlwaysStartCooldown=false
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=30.0000000,Y=30.0000000,Z=15.0000000)
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'LightForceFeedback'
}
