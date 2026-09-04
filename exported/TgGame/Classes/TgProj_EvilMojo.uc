class TgProj_EvilMojo extends TgProj_FreeGrenade
    hidecategories(Navigation);

simulated event bool CheckTeamPassThrough(Actor Other)
{
    local TgDeployable deployTarget;

    deployTarget = TgDeployable(Other);
    // End:0x6B
    if((deployTarget != none) && int(deployTarget.m_CollisionSettings.mCollisionMode) == int(1))
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
    m_fSpeedToActivateBounceFX=100.0000000
    m_fGravityZOverride=-650.0000000
    m_fPostLandDuration=0.6000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_EvilMojo.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_EvilMojo.CollisionCylinder'
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