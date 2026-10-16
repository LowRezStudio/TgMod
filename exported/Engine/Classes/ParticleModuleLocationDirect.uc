class ParticleModuleLocationDirect extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Location) RawDistributionVector Location;
var(Location) RawDistributionVector LocationOffset;
var(Location) RawDistributionVector ScaleFactor;
var(Location) RawDistributionVector Direction;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleLocationDirect.DistributionLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLocation'
    begin object name="DistributionLocation" class=Engine.DistributionVectorUniform
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationDirect.DistributionLocationOffset'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLocationOffset'
    begin object name="DistributionLocationOffset" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationDirect.DistributionScaleFactor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionScaleFactor'
    begin object name="DistributionScaleFactor" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleLocationDirect.DistributionDirection'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionDirection'
    begin object name="DistributionDirection" class=Engine.DistributionVectorUniform
    end object
    Location=(Distribution=Distribution=DistributionLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    LocationOffset=(Distribution=Distribution=DistributionLocationOffset,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    ScaleFactor=(Distribution=Distribution=DistributionScaleFactor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Direction=(Distribution=Distribution=DistributionDirection,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}