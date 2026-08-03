class SkyLight extends Light
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,SkyLights);

defaultproperties
{
    // Reference: SkyLightComponent'Engine.Default__SkyLight.SkyLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkyLightComponent0'
    begin object name="SkyLightComponent0" class=Engine.SkyLightComponent
        UseDirectLightMap=true
        bCanAffectDynamicPrimitivesOutsideDynamicChannel=true
    end object
    LightComponent=SkyLightComponent0
    Components[0]=none
    Components[1]=SkyLightComponent0
}