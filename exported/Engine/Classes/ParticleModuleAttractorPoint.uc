class ParticleModuleAttractorPoint extends ParticleModuleAttractorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Attractor) RawDistributionVector Position;
var(Attractor) RawDistributionFloat Range;
var(Attractor) RawDistributionFloat Strength;
var(Attractor) bool StrengthByDistance;
var(Attractor) bool bAffectBaseVelocity;
var(Attractor) bool bOverrideVelocity;
var(Attractor) bool bUseWorldSpacePosition;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleAttractorPoint.DistributionPosition'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionPosition'
    begin object name="DistributionPosition" class=Engine.DistributionVectorConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorPoint.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorPoint.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    Position=(Distribution=Distribution=DistributionPosition,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    StrengthByDistance=true
    bUpdateModule=true
    bSupported3DDrawMode=true
}