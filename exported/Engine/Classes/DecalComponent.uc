class DecalComponent extends PrimitiveComponent
    native(Decal)
    editinlinenew
    hidecategories(Collision,Object,Physics,PrimitiveComponent);

enum EDecalTransform
{
    DecalTransform_OwnerAbsolute,   // 0
    DecalTransform_OwnerRelative,   // 1
    DecalTransform_SpawnRelative,   // 2
    DecalTransform_MAX              // 3
};

enum EFilterMode
{
    FM_None,                        // 0
    FM_Ignore,                      // 1
    FM_Affect,                      // 2
    FM_MAX                          // 3
};

struct native DecalReceiver
{
    var const export editinline PrimitiveComponent Component;
    var native const Pointer RenderData;

    structdefaultproperties
    {
        Component=none
    }
};

var(Decal) private const MaterialInterface DecalMaterial;
var(Decal) float Width;
var(Decal) float Height;
var(Decal) float TileX;
var(Decal) float TileY;
var(Decal) float OffsetX;
var(Decal) float OffsetY;
var(Decal) float DecalRotation;
var float FieldOfView;
var(Decal) float NearPlane;
var(Decal) float FarPlane;
var transient Vector Location;
var transient Rotator Orientation;
var Vector HitLocation;
var Vector HitNormal;
var Vector HitTangent;
var Vector HitBinormal;
var(Decal) bool bNoClip;
var const bool bStaticDecal;
var(GlobalAgenda) bool m_bIsGameplayDecal;
var(DecalFilter) bool bProjectOnBackfaces;
var(DecalFilter) bool bProjectOnHidden;
var(DecalFilter) bool bProjectOnBSP;
var(DecalFilter) bool bProjectOnStaticMeshes;
var(DecalFilter) bool bProjectOnSkeletalMeshes;
var(DecalFilter) bool bProjectOnTerrain;
var bool bFlipBackfaceDirection;
var bool bMovableDecal;
var private transient bool bHasBeenAttached;
var() bool bDecalMaterialSetAtRunTime;
var export editinline transient PrimitiveComponent HitComponent;
var transient name HitBone;
var transient int HitNodeIndex;
var transient int HitLevelIndex;
var transient int FracturedStaticMeshComponentIndex;
var private const transient array<int> HitNodeIndices;
var private noimport duplicatetransient const array<DecalReceiver> DecalReceivers;
var private noimport duplicatetransient native const transient array<Pointer> StaticReceivers;
var duplicatetransient native const transient Pointer ReleaseResourcesFence;
var private transient array<Plane> Planes;
var(DecalRender) float DepthBias;
var(DecalRender) float SlopeScaleDepthBias;
var(DecalRender) float OrbisDepthBias;
var(DecalRender) float OrbisSlopeScaleDepthBias;
var(DecalRender) int SortOrder;
var(DecalRender) float BackfaceAngle;
var(DecalRender) Vector2D BlendRange;
var(DecalRender) const float StreamingDistanceMultiplier;
var const DecalComponent.EDecalTransform DecalTransform;
var(DecalFilter) DecalComponent.EFilterMode FilterMode;
var(DecalFilter) array<Actor> Filter;
var(DecalFilter) export editinline array<export editinline PrimitiveComponent> ReceiverImages;
var(DecalRender) Vector ParentRelativeLocation;
var(DecalRender) Rotator ParentRelativeOrientation;
var private const transient Matrix ParentRelLocRotMatrix;

// Export UDecalComponent::execResetToDefaults(FFrame&, void* const)
native final function ResetToDefaults();

// Export UDecalComponent::execSetDecalMaterial(FFrame&, void* const)
native final function SetDecalMaterial(MaterialInterface NewDecalMaterial);

// Export UDecalComponent::execGetDecalMaterial(FFrame&, void* const)
native final function MaterialInterface GetDecalMaterial();

// Export UDecalComponent::execIsWaitingForResetToDefaultsToComplete(FFrame&, void* const)
native final function bool IsWaitingForResetToDefaultsToComplete();

// Export UDecalComponent::execSetParentRelativeLocation(FFrame&, void* const)
native final function SetParentRelativeLocation(Vector relLoc);

defaultproperties
{
    Width=200.0000000
    Height=200.0000000
    TileX=1.0000000
    TileY=1.0000000
    FieldOfView=80.0000000
    FarPlane=300.0000000
    bProjectOnBSP=true
    bProjectOnStaticMeshes=true
    bProjectOnSkeletalMeshes=true
    bProjectOnTerrain=true
    HitNodeIndex=-1
    HitLevelIndex=-1
    DepthBias=-0.0000600
    OrbisDepthBias=-1.6000000
    OrbisSlopeScaleDepthBias=50.0000000
    BackfaceAngle=0.0010000
    BlendRange=(X=89.5000000,Y=180.0000000)
    StreamingDistanceMultiplier=1.0000000
    DecalTransform=EDecalTransform.DecalTransform_SpawnRelative
    ReplacementPrimitive=none
    bAcceptsDynamicDecals=false
    bCastDynamicShadow=false
    bAcceptsDynamicLights=false
}