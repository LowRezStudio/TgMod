class ParticleModuleWorldAttractor extends ParticleModuleWorldForcesBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var() bool bParticleLifeRelative;
var() RawDistributionFloat AttractorInfluence;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleWorldAttractor.DistributionInfluence'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionInfluence'
    begin object name="DistributionInfluence" class=Engine.DistributionFloatConstant
        Constant=1.0000000
    end object
    AttractorInfluence=(Distribution=Distribution=DistributionInfluence,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
}