class TgProj_ExplosiveFlask extends TgProj_FreeGrenade
    hidecategories(Navigation);

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_bUseGravityZOverride=true
    m_fGravityZOverride=-650.0000000
    m_bExplodeAtMaxRange=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_ExplosiveFlask.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_ExplosiveFlask.CollisionCylinder'
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