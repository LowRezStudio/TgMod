class ParticleModuleMeshRotationRateMultiplyLife extends ParticleModuleRotationRateBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionVector LifeMultiplier;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleMeshRotationRateMultiplyLife.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionVectorConstant
    end object
    LifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}