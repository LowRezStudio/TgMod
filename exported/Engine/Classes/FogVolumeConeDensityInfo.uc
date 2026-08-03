class FogVolumeConeDensityInfo extends FogVolumeDensityInfo
    abstract
    native(FogVolume)
    notplaceable
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo);

defaultproperties
{
    // Reference: FogVolumeConeDensityComponent'Engine.Default__FogVolumeConeDensityInfo.FogVolumeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FogVolumeComponent0'
    begin object name="FogVolumeComponent0" class=Engine.FogVolumeConeDensityComponent
    end object
    DensityComponent=FogVolumeComponent0
    // Reference: StaticMeshComponent'Engine.Default__FogVolumeConeDensityInfo.AutomaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AutomaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__FogVolumeDensityInfo.AutomaticMeshComponent0'
    begin object name="AutomaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    AutomaticMeshComponent=AutomaticMeshComponent0
    Components[0]=none
    Components[1]=AutomaticMeshComponent0
    Components[2]=none
    Components[3]=FogVolumeComponent0
}