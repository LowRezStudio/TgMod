class ParticleModuleRotationRateMultiplyLife extends ParticleModuleRotationRateBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionFloat LifeMultiplier;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleRotationRateMultiplyLife.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionFloatConstant
    end object
    LifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}