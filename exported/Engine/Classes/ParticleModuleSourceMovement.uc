class ParticleModuleSourceMovement extends ParticleModuleLocationBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(SourceMovement) RawDistributionVector SourceMovementScale;

defaultproperties
{
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleSourceMovement.DistributionSourceMovementScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DistributionSourceMovementScale'
    begin object name="DistributionSourceMovementScale" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    SourceMovementScale=(Distribution=Distribution=DistributionSourceMovementScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bFinalUpdateModule=true
}