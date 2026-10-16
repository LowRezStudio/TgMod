class ParticleModuleAttractorLine extends ParticleModuleAttractorBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Attractor) Vector EndPoint0;
var(Attractor) Vector EndPoint1;
var(Attractor) RawDistributionFloat Range;
var(Attractor) RawDistributionFloat Strength;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorLine.DistributionRange'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRange'
    begin object name="DistributionRange" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleAttractorLine.DistributionStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStrength'
    begin object name="DistributionStrength" class=Engine.DistributionFloatConstant
    end object
    Range=(Distribution=Distribution=DistributionRange,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Strength=(Distribution=Distribution=DistributionStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bUpdateModule=true
    bSupported3DDrawMode=true
}