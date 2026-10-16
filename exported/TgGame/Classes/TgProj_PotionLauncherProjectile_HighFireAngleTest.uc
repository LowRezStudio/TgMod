class TgProj_PotionLauncherProjectile_HighFireAngleTest extends TgProj_PotionLauncherProjectile
    hidecategories(Navigation);

defaultproperties
{
    m_fTossZ=0.0000000
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_PotionLauncherProjectile_HighFireAngleTest.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_PotionLauncherProjectile.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_PotionLauncherProjectile_HighFireAngleTest.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_PotionLauncherProjectile.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}