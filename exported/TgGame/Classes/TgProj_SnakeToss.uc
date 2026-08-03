class TgProj_SnakeToss extends TgProj_FreeGrenade
    hidecategories(Navigation);

defaultproperties
{
    m_bExplodeOnGeometry=true
    m_nShadowFXID=7299
    m_fMaxDecalHeight=2000.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_SnakeToss.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_FreeGrenade.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_SnakeToss.CollisionCylinder'
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