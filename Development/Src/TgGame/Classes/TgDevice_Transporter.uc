class TgDevice_Transporter extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var float m_fDowntraceDistance;
var Vector c_vCurrentTargeting2Location;

native function GetGroundTargetAim(out AimData Aim);  // Export UTgDevice_Transporter::execGetGroundTargetAim(FFrame&, void* const)

native function TickTargetingMode(float DeltaSeconds);  // Export UTgDevice_Transporter::execTickTargetingMode(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Transporter::execMustBeOnGroundToFire(FFrame&, void* const)

simulated event bool ShouldLockFiring(TgDevice Current) { }

event OnDeployableDestroyed(TgDeployable deployable) { }

reliable client simulated function ClientPlayTransporterDestroyedSound() { }

state DeviceFiring {}

defaultproperties
{
    m_fDowntraceDistance=4096.0000000
    c_bUsesTargetingReticle=false
    m_vProjectileSpawnOffset=(X=15.0000000,Y=1.0000000,Z=-9.0000000)
}
