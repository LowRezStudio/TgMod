class TgProj_OppressorMine extends TgProj_FreeGrenade
    native(ChampKinessa)
    hidecategories(Navigation)
    config(Engine);

native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProj_OppressorMine::execSpawnDeployable(FFrame&, void* const)

simulated function Actor CalculateHitActor(Actor Target, Vector HitLocation, Vector HitNormal, out TraceHitInfo HitInfo) { }

simulated function bool ShouldHitBounce(Actor Target, Vector HitNormal) { }

defaultproperties
{}
