class TgDevice_DrogozInhand extends TgDevice
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine);

var TgPawn_Drogoz m_CachedDrogozPawn;
var Vector m_vSalvoProjectileSpawnOffset;
var bool m_bStartedSalvo;
var TgDevice m_SalvoDevice;
var int m_nSalvoRockets;

native function bool CanReload(optional bool bIsAutoReload=false);  // Export UTgDevice_DrogozInhand::execCanReload(FFrame&, void* const)

native function bool ShouldAutoFire();  // Export UTgDevice_DrogozInhand::execShouldAutoFire(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

simulated function FireAmmunition() { }

simulated function bool HasCachedDrogozPawn() { }

simulated event SetAmmo(int AmmoCount, optional int ClipSize=-1, optional bool bShouldValidate=false, optional int ValidationIDOverride=0) { }

simulated event Vector GetProjectileSpawnOffset() { }

simulated function PrimeSalvo() { }

simulated function EndSalvo() { }

function SalvoPostFireTimer() { }

reliable server function ServerStartSalvoReload() { }

simulated event LinkedDeviceEquipped(TgDevice Dev) { }

simulated event LinkedDeviceUnequipped(TgDevice Dev) { }

simulated function Projectile ProjectileFire() { }

state DeviceFiring {}

defaultproperties
{
    m_vSalvoProjectileSpawnOffset=(X=0.0000000,Y=4.5000000,Z=-6.0000000)
    m_AltFireType=ALTFIRE_AlternateDevice
    m_bAimThroughReticule=true
    m_bAltFireEnabled=true
    m_vMeshViewOffset=(X=10.0000000,Y=2.0000000,Z=-2.0000000)
    m_fWeaponBob=0.0000000
    m_vProjectileSpawnOffset=(X=0.0000000,Y=15.0000000,Z=-7.5000000)
    m_fAltFireLockOutTime=0.0000000
    m_nLinkedDeviceTypes[0]=11041
    m_AimAssistKeyframesMagnetHoriz[0]=(KeyframeName="H10ft",Distance=160.0000000)
    m_AimAssistKeyframesMagnetHoriz[1]=(KeyframeName="H50ft",Distance=800.0000000)
    m_AimAssistKeyframesMagnetHoriz[2]=(KeyframeName="H100ftLowMag",Distance=1600.0000000)
    m_AimAssistKeyframesMagnetHoriz[3]=(KeyframeName="H200ftLowMag",Distance=3200.0000000)
    m_GameplayCurvesDeprecated=TgGameplayCurves'DeviceRocketLauncher'
    m_ForceFeedbackStartFire=ForceFeedbackWaveform'HeavyForceFeedback'
}
