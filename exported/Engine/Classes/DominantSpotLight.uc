class DominantSpotLight extends SpotLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,SpotLights);

defaultproperties
{
    // Reference: DominantSpotLightComponent'Engine.Default__DominantSpotLight.DominantSpotLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DominantSpotLightComponent0'
    begin object name="DominantSpotLightComponent0" class=Engine.DominantSpotLightComponent
        bAllowPreShadow=true
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=DominantSpotLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=none
    Components[4]=none
    Components[5]=none
    Components[6]=DominantSpotLightComponent0
    bStatic=false
    bHardAttach=true
}