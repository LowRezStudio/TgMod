class ParticleModuleVelocityCone extends ParticleModuleVelocityBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Cone) RawDistributionFloat Angle;
var(Cone) RawDistributionFloat Velocity;
var(Cone) Vector Direction;

defaultproperties
{
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleVelocityCone.DistributionAngle'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionAngle'
    begin object name="DistributionAngle" class=Engine.DistributionFloatUniform
    end object
    // Reference: DistributionFloatUniform'Engine.Default__ParticleModuleVelocityCone.DistributionVelocity'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocity'
    begin object name="DistributionVelocity" class=Engine.DistributionFloatUniform
    end object
    Angle=(Distribution=Distribution=DistributionAngle,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Velocity=(Distribution=Distribution=DistributionVelocity,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Direction=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    bSpawnModule=true
    bSupported3DDrawMode=true
}