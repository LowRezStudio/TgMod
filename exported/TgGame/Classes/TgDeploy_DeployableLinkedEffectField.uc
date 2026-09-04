class TgDeploy_DeployableLinkedEffectField extends TgDeploy_EffectField
    native(Deployable)
    placeable
    hidecategories(Navigation);

var TgDeployable m_ParentDeployable;

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_DeployableLinkedEffectField.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_EffectField.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}