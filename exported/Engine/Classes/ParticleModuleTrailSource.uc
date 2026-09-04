class ParticleModuleTrailSource extends ParticleModuleTrailBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum ETrail2SourceMethod
{
    PET2SRCM_Default,               // 0
    PET2SRCM_Particle,              // 1
    PET2SRCM_Actor,                 // 2
    PET2SRCM_MAX                    // 3
};

var(Source) ParticleModuleTrailSource.ETrail2SourceMethod SourceMethod;
var(Source) ParticleModule.EParticleSourceSelectionMethod SelectionMethod;
var(Source) name SourceName;
var(Source) RawDistributionFloat SourceStrength;
var(Source) bool bLockSourceStength;
var(Source) bool bInheritRotation;
var(Source) int SourceOffsetCount;
var(Source) editfixedsize array<Vector> SourceOffsetDefaults;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTrailSource.DistributionSourceStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSourceStrength'
    begin object name="DistributionSourceStrength" class=Engine.DistributionFloatConstant
        Constant=100.0000000
    end object
    SelectionMethod=EParticleSourceSelectionMethod.EPSSM_Sequential
    SourceStrength=(Distribution=Distribution=DistributionSourceStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(100.0000000,100.0000000,100.0000000,100.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}