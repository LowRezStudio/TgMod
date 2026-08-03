class ParticleModuleMeshRotation extends ParticleModuleRotationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Rotation) RawDistributionVector StartRotation;
var(Rotation) bool bInheritParent;

defaultproperties
{
    // Reference: DistributionVectorUniform'Engine.Default__ParticleModuleMeshRotation.DistributionStartRotation'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionStartRotation'
    begin object name="DistributionStartRotation" class=Engine.DistributionVectorUniform
        Max=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    StartRotation=(Distribution=Distribution=DistributionStartRotation,Type=0,Op=2,LookupTableNumElements=2,LookupTableChunkSize=6,LookupTable=(0.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000,0.0000000,0.0000000,0.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
}