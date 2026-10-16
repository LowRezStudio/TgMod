class ParticleModuleMeshRotationRateOverLife extends ParticleModuleRotationRateBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionVector RotRate;
var(Rotation) bool bScaleRotRate;

defaultproperties
{
    // Reference: DistributionVectorConstantCurve'Engine.Default__ParticleModuleMeshRotationRateOverLife.DistributionRotRate'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRotRate'
    begin object name="DistributionRotRate" class=Engine.DistributionVectorConstantCurve
    end object
    RotRate=(Distribution=Distribution=DistributionRotRate,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}