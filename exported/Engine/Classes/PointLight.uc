class PointLight extends Light
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,PointLights);

defaultproperties
{
    // Reference: PointLightComponent'Engine.Default__PointLight.PointLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PointLightComponent0'
    begin object name="PointLightComponent0" class=Engine.PointLightComponent
        CastDynamicShadows=false
        UseDirectLightMap=true
        LightingChannels=(Dynamic=false)
        LightAffectsClassification=ELightAffectsClassification.LAC_STATIC_AFFECTING
    end object
    LightComponent=PointLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=PointLightComponent0
}