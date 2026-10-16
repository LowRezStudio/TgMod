class DominantDirectionalLightMovable extends DominantDirectionalLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,DirectionalLights);

defaultproperties
{
    // Reference: DominantDirectionalLightComponent'Engine.Default__DominantDirectionalLightMovable.DominantDirectionalLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DominantDirectionalLightComponent0'
    // Archetype: DominantDirectionalLightComponent'Engine.Default__DominantDirectionalLight.DominantDirectionalLightComponent0'
    begin object name="DominantDirectionalLightComponent0"
        WholeSceneDynamicShadowRadius=2000.0000000
    end object
    LightComponent=DominantDirectionalLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=DominantDirectionalLightComponent0
    Physics=EPhysics.PHYS_Interpolating
    bMovable=true
}