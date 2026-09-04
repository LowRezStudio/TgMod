class PointLightMovable extends PointLight
    native(Light)
    placeable
    hidecategories(Navigation)
    classgroup(Lights,PointLights);

defaultproperties
{
    // Reference: PointLightComponent'Engine.Default__PointLightMovable.PointLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PointLightComponent0'
    // Archetype: PointLightComponent'Engine.Default__PointLight.PointLightComponent0'
    begin object name="PointLightComponent0"
        CastDynamicShadows=true
        UseDirectLightMap=false
        LightingChannels=(Dynamic=true)
        LightAffectsClassification=ELightAffectsClassification.LAC_DYNAMIC_AND_STATIC_AFFECTING
    end object
    LightComponent=PointLightComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=PointLightComponent0
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bStatic=false
    bHardAttach=true
    bMovable=true
}