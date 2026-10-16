class ParticleModuleSizeMultiplyVelocity extends ParticleModuleSizeBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Size) RawDistributionVector VelocityMultiplier;
var(Size) bool MultiplyX;
var(Size) bool MultiplyY;
var(Size) bool MultiplyZ;
var(Size) Vector CapMaxSize;
var(Size) Vector CapMinSize;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSizeMultiplyVelocity.DistributionVelocityMultiplier'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionVelocityMultiplier'
    begin object name="DistributionVelocityMultiplier" class=Engine.DistributionVectorConstant
    end object
    VelocityMultiplier=(Distribution=Distribution=DistributionVelocityMultiplier,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MultiplyX=true
    MultiplyY=true
    MultiplyZ=true
    bSpawnModule=true
    bUpdateModule=true
}