class DominantPointLight extends PointLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,PointLights);

defaultproperties
{
    // Reference: DominantPointLightComponent'Engine.Default__DominantPointLight.DominantPointLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DominantPointLightComponent0'
    begin object name="DominantPointLightComponent0" class=Engine.DominantPointLightComponent
        bAllowPreShadow=true
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=DominantPointLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=DominantPointLightComponent0
    bStatic=false
    bHardAttach=true
}