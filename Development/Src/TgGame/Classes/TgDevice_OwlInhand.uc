class TgDevice_OwlInhand extends TgDevice
    native(ChampOwl)
    hidecategories(Navigation)
    config(Engine);

var TgDevice m_CachedSwapDevice;
var TgDevice m_CachedScopeDevice;
var bool bUsePerfectAccuracy;

native function float GetAccuracy(optional int nMode=-1);  // Export UTgDevice_OwlInhand::execGetAccuracy(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function ShowReticle(bool bShow) { }

simulated function ApplyScopeEffects() { }

simulated function RemoveScopeEffects() { }

simulated function RemoveAccuracyDelayed() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

defaultproperties
{
    m_AltFireType=ALTFIRE_AlternateDevice
    m_ReticuleType=RETICULE_Precise
    m_bPostFireShouldInterruptStealth=false
    m_bReloadingShouldInterruptStealth=false
    m_bCancelingShouldInterruptStealth=false
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=17.0000000,Y=0.0000000,Z=-5.0000000)
    m_fWeaponBob=0.0000000
    m_fMeshFOV=77.0000000
    m_vProjectileSpawnOffset=(X=30.0000000,Y=9.0000000,Z=-10.0000000)
    m_WeaponMeshActorClass=Class'TgWeaponMeshActor_OwlInhand'
    m_nLinkedDeviceTypes[0]=11041
    m_AimAssistKeyframesMagnetVert=none
    m_AimAssistKeyframesMagnetHoriz=none
    m_AimAssistKeyframesFriction=none
    m_AimAssistKeyframesTrackingAccHoriz=none
    m_AimAssistKeyframesTrackingAngleHoriz=none
    m_AimAssistKeyframesTrackingAccVert=none
    m_AimAssistKeyframesTrackingAngleVert=none
}
