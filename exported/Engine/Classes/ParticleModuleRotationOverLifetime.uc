class ParticleModuleRotationOverLifetime extends ParticleModuleRotationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionFloat RotationOverLife;
var(Rotation) bool Scale;

defaultproperties
{
    // Reference: DistributionFloatConstantCurve'Engine.Default__ParticleModuleRotationOverLifetime.DistributionRotOverLife'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionRotOverLife'
    begin object name="DistributionRotOverLife" class=Engine.DistributionFloatConstantCurve
    end object
    RotationOverLife=(Distribution=Distribution=DistributionRotOverLife,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    Scale=true
    bUpdateModule=true
}