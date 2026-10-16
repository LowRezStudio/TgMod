class TgDevice_Illusion extends TgDevice_Pet
    native(ChampYing)
    hidecategories(Navigation);

// Export UTgDevice_Illusion::execGetTargetingAim(FFrame&, void* const)
native function GetTargetingAim(out AimData Aim);

// Export UTgDevice_Illusion::execSpawnIllusionAtLocation(FFrame&, void* const)
native function TgPawn SpawnIllusionAtLocation(Vector pos, Rotator Rot);

// Export UTgDevice_Illusion::execMustBeOnGroundToFire(FFrame&, void* const)
native function bool MustBeOnGroundToFire();

simulated function CustomFire()
{
    local AimData Aim;

    UpdateIndex();
    GetCachedAim(Aim);
    TgPawn(Instigator).FlashFireNoSim(r_nDeviceInstanceId, int(CurrentFireMode), Aim.EndTrace, int(r_eEquippedAt), m_nSocketIndex, false, GetRefireTime());
    // End:0xED
    if(int(Role) == int(ROLE_Authority))
    {
        SpawnIllusionAtLocation(Aim.EndTrace, Rotator(Aim.AimVector));
    }
    //return;    
}

defaultproperties
{
    m_bDeployAtFeetOnFailure=true
    m_bAbilityRequiresInhandResync=false
}