class ParticleModuleLocationPrimitiveBase extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Location) bool Positive_X;
var(Location) bool Positive_Y;
var(Location) bool Positive_Z;
var(Location) bool Negative_X;
var(Location) bool Negative_Y;
var(Location) bool Negative_Z;
var(Location) bool SurfaceOnly;
var(Location) bool Velocity;
var(Location) RawDistributionFloat VelocityScale;
var(Location) RawDistributionVector StartLocation;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityScale'
    begin object name="DistributionVelocityScale" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleLocationPrimitiveBase.DistributionStartLocation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartLocation'
    begin object name="DistributionStartLocation" class=Engine.DistributionVectorConstant
    end object
    Positive_X=true
    Positive_Y=true
    Positive_Z=true
    Negative_X=true
    Negative_Y=true
    Negative_Z=true
    VelocityScale=(Distribution=Distribution=DistributionVelocityScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StartLocation=(Distribution=Distribution=DistributionStartLocation,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}