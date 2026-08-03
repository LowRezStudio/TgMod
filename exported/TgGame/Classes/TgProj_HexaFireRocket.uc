class TgProj_HexaFireRocket extends TgProj_Simulated
    native(ChampRuckus)
    hidecategories(Navigation);

simulated event ClearPersistTimers()
{
    ClearTimer('TimerPulse');
    ClearTimer('ShutDown');
    m_fPersistHitPulse = 0.0000000;
    m_fPersistTime = 0.0000000;
    //return;    
}

defaultproperties
{
    m_bCanSpawnOnClientFirst=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_HexaFireRocket.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_Simulated.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_HexaFireRocket.CollisionCylinder'
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