class TgProj_PoppyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation)
    config(Engine);

native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProj_PoppyBomb::execSpawnDeployable(FFrame&, void* const)

simulated function AltFireDetonate() { }

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem) { }

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation) { }

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded) { }

simulated event bool CheckTeamPassThrough(Actor Other) { }

defaultproperties
{}
