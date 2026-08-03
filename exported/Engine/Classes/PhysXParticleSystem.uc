class PhysXParticleSystem extends Object
    native(Particle)
    hidecategories(Object);

enum ESimulationMethod
{
    ESM_SPH,                        // 0
    ESM_NO_PARTICLE_INTERACTION,    // 1
    ESM_MIXED_MODE,                 // 2
    ESM_MAX                         // 3
};

enum EPacketSizeMultiplier
{
    EPSM_4,                         // 0
    EPSM_8,                         // 1
    EPSM_16,                        // 2
    EPSM_32,                        // 3
    EPSM_64,                        // 4
    EPSM_128,                       // 5
    EPSM_MAX                        // 6
};

var(Buffer) int MaxParticles;
var(Buffer) int ParticleSpawnReserve;
var(Collision) const PrimitiveComponent.ERBCollisionChannel RBChannel;
var(SdkExpert) PhysXParticleSystem.ESimulationMethod SimulationMethod;
var(SdkExpert) PhysXParticleSystem.EPacketSizeMultiplier PacketSizeMultiplier;
var(Collision) const RBCollisionChannelContainer RBCollideWithChannels;
var(Collision) float CollisionDistance;
var(Collision) float RestitutionWithStaticShapes;
var(Collision) float RestitutionWithDynamicShapes;
var(Collision) float FrictionWithStaticShapes;
var(Collision) float FrictionWithDynamicShapes;
var(Collision) float StaticFrictionWithStaticShapes;
var(Collision) float StaticFrictionWithDynamicShapes;
var(Collision) bool bDynamicCollision;
var(Dynamics) bool bDisableGravity;
var(SdkExpert) bool bStaticCollision;
var(SdkExpert) bool bTwoWayCollision;
var transient bool bDestroy;
var transient bool bSyncFailed;
var transient bool bIsInGame;
var(Dynamics) float MaxMotionDistance;
var(Dynamics) float Damping;
var(Dynamics) Vector ExternalAcceleration;
var(SdkExpert) float RestParticleDistance;
var(SdkExpert) float RestDensity;
var(SdkExpert) float KernelRadiusMultiplier;
var(SdkExpert) float Stiffness;
var(SdkExpert) float Viscosity;
var(SdkExpert) float CollisionResponseCoefficient;
var native Pointer CascadeScene;
var native Pointer PSys;

defaultproperties
{
    MaxParticles=32767
    RBChannel=ERBCollisionChannel.RBCC_EffectPhysics
    SimulationMethod=ESimulationMethod.ESM_NO_PARTICLE_INTERACTION
    PacketSizeMultiplier=EPacketSizeMultiplier.EPSM_16
    RBCollideWithChannels=(Default=true,Nothing=false,Pawn=false,Vehicle=false,Water=false,GameplayPhysics=true,EffectPhysics=false,Untitled1=false,Untitled2=false,Untitled3=false,Untitled4=false,Cloth=false,FluidDrain=true,SoftBody=false,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    CollisionDistance=10.0000000
    RestitutionWithStaticShapes=0.5000000
    RestitutionWithDynamicShapes=0.5000000
    FrictionWithStaticShapes=0.0500000
    FrictionWithDynamicShapes=0.5000000
    bDynamicCollision=true
    bStaticCollision=true
    MaxMotionDistance=64.0000000
    RestParticleDistance=64.0000000
    RestDensity=1000.0000000
    KernelRadiusMultiplier=2.0000000
    Stiffness=20.0000000
    Viscosity=6.0000000
    CollisionResponseCoefficient=0.2000000
}