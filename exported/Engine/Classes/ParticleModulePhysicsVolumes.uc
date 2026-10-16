class ParticleModulePhysicsVolumes extends ParticleModuleWorldForcesBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

enum EParticleLevelInfluenceType
{
    LIT_Never,                      // 0
    LIT_OutsidePhysicsVolumes,      // 1
    LIT_Always,                     // 2
    LIT_MAX                         // 3
};

var() RawDistributionFloat GlobalInfluence;
var() ParticleModulePhysicsVolumes.EParticleLevelInfluenceType LevelInfluenceType;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModulePhysicsVolumes.DistributionInfluence'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionInfluence'
    begin object name="DistributionInfluence" class=Engine.DistributionFloatConstant
    end object
    GlobalInfluence=(Distribution=Distribution=DistributionInfluence,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
}