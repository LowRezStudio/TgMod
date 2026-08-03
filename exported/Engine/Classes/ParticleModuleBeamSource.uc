class ParticleModuleBeamSource extends ParticleModuleBeamBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Source) ParticleModuleBeamBase.Beam2SourceTargetMethod SourceMethod;
var(Source) ParticleModuleBeamBase.Beam2SourceTargetTangentMethod SourceTangentMethod;
var(Source) name SourceName;
var(Source) name SourceSocketName;
var(Source) bool bSourceAbsolute;
var(Source) bool bLockSource;
var(Source) bool bLockSourceTangent;
var(Source) bool bLockSourceStength;
var(Source) RawDistributionVector Source;
var(Source) RawDistributionVector SourceTangent;
var(Source) RawDistributionFloat SourceStrength;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamSource.DistributionSource'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSource'
    begin object name="DistributionSource" class=Engine.DistributionVectorConstant
        Constant=(X=50.0000000,Y=50.0000000,Z=50.0000000)
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamSource.DistributionSourceTangent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSourceTangent'
    begin object name="DistributionSourceTangent" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleBeamSource.DistributionSourceStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSourceStrength'
    begin object name="DistributionSourceStrength" class=Engine.DistributionFloatConstant
        Constant=25.0000000
    end object
    Source=(Distribution=Distribution=DistributionSource,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SourceTangent=(Distribution=Distribution=DistributionSourceTangent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,1.0000000,1.0000000,0.0000000,0.0000000,1.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    SourceStrength=(Distribution=Distribution=DistributionSourceStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(25.0000000,25.0000000,25.0000000,25.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
}