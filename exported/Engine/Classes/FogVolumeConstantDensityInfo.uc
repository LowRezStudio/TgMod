class FogVolumeConstantDensityInfo extends FogVolumeDensityInfo
    native(FogVolume)
    placeable
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo);

defaultproperties
{
    // Reference: FogVolumeConstantDensityComponent'Engine.Default__FogVolumeConstantDensityInfo.FogVolumeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FogVolumeComponent0'
    begin object name="FogVolumeComponent0" class=Engine.FogVolumeConstantDensityComponent
    end object
    DensityComponent=FogVolumeComponent0
    // Reference: StaticMeshComponent'Engine.Default__FogVolumeConstantDensityInfo.AutomaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AutomaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__FogVolumeDensityInfo.AutomaticMeshComponent0'
    begin object name="AutomaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    AutomaticMeshComponent=AutomaticMeshComponent0
    Components[0]=none
    Components[1]=AutomaticMeshComponent0
    Components[2]=FogVolumeComponent0
}