class FogVolumeSphericalDensityInfo extends FogVolumeDensityInfo
    native(FogVolume)
    placeable
    hidecategories(Navigation,Collision)
    autoexpandcategories(FogVolumeDensityInfo);

defaultproperties
{
    // Reference: FogVolumeSphericalDensityComponent'Engine.Default__FogVolumeSphericalDensityInfo.FogVolumeComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FogVolumeComponent0'
    begin object name="FogVolumeComponent0" class=Engine.FogVolumeSphericalDensityComponent
    end object
    DensityComponent=FogVolumeComponent0
    // Reference: StaticMeshComponent'Engine.Default__FogVolumeSphericalDensityInfo.AutomaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'AutomaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__FogVolumeDensityInfo.AutomaticMeshComponent0'
    begin object name="AutomaticMeshComponent0"
        StaticMesh=StaticMesh'EngineMeshes.Sphere'
        ReplacementPrimitive=none
        CollideActors=false
    end object
    AutomaticMeshComponent=AutomaticMeshComponent0
    Components[0]=none
    Components[1]=AutomaticMeshComponent0
    Components[2]=none
    Components[3]=FogVolumeComponent0
}