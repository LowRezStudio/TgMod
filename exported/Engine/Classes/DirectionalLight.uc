class DirectionalLight extends Light
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,DirectionalLights);

defaultproperties
{
    // Reference: DirectionalLightComponent'Engine.Default__DirectionalLight.DirectionalLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DirectionalLightComponent0'
    begin object name="DirectionalLightComponent0" class=Engine.DirectionalLightComponent
        UseDirectLightMap=true
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=DirectionalLightComponent0
    Components[0]=none
    Components[1]=DirectionalLightComponent0
    Components[2]=none
    Rotation=(Pitch=-16384,Yaw=0,Roll=0)
}