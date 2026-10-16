class TgProj_Fireball extends TgProj_Simulated
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Fireball.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(bExplodeOnShields=true,bExplodeOnBlockers=true,bHitAndPassThrough=true)
    // Reference: CylinderComponent'TgGame.Default__TgProj_Fireball.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}