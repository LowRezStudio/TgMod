class TgProj_Loogie extends TgProj_Simulated
    native(ChampDrogoz)
    hidecategories(Navigation)
    config(Engine);

var bool m_bWasExplodedByRocket;
var bool m_bIgnoreRocketOwner;

simulated function HideProjectile() { }

simulated function PlayAdditionalHitFX(bool bSuccessfulHit, Vector FXLocation, Vector HitNormal, Vector ProjDir, out array<ParticleSysParam> ExplosionParams) { }

simulated event ScaleAbilityFX() { }

simulated event ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal) { }

simulated event ExplodeOnTarget(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated function DetonateFromRocket(Actor Target, Vector HitLocation, Vector HitNormal) { }

simulated event ClientExplodeSpecial(Actor Target, Vector HitLocation, Vector HitNormal) { }

event bool UseAOE() { }

function bool ApplyTheHit(TgDeviceFire FireMode, ImpactInfo Impact, Actor DamageInstigator) { }

defaultproperties
{}
