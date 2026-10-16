class TgDevice_Illusion extends TgDevice_Pet
    native(ChampYing)
    hidecategories(Navigation)
    config(Engine)
    dependson(TgObject);

native function GetTargetingAim(out AimData Aim);  // Export UTgDevice_Illusion::execGetTargetingAim(FFrame&, void* const)

native function TgPawn SpawnIllusionAtLocation(Vector pos, Rotator Rot);  // Export UTgDevice_Illusion::execSpawnIllusionAtLocation(FFrame&, void* const)

native function bool MustBeOnGroundToFire();  // Export UTgDevice_Illusion::execMustBeOnGroundToFire(FFrame&, void* const)

simulated function CustomFire() { }

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_bAbilityRequiresInhandResync=false
}
