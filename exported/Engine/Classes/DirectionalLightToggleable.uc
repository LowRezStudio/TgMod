class DirectionalLightToggleable extends DirectionalLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,DirectionalLights);

defaultproperties
{
    // Reference: DirectionalLightComponent'Engine.Default__DirectionalLightToggleable.DirectionalLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DirectionalLightComponent0'
    // Archetype: DirectionalLightComponent'Engine.Default__DirectionalLight.DirectionalLightComponent0'
    begin object name="DirectionalLightComponent0"
        LightmassSettings=(IndirectLightingScale=0.0000000)
        UseDirectLightMap=false
    end object
    LightComponent=DirectionalLightComponent0
    Components[0]=none
    Components[1]=DirectionalLightComponent0
    Components[2]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
}