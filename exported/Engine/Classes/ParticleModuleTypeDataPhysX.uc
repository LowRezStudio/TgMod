class ParticleModuleTypeDataPhysX extends ParticleModuleTypeDataBase
    native(Particle)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object,Object);

struct native PhysXEmitterVerticalLodProperties
{
    var() float WeightForFifo;
    var() float WeightForSpawnLod;
    var() float SpawnLodRateVsLifeBias;
    var() float RelativeFadeoutTime;

    structdefaultproperties
    {
        WeightForFifo=1.0000000
        WeightForSpawnLod=1.0000000
        SpawnLodRateVsLifeBias=1.0000000
        RelativeFadeoutTime=0.0000000
    }
};

var(PhysXEmitter) PhysXParticleSystem PhysXParSys;
var(PhysXEmitter) PhysXEmitterVerticalLodProperties VerticalLod;

defaultproperties
{
    VerticalLod=(WeightForFifo=1.0000000,WeightForSpawnLod=1.0000000,SpawnLodRateVsLifeBias=1.0000000,RelativeFadeoutTime=0.0000000)
}