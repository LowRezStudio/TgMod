class DominantDirectionalLight extends DirectionalLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,DirectionalLights);

defaultproperties
{
    // Reference: DominantDirectionalLightComponent'Engine.Default__DominantDirectionalLight.DominantDirectionalLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DominantDirectionalLightComponent0'
    begin object name="DominantDirectionalLightComponent0" class=Engine.DominantDirectionalLightComponent
        LightmassSettings=(LightSourceAngle=0.2000000)
        bAllowPreShadow=true
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=DominantDirectionalLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=DominantDirectionalLightComponent0
    bStatic=false
    bHardAttach=true
}