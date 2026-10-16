class ParticleModuleBeamTarget extends ParticleModuleBeamBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Target) ParticleModuleBeamBase.Beam2SourceTargetMethod TargetMethod;
var(Target) ParticleModuleBeamBase.Beam2SourceTargetTangentMethod TargetTangentMethod;
var(Target) name TargetName;
var(Target) name TargetSocketName;
var(Target) RawDistributionVector Target;
var(Target) bool bTargetAbsolute;
var(Target) bool bLockTarget;
var(Target) bool bLockTargetTangent;
var(Target) bool bLockTargetStength;
var(Target) RawDistributionVector TargetTangent;
var(Target) RawDistributionFloat TargetStrength;
var(Target) float LockRadius;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamTarget.DistributionTarget'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTarget'
    begin object name="DistributionTarget" class=Engine.DistributionVectorConstant
        Constant=(X=50.0000000,Y=50.0000000,Z=50.0000000)
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleBeamTarget.DistributionTargetTangent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTargetTangent'
    begin object name="DistributionTargetTangent" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    end object
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleBeamTarget.DistributionTargetStrength'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionTargetStrength'
    begin object name="DistributionTargetStrength" class=Engine.DistributionFloatConstant
        Constant=25.0000000
    end object
    Target=(Distribution=Distribution=DistributionTarget,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000,50.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TargetTangent=(Distribution=Distribution=DistributionTargetTangent,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(0.0000000,1.0000000,1.0000000,0.0000000,0.0000000,1.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    TargetStrength=(Distribution=Distribution=DistributionTargetStrength,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(25.0000000,25.0000000,25.0000000,25.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    LockRadius=10.0000000
}