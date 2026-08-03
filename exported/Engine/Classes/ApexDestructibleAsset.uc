class ApexDestructibleAsset extends ApexAsset
    native(Mesh)
    hidecategories(Object,Object);

enum EImpactDamageOverride
{
    IDO_None,                       // 0
    IDO_On,                         // 1
    IDO_Off,                        // 2
    IDO_MAX                         // 3
};

struct native NxDestructibleDepthParameters
{
    var deprecated bool TAKE_IMPACT_DAMAGE;
    var deprecated bool IGNORE_POSE_UPDATES;
    var deprecated bool IGNORE_RAYCAST_CALLBACKS;
    var deprecated bool IGNORE_CONTACT_CALLBACKS;
    var deprecated bool USER_FLAG;
    var deprecated bool USER_FLAG_1;
    var deprecated bool USER_FLAG_2;
    var deprecated bool USER_FLAG_3;
    var() ApexDestructibleAsset.EImpactDamageOverride ImpactDamageOverride;

    structdefaultproperties
    {
        ImpactDamageOverride=EImpactDamageOverride.IDO_None
    }
};

struct native NxDestructibleParametersFlag
{
    var() bool ACCUMULATE_DAMAGE;
    var() bool ASSET_DEFINED_SUPPORT;
    var() bool WORLD_SUPPORT;
    var() bool DEBRIS_TIMEOUT;
    var() bool DEBRIS_MAX_SEPARATION;
    var() bool CRUMBLE_SMALLEST_CHUNKS;
    var() bool ACCURATE_RAYCASTS;
    var() bool USE_VALID_BOUNDS;
    var() bool FORM_EXTENDED_STRUCTURES;

    structdefaultproperties
    {
        ACCUMULATE_DAMAGE=false
        ASSET_DEFINED_SUPPORT=false
        WORLD_SUPPORT=false
        DEBRIS_TIMEOUT=false
        DEBRIS_MAX_SEPARATION=false
        CRUMBLE_SMALLEST_CHUNKS=false
        ACCURATE_RAYCASTS=false
        USE_VALID_BOUNDS=false
        FORM_EXTENDED_STRUCTURES=false
    }
};

struct native NxDestructibleDamageParameters
{
    var() float DamageThreshold;
    var() float DamageSpread;
    var() float ImpactDamage;
    var() float ImpactResistance;
    var() int DefaultImpactDamageDepth;

    structdefaultproperties
    {
        DamageThreshold=0.0000000
        DamageSpread=0.0000000
        ImpactDamage=0.0000000
        ImpactResistance=0.0000000
        DefaultImpactDamageDepth=-1
    }
};

struct native NxDestructibleDebrisParameters
{
    var() float DebrisLifetimeMin;
    var() float DebrisLifetimeMax;
    var() float DebrisMaxSeparationMin;
    var() float DebrisMaxSeparationMax;
    var() Box ValidBounds;

    structdefaultproperties
    {
        DebrisLifetimeMin=0.0000000
        DebrisLifetimeMax=0.0000000
        DebrisMaxSeparationMin=0.0000000
        DebrisMaxSeparationMax=0.0000000
        ValidBounds=(Min=(X=-500000.0000000,Y=-500000.0000000,Z=-500000.0000000),Max=(X=500000.0000000,Y=500000.0000000,Z=500000.0000000),IsValid=0)
    }
};

struct native NxDestructibleAdvancedParameters
{
    var() float DamageCap;
    var() float ImpactVelocityThreshold;
    var() float MaxChunkSpeed;
    var() float MassScaleExponent;
    var() float MassScale;
    var() float FractureImpulseScale;

    structdefaultproperties
    {
        DamageCap=0.0000000
        ImpactVelocityThreshold=0.0000000
        MaxChunkSpeed=0.0000000
        MassScaleExponent=0.0000000
        MassScale=0.0000000
        FractureImpulseScale=0.0000000
    }
};

struct native NxDestructibleParameters
{
    var(Damage) NxDestructibleDamageParameters DamageParameters;
    var(Debris) NxDestructibleDebrisParameters DebrisParameters;
    var(Advanced) NxDestructibleAdvancedParameters AdvancedParameters;
    var deprecated float DamageThreshold;
    var deprecated float DamageToRadius;
    var deprecated float DamageCap;
    var deprecated float ForceToDamage;
    var deprecated float ImpactVelocityThreshold;
    var deprecated float MaterialStrength;
    var deprecated float DamageToPercentDeformation;
    var deprecated float DeformationPercentLimit;
    var deprecated bool bFormExtendedStructures;
    var() int SupportDepth;
    var() int MinimumFractureDepth;
    var() int DebrisDepth;
    var() int EssentialDepth;
    var deprecated float DebrisLifetimeMin;
    var deprecated float DebrisLifetimeMax;
    var deprecated float DebrisMaxSeparationMin;
    var deprecated float DebrisMaxSeparationMax;
    var deprecated Box ValidBounds;
    var deprecated float MaxChunkSpeed;
    var deprecated float MassScaleExponent;
    var() NxDestructibleParametersFlag Flags;
    var deprecated float GrbVolumeLimit;
    var deprecated float GrbParticleSpacing;
    var deprecated float FractureImpulseScale;
    var() editfixedsize array<NxDestructibleDepthParameters> DepthParameters;
    var() int DynamicChunksDominanceGroup;
    var() bool UseDynamicChunksGroupsMask;
    var() const PrimitiveComponent.ERBCollisionChannel DynamicChunksChannel;
    var() const RBCollisionChannelContainer DynamicChunksCollideWithChannels;

    structdefaultproperties
    {
        DamageParameters=(DamageThreshold=0.0000000,DamageSpread=0.0000000,ImpactDamage=0.0000000,ImpactResistance=0.0000000,DefaultImpactDamageDepth=-1)
        DebrisParameters=(DebrisLifetimeMin=0.0000000,DebrisLifetimeMax=0.0000000,DebrisMaxSeparationMin=0.0000000,DebrisMaxSeparationMax=0.0000000,ValidBounds=(Min=(X=-500000.0000000,Y=-500000.0000000,Z=-500000.0000000),Max=(X=500000.0000000,Y=500000.0000000,Z=500000.0000000),IsValid=0))
        AdvancedParameters=(DamageCap=0.0000000,ImpactVelocityThreshold=0.0000000,MaxChunkSpeed=0.0000000,MassScaleExponent=0.0000000,MassScale=0.0000000,FractureImpulseScale=0.0000000)
        SupportDepth=0
        MinimumFractureDepth=0
        DebrisDepth=0
        EssentialDepth=0
        Flags=(ACCUMULATE_DAMAGE=false,ASSET_DEFINED_SUPPORT=false,WORLD_SUPPORT=false,DEBRIS_TIMEOUT=false,DEBRIS_MAX_SEPARATION=false,CRUMBLE_SMALLEST_CHUNKS=false,ACCURATE_RAYCASTS=false,USE_VALID_BOUNDS=false,FORM_EXTENDED_STRUCTURES=false)
        DepthParameters=none
        DynamicChunksDominanceGroup=-1
        UseDynamicChunksGroupsMask=false
        DynamicChunksChannel=ERBCollisionChannel.RBCC_Default
        DynamicChunksCollideWithChannels=(Default=false,Nothing=false,Pawn=false,Vehicle=false,Water=false,GameplayPhysics=false,EffectPhysics=false,Untitled1=false,Untitled2=false,Untitled3=false,Untitled4=false,Cloth=false,FluidDrain=false,SoftBody=false,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    }
};

var native Pointer MApexAsset;
var() const editfixedsize array<MaterialInterface> Materials;
var() const editfixedsize array<FractureMaterial> FractureMaterials;
var() const bool bPlaySingleFractureMaterialEffect;
var bool bHasUniqueAssetMaterialNames;
var deprecated bool bDynamic;
var() PhysicalMaterial DefaultPhysMaterial;
var native Pointer MDestructibleThumbnailComponent;
var() string CrumbleEmitterName;
var() string DustEmitterName;
var() NxDestructibleParameters DestructibleParameters;

defaultproperties
{
    DestructibleParameters=(DamageParameters=(DamageThreshold=0.0000000,DamageSpread=0.0000000,ImpactDamage=0.0000000,ImpactResistance=0.0000000,DefaultImpactDamageDepth=-1),DebrisParameters=(DebrisLifetimeMin=0.0000000,DebrisLifetimeMax=0.0000000,DebrisMaxSeparationMin=0.0000000,DebrisMaxSeparationMax=0.0000000,ValidBounds=(Min=(X=-500000.0000000,Y=-500000.0000000,Z=-500000.0000000),Max=(X=500000.0000000,Y=500000.0000000,Z=500000.0000000),IsValid=0)),AdvancedParameters=(DamageCap=0.0000000,ImpactVelocityThreshold=0.0000000,MaxChunkSpeed=0.0000000,MassScaleExponent=0.0000000,MassScale=0.0000000,FractureImpulseScale=0.0000000),SupportDepth=0,MinimumFractureDepth=0,DebrisDepth=0,EssentialDepth=0,Flags=(ACCUMULATE_DAMAGE=false,ASSET_DEFINED_SUPPORT=false,WORLD_SUPPORT=false,DEBRIS_TIMEOUT=false,DEBRIS_MAX_SEPARATION=false,CRUMBLE_SMALLEST_CHUNKS=false,ACCURATE_RAYCASTS=false,USE_VALID_BOUNDS=false,FORM_EXTENDED_STRUCTURES=false),DepthParameters=none,DynamicChunksDominanceGroup=-1,UseDynamicChunksGroupsMask=false,DynamicChunksChannel=ERBCollisionChannel.RBCC_Default,DynamicChunksCollideWithChannels=(Default=false,Nothing=false,Pawn=false,Vehicle=false,Water=false,GameplayPhysics=false,EffectPhysics=false,Untitled1=false,Untitled2=false,Untitled3=false,Untitled4=false,Cloth=false,FluidDrain=false,SoftBody=false,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false))
}