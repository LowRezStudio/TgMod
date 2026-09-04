class TgProj_Molotov extends TgProj_FreeGrenade
    native(ChampTyra)
    hidecategories(Navigation);

// Export UTgProj_Molotov::execSpawnDeployable(FFrame&, void* const)
native function TgDeployable SpawnDeployable(Vector vLocation, optional Actor TargetActor, optional Vector vNormal);

defaultproperties
{
    m_bExplodeOnFloor=true
    m_bUseBilinearInterpolationForBounceDamping=true
    m_fBounceDampingVertMin=0.1000000
    m_fBounceDampingVertMax=1.0000000
    m_fBounceDampingHorizMin=0.0900000
    m_fBounceDampingHorizMax=0.7500000
    m_fBounceDamping=0.1000000
    m_fGravityScale=1.3000000
    m_bExplodeAtMaxRange=true
    m_bDeployOnGround=true
    m_bAlwaysDeployUpwards=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Molotov.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Molotov.CollisionCylinder'
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