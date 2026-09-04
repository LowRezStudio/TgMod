class TgProj_SeedlingSecondary extends TgProj_Seedling
    native(ChampFairy)
    hidecategories(Navigation);

var bool m_bInitialized;
var float m_fGrowthLifetime;

defaultproperties
{
    // Reference: TgSilhouetteComponentPaladins'TgGame.Default__TgProj_SeedlingSecondary.MySilhouette'
    // Archetype: TgSilhouetteComponentPaladins'TgGame.Default__TgProj_Seedling.MySilhouette'
    begin object name="MySilhouette"
    end object
    m_Silhouette=MySilhouette
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_SeedlingSecondary.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Seedling.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_SeedlingSecondary.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Seedling.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Components[2]=MySilhouette
    CollisionComponent=CollisionCylinder
}