class ParticleModuleSizeMultiplyLife extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Size) RawDistributionVector LifeMultiplier;
var(Size) bool MultiplyX;
var(Size) bool MultiplyY;
var(Size) bool MultiplyZ;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSizeMultiplyLife.DistributionLifeMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionLifeMultiplier'
    begin object name="DistributionLifeMultiplier" class=Engine.DistributionVectorConstant
    end object
    LifeMultiplier=(Distribution=Distribution=DistributionLifeMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MultiplyX=true
    MultiplyY=true
    MultiplyZ=true
    bSpawnModule=true
    bUpdateModule=true
}