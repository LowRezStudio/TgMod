class TgProj_BlastShot extends TgProj_Simulated
    native(ChampCassie)
    hidecategories(Navigation);

// Export UTgProj_BlastShot::execGetExplosionFXParams(FFrame&, void* const)
native function GetExplosionFXParams(out array<ParticleSysParam> Params);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_BlastShot.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_BlastShot.CollisionCylinder'
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