class TgDevice_OppressorMine extends TgDevice
    native(ChampKinessa)
    hidecategories(Navigation)
    config(Engine);

var array<Actor> m_NewTargetSFXRecentTargets;
var array<float> m_NewTargetSFXTargetTime;
var float m_fMinNewTargetSFXDelay;

reliable client simulated function ClientPlayOppressorMineNewTargetSound(Actor Target) { }

event PlayOppressorMineNewTargetSound(Actor Target) { }

simulated event bool ShouldLockFiring(TgDevice Current) { }

defaultproperties
{
    m_fMinNewTargetSFXDelay=3.0000000
    m_vProjectileSpawnOffset=(X=32.0000000,Y=8.0000000,Z=0.0000000)
}
