class ParticleModuleVelocityInheritParent extends ParticleModuleVelocityBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Velocity) RawDistributionVector Scale;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleVelocityInheritParent.DistributionScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionScale'
    begin object name="DistributionScale" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    Scale=(Distribution=Distribution=DistributionScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}