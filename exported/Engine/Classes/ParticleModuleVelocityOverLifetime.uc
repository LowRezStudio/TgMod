class ParticleModuleVelocityOverLifetime extends ParticleModuleVelocityBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Velocity) RawDistributionVector VelOverLife;
var(Velocity) export bool Absolute;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleVelocityOverLifetime.DistributionVelOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelOverLife'
    begin object name="DistributionVelOverLife" class=Engine.DistributionVectorConstantCurve
    end object
    VelOverLife=(Distribution=Distribution=DistributionVelOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}