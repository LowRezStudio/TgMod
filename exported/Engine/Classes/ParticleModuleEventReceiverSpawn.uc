class ParticleModuleEventReceiverSpawn extends ParticleModuleEventReceiverBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object,Object);

var(Spawn) RawDistributionFloat SpawnCount;
var(Spawn) bool bUseParticleTime;
var(Location) bool bUsePSysLocation;
var(Velocity) bool bInheritVelocity;
var(Velocity) RawDistributionVector InheritVelocityScale;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleEventReceiverSpawn.RequiredDistributionSpawnCount'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionSpawnCount'
    begin object name="RequiredDistributionSpawnCount" class=Engine.DistributionFloatConstant
    end object
    // Reference: DistributionVectorConstant'Engine.Default__ParticleModuleEventReceiverSpawn.RequiredDistributionInheritVelocityScale'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionInheritVelocityScale'
    begin object name="RequiredDistributionInheritVelocityScale" class=Engine.DistributionVectorConstant
        Constant=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    end object
    SpawnCount=(Distribution=Distribution=RequiredDistributionSpawnCount,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    InheritVelocityScale=(Distribution=Distribution=RequiredDistributionInheritVelocityScale,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=3,LookupTable=(1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000,1.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    bSpawnModule=true
    bUpdateModule=true
}