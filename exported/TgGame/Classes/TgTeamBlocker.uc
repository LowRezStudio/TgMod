class TgTeamBlocker extends TgMeshAssembly
    native(Navigation)
    placeable
    hidecategories(Navigation);

var() bool m_bBlockFlagCarrier;
var() bool m_bBlockFriendlyFire;

defaultproperties
{
    m_bBlockFlagCarrier=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgTeamBlocker.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgMeshAssembly.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    m_LightEnvironment=MyLightEnvironment
    Components[0]=none
    Components[1]=MyLightEnvironment
}