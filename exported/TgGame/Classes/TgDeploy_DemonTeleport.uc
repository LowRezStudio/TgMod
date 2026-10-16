class TgDeploy_DemonTeleport extends TgDeployable
    native(ChampDemon)
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_DemonTeleport.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=1
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_DemonTeleport.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        BlockZeroExtent=false
        BlockNonZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    bCollideActors=true
    bCollideWorld=true
    CollisionComponent=CollisionCylinder
}