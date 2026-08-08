class TgProj_Molotov extends TgProj_FreeGrenade
    native(ChampTyra)
    hidecategories(Navigation)
    config(Engine);

native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);  // Export UTgProj_Molotov::execSpawnDeployable(FFrame&, void* const)

defaultproperties
{}
