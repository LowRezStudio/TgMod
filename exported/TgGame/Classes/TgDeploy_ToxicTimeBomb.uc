class TgDeploy_ToxicTimeBomb extends TgDeploy_Bomb
    native(ChampSkye)
    placeable
    hidecategories(Navigation);

simulated event DestroyIt(optional bool bSkipFx)
{
    super.DestroyIt(bSkipFx);
    // End:0x44
    if(c_Mesh != none)
    {
        c_Mesh.SetHidden(true);
    }
    //return;    
}

defaultproperties
{
    // Reference: TgStaticMeshComponent'TgGame.Default__TgDeploy_ToxicTimeBomb.CountdownIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CountdownIndicator'
    // Archetype: TgStaticMeshComponent'TgGame.Default__TgDeploy_Bomb.CountdownIndicator'
    begin object name="CountdownIndicator"
        ReplacementPrimitive=none
    end object
    m_CountdownIndicator=CountdownIndicator
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_TIME_BOMB
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ToxicTimeBomb.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Bomb.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=3072
    m_GameplayCurves=TgGameplayCurves'GP_Skye.DeviceTimeBomb'
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_ToxicTimeBomb.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgDeploy_Bomb.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[1]=CollisionCylinder
    Components[2]=CountdownIndicator
    CollisionComponent=CollisionCylinder
}