class TgProj_DarkConvergence extends TgProj_FreeGrenade
    native(ChampOracle)
    hidecategories(Navigation);

defaultproperties
{
    m_bExplodeOnTouch=false
    m_bExplodeOnFloor=true
    m_fBounceDamping=0.2000000
    m_fSpeedToActivateBounceFX=80.0000000
    m_bTrackProjectileForTimelapse=true
    m_nShadowFXID=7298
    m_fMaxDecalHeight=2000.0000000
    m_fTrackingUpdateRate=0.2000000
    m_bExplodeAtMaxRange=true
    m_bDeployOnGround=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DarkConvergence.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_DarkConvergence.CollisionCylinder'
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