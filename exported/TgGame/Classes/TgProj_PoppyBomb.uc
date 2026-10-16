class TgProj_PoppyBomb extends TgProj_FreeGrenade
    native(ChampBombKing)
    hidecategories(Navigation);

// Export UTgProj_PoppyBomb::execSpawnDeployable(FFrame&, void* const)
native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

simulated function AltFireDetonate()
{
    m_bSuppressDeployableSpawn = true;
    super(TgProjectile).AltFireDetonate();
    //return;    
}

function bool ApplyHit(Actor Target, Vector HitLocation, Vector HitNormal, optional int HitItem)
{
    // End:0x23
    if(!m_bSuppressDeployableSpawn && s_nSpawnDeployableId != 0)
    {
        return false;
    }
    return super(TgProj_Simulated).ApplyHit(Target, HitLocation, HitNormal, HitItem);
    //return ReturnValue;    
}

simulated event PlayHitWallExplosionFX(Vector HitNormal, Vector HitLocation)
{
    // End:0x22
    if(!m_bSuppressDeployableSpawn && s_nSpawnDeployableId != 0)
    {
        return;
    }
    super.PlayHitWallExplosionFX(HitNormal, HitLocation);
    //return;    
}

simulated function PlayHitTargetFX(Actor Target, Vector HitLocation, Vector HitNormal, bool bExploded)
{
    // End:0x22
    if(!m_bSuppressDeployableSpawn && s_nSpawnDeployableId != 0)
    {
        return;
    }
    super.PlayHitTargetFX(Target, HitLocation, HitNormal, bExploded);
    //return;    
}

simulated event bool CheckTeamPassThrough(Actor Other)
{
    // End:0x6F
    if((Other.IsA('TgPawn') || Other.IsA('TgDeployable')) || Other.IsA('DynamicBlockingVolume'))
    {
        return true;
    }
    return super(TgProjectile).CheckTeamPassThrough(Other);
    //return ReturnValue;    
}

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_bUseGravityZOverride=true
    m_fGravityZOverride=-650.0000000
    m_bDeployOnCharacter=true
    m_DeployableSpawnOrientation=SpawnDeployableOrientation.SDO_FaceRotation
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_PoppyBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_PoppyBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_FreeGrenade.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}