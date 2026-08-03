class ParticleModuleTypeDataMeshPhysX extends ParticleModuleTypeDataMesh
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object,Object);

enum EPhysXMeshRotationMethod
{
    PMRM_Disabled,                  // 0
    PMRM_Spherical,                 // 1
    PMRM_Box,                       // 2
    PMRM_LongBox,                   // 3
    PMRM_FlatBox,                   // 4
    PMRM_Velocity,                  // 5
    PMRM_MAX                        // 6
};

var(PhysXEmitter) PhysXParticleSystem PhysXParSys;
var(PhysXEmitter) ParticleModuleTypeDataMeshPhysX.EPhysXMeshRotationMethod PhysXRotationMethod;
var(PhysXEmitter) float FluidRotationCoefficient;
var(PhysXEmitter) PhysXEmitterVerticalLodProperties VerticalLod;
var(PhysXEmitter) float ZOffset;

defaultproperties
{
    PhysXRotationMethod=EPhysXMeshRotationMethod.PMRM_Spherical
    FluidRotationCoefficient=5.0000000
    VerticalLod=(WeightForFifo=1.0000000,WeightForSpawnLod=1.0000000,SpawnLodRateVsLifeBias=1.0000000,RelativeFadeoutTime=0.0000000)
}