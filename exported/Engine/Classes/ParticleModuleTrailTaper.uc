class ParticleModuleTrailTaper extends ParticleModuleTrailBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

enum ETrailTaperMethod
{
    PETTM_None,                     // 0
    PETTM_Full,                     // 1
    PETTM_Partial,                  // 2
    PETTM_MAX                       // 3
};

var(Taper) ParticleModuleTrailTaper.ETrailTaperMethod TaperMethod;
var(Taper) RawDistributionFloat TaperFactor;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleTrailTaper.DistributionTaperFactor'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTaperFactor'
    begin object name="DistributionTaperFactor" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    TaperFactor=(Distribution=Distribution=DistributionTaperFactor,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}