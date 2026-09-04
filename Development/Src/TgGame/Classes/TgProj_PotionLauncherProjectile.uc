class TgProj_PotionLauncherProjectile extends TgProj_FreeGrenade
    hidecategories(Navigation)
    config(Engine);

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams) { }

defaultproperties
{}
