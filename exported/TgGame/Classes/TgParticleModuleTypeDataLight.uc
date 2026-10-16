class TgParticleModuleTypeDataLight extends ParticleModuleTypeDataBase
    native(FX)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

var(TgLight) export editinline PointLightComponent m_PointLightComponent;
var export editinline PointLightComponent m_PLCDuplicate;

defaultproperties
{
    // Reference: PointLightComponent'TgGame.Default__TgParticleModuleTypeDataLight.PointLightComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'PointLightComponent0'
    begin object name="PointLightComponent0" class=Engine.PointLightComponent
        CastDynamicShadows=false
        UseDirectLightMap=true
        LightAffectsClassification=ELightAffectsClassification.LAC_STATIC_AFFECTING
    end object
    m_PointLightComponent=PointLightComponent0
}