class TgDevice_RocketLauncher extends TgDevice
    native(ChampRuckus)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

var () Vector m_vProjectileSpawnOffset2;
var int m_nFireCount;

native function Rotator GetAdjustedAim(vector StartFireLoc);  // Export UTgDevice_RocketLauncher::execGetAdjustedAim(FFrame&, void* const)

simulated event Vector GetProjectileSpawnOffset() { }

simulated function Projectile ProjectileFire() { }

state DeviceFiring {}

defaultproperties
{
    m_vProjectileSpawnOffset2=(X=0.0000000,Y=-25.0000000,Z=48.0000000)
    m_bAimThroughReticule=true
    m_vProjectileSpawnOffset=(X=0.0000000,Y=25.0000000,Z=48.0000000)
}
