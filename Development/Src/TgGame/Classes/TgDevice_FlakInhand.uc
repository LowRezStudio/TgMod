class TgDevice_FlakInhand extends TgDevice
    native(ChampFlak)
    hidecategories(Navigation)
    implements(TgDeviceInterface_MoveSpeedMultiplier)
    config(Engine);

var TgDevice_KineticBurst m_KineticDevice;

native function float GetMoveSpeedMultiplier();  // Export UTgDevice_FlakInhand::execGetMoveSpeedMultiplier(FFrame&, void* const)

native function bool HasKineticDevice();  // Export UTgDevice_FlakInhand::execHasKineticDevice(FFrame&, void* const)

simulated function FireAmmunition() { }

simulated event bool CanBeInterrupted() { }

simulated event bool CanBeCanceled() { }

state DeviceFiring {}

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAltFireEnabled=true
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-7.5000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_FlakInhand'
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceInhand'
}
