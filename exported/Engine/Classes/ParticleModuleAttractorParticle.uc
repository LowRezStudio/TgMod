class ParticleModuleAttractorParticle extends ParticleModuleAttractorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EAttractorParticleSelectionMethod
{
    EAPSM_Random,                   // 0
    EAPSM_Sequential,               // 1
    EAPSM_MAX                       // 2
};

var(Attractor) noclear export name EmitterName;
var(Attractor) RawDistributionFloat Range;
var(Attractor) bool bStrengthByDistance;
var(Attractor) bool bAffectBaseVelocity;
var(Attractor) bool bRenewSource;
var(Attractor) bool bInheritSourceVel;
var(Attractor) RawDistributionFloat Strength;
var(Location) ParticleModuleAttractorParticle.EAttractorParticleSelectionMethod SelectionMethod;
var int LastSelIndex;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorParticle.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorParticle.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bStrengthByDistance=true
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}