class TgProj_MalDambaInhand extends TgProj_FreeGrenade
    hidecategories(Navigation);

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_bNeedsFrictionOverride=true
    m_fGravityScale=1.2000000
    m_fFrictionOverride=0.5000000
    m_nShadowFXID=7299
    m_fMaxDecalHeight=2000.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_MalDambaInhand.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_MalDambaInhand.CollisionCylinder'
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