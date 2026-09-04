class SpotLightMovable extends SpotLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,SpotLights);

defaultproperties
{
    // Reference: SpotLightComponent'Engine.Default__SpotLightMovable.SpotLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SpotLightComponent0'
    // Archetype: SpotLightComponent'Engine.Default__SpotLight.SpotLightComponent0'
    begin object name="SpotLightComponent0"
        CastDynamicShadows=true
        UseDirectLightMap=false
        LightingChannels=(Dynamic=true)
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=SpotLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=none
    Components[4]=none
    Components[5]=SpotLightComponent0
    Components[6]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
    bMovable=true
}