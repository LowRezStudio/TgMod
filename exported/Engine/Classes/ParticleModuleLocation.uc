class ParticleModuleLocation extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Location) RawDistributionVector StartLocation;
var(Location) float DistributeOverNPoints;
var(Location) float DistributeThreshold;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleLocation.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    begin object name="DistributionStartLocation" class=Engine.DistributionVectorUniform
    end object
    StartLocation=(Distribution=Distribution=DistributionStartLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bSupported3DDrawMode=true
}