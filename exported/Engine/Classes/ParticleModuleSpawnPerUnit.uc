class ParticleModuleSpawnPerUnit extends ParticleModuleSpawnBase
    native(Particle)
    editinlinenew
    hidecategories(Object,Object,Object);

var(Spawn) float UnitScalar;
var(Spawn) RawDistributionFloat SpawnPerUnit;
var(Spawn) bool bIgnoreSpawnRateWhenMoving;
var(Spawn) bool bIgnoreMovementAlongX;
var(Spawn) bool bIgnoreMovementAlongY;
var(Spawn) bool bIgnoreMovementAlongZ;
var(Spawn) float MovementTolerance;
var(Spawn) float MaxFrameDistance;
var(Spawn) float MinFrameDistance;

defaultproperties
{
    // Reference: DistributionFloatConstant'Engine.Default__ParticleModuleSpawnPerUnit.RequiredDistributionSpawnPerUnit'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RequiredDistributionSpawnPerUnit'
    begin object name="RequiredDistributionSpawnPerUnit" class=Engine.DistributionFloatConstant
    end object
    UnitScalar=50.0000000
    SpawnPerUnit=(Distribution=Distribution=RequiredDistributionSpawnPerUnit,Type=0,Op=1,LookupTableNumElements=1,LookupTableChunkSize=1,LookupTable=(0.0000000,0.0000000,0.0000000,0.0000000),LookupTableTimeScale=0.0000000,LookupTableStartTime=0.0000000)
    MovementTolerance=0.1000000
    bSpawnModule=true
}