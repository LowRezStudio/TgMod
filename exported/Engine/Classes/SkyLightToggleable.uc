class SkyLightToggleable extends SkyLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,SkyLights);

defaultproperties
{
    // Reference: SkyLightComponent'Engine.Default__SkyLightToggleable.SkyLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkyLightComponent0'
    // Archetype: SkyLightComponent'Engine.Default__SkyLight.SkyLightComponent0'
    begin object name="SkyLightComponent0"
    end object
    LightComponent=SkyLightComponent0
    Components[0]=none
    Components[1]=SkyLightComponent0
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
}