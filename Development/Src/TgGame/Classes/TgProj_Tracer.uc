class TgProj_Tracer extends TgProjectile
    hidecategories(Navigation)
    config(Engine);

var export editinline TgParticleSystemComponent PSC;

simulated function InitTracer(TgSpecialFx Fx, bool bIsEnemy, bool bConfused) { }

simulated function Tick(float DeltaSeconds) { }

simulated function bool CheckProjectileRange(optional Vector vLocOverride) { }

simulated function ShutDown() { }

defaultproperties
{}
