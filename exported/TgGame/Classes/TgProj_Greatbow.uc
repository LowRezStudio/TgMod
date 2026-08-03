class TgProj_Greatbow extends TgProj_Simulated
    native(ChampLongbow)
    hidecategories(Navigation);

// Export UTgProj_Greatbow::execApplySpawnParams(FFrame&, void* const)
native function ApplySpawnParams(float fProjectileSpeed, float fGravityScale);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Greatbow.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_Greatbow.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_Simulated.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    Physics=EPhysics.PHYS_Falling
    bNetTemporary=false
    CollisionComponent=CollisionCylinder
}