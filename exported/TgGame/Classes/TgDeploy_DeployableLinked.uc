class TgDeploy_DeployableLinked extends TgDeploy_MatchParentFireMode
    native(Deployable)
    placeable
    hidecategories(Navigation);

var TgDeployable m_ParentDeployable;

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_DeployableLinked.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_MatchParentFireMode.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}