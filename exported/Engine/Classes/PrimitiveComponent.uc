class PrimitiveComponent extends ActorComponent
    abstract
    native(Mesh)
    noexport;

enum EParticleSysParamType
{
    PSPT_None,                      // 0
    PSPT_Scalar,                    // 1
    PSPT_ScalarRand,                // 2
    PSPT_Vector,                    // 3
    PSPT_VectorRand,                // 4
    PSPT_Color,                     // 5
    PSPT_Actor,                     // 6
    PSPT_Material,                  // 7
    PSPT_ValueName,                 // 8
    PSPT_MAX                        // 9
};

enum ERBCollisionChannel
{
    RBCC_Default,                   // 0
    RBCC_Nothing,                   // 1
    RBCC_Pawn,                      // 2
    RBCC_Vehicle,                   // 3
    RBCC_Water,                     // 4
    RBCC_GameplayPhysics,           // 5
    RBCC_EffectPhysics,             // 6
    RBCC_Untitled1,                 // 7
    RBCC_Untitled2,                 // 8
    RBCC_Untitled3,                 // 9
    RBCC_Untitled4,                 // 10
    RBCC_Cloth,                     // 11
    RBCC_FluidDrain,                // 12
    RBCC_SoftBody,                  // 13
    RBCC_FracturedMeshPart,         // 14
    RBCC_BlockingVolume,            // 15
    RBCC_DeadPawn,                  // 16
    RBCC_Clothing,                  // 17
    RBCC_ClothingCollision,         // 18
    RBCC_MAX                        // 19
};

enum GJKResult
{
    GJK_Intersect,                  // 0
    GJK_NoIntersection,             // 1
    GJK_Fail,                       // 2
    GJK_MAX                         // 3
};

enum ERadialImpulseFalloff
{
    RIF_Constant,                   // 0
    RIF_Linear,                     // 1
    RIF_MAX                         // 2
};

struct MaterialViewRelevance
{
    var bool bOpaque;
    var bool bTranslucent;
    var bool bDistortion;
    var bool bOneLayerDistortionRelevance;
    var bool bLit;
    var bool bUsesSceneColor;

    structdefaultproperties
    {
        bOpaque=false
        bTranslucent=false
        bDistortion=false
        bOneLayerDistortionRelevance=false
        bLit=false
        bUsesSceneColor=false
    }
};

struct native ParticleSysParam
{
    var() name Name;
    var() PrimitiveComponent.EParticleSysParamType ParamType;
    var() float Scalar;
    var() float Scalar_Low;
    var() Vector Vector;
    var() Vector Vector_Low;
    var() Color Color;
    var() Actor Actor;
    var() MaterialInterface Material;
    var() name ValueName;

    structdefaultproperties
    {
        Name="None"
        ParamType=EParticleSysParamType.PSPT_None
        Scalar=0.0000000
        Scalar_Low=0.0000000
        Vector=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Vector_Low=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        Color=(R=0,G=0,B=0,A=0)
        Actor=none
        Material=none
        ValueName="None"
    }
};

struct RBCollisionChannelContainer
{
    var() const bool Default;
    var const bool Nothing;
    var() const bool Pawn;
    var() const bool Vehicle;
    var() const bool Water;
    var() const bool GameplayPhysics;
    var() const bool EffectPhysics;
    var() const bool Untitled1;
    var() const bool Untitled2;
    var() const bool Untitled3;
    var() const bool Untitled4;
    var() const bool Cloth;
    var() const bool FluidDrain;
    var() const bool SoftBody;
    var() const bool FracturedMeshPart;
    var() const bool BlockingVolume;
    var() const bool DeadPawn;
    var() const bool Clothing;
    var() const bool ClothingCollision;

    structdefaultproperties
    {
        Default=false
        Nothing=false
        Pawn=false
        Vehicle=false
        Water=false
        GameplayPhysics=false
        EffectPhysics=false
        Untitled1=false
        Untitled2=false
        Untitled3=false
        Untitled4=false
        Cloth=false
        FluidDrain=false
        SoftBody=false
        FracturedMeshPart=false
        BlockingVolume=false
        DeadPawn=false
        Clothing=false
        ClothingCollision=false
    }
};

var native const transient int Tag;
var native const transient int ThreadTag[5];
var native const transient BoxSphereBounds Bounds;
var private native const transient Pointer SceneInfo;
var private native const int DetachFence;
var native const transient float LocalToWorldDeterminant;
var native const transient Matrix LocalToWorld;
var native const transient int MotionBlurInfoIndex;
var private noimport native const array<Pointer> DecalList;
var private const export editinline transient array<export editinline DecalComponent> DecalsToReattach;
var const export editinline PrimitiveComponent ShadowParent;
var(Rendering) crosslevelpassive export editinline PrimitiveComponent ReplacementPrimitive;
var const export editinline transient FogVolumeDensityComponent FogVolumeComponent;
var const export editinline transient LightComponent OverrideLightComponent;
var const export editinline LightEnvironmentComponent LightEnvironment;
var private const export editinline transient LightEnvironmentComponent PreviousLightEnvironment;
var(Rendering) float MinDrawDistance;
var(Rendering) float MassiveLODDistance;
var(Rendering) private const noexport float MaxDrawDistance;
var(Rendering) editconst float CachedMaxDrawDistance;
var(Rendering) float MotionBlurInstanceScale;
var private const noexport deprecated float CullDistance;
var editconst deprecated float CachedCullDistance;
var(Rendering) const Scene.ESceneDepthPriorityGroup DepthPriorityGroup;
var const Scene.ESceneDepthPriorityGroup ViewOwnerDepthPriorityGroup;
var(Rendering) const Scene.EDetailMode DetailMode;
var(Collision) const PrimitiveComponent.ERBCollisionChannel RBChannel;
var(Physics) byte RBDominanceGroup;
var byte PreviewEnvironmentShadowing;
var const bool bUseViewOwnerDepthPriorityGroup;
var(Rendering) const bool bAllowCullDistanceVolume;
var(Rendering) const bool HiddenGame;
var(Rendering) const bool HiddenEditor;
var(Rendering) const bool bOwnerNoSee;
var(Rendering) const bool bOnlyOwnerSee;
var(Rendering) const bool bIgnoreOwnerHidden;
var bool bUseAsOccluder;
var(Rendering) bool bAllowApproximateOcclusion;
var bool bFirstFrameOcclusion;
var bool bIgnoreNearPlaneIntersection;
var bool bSelectable;
var(Rendering) const bool bForceMipStreaming;
var const deprecated bool bAcceptsDecals;
var const deprecated bool bAcceptsDecalsDuringGameplay;
var(Rendering) const bool bAcceptsStaticDecals;
var(Rendering) const bool bAcceptsDynamicDecals;
var native const transient bool bIsRefreshingDecals;
var transient bool bAllowDecalAutomaticReAttach;
var bool bUsePerInstanceHitProxies;
var(Lighting) bool CastShadow;
var const bool bForceDirectLightMap;
var(Lighting) bool bCastDynamicShadow;
var(Lighting) bool bCastStaticShadow;
var(Lighting) bool bSelfShadowOnly;
var(Lighting) bool bNoModSelfShadow;
var(Lighting) bool bAcceptsDynamicDominantLightShadows;
var(Lighting) bool bCastHiddenShadow;
var(Lighting) bool bCastShadowAsTwoSided;
var(Lighting) const bool bAcceptsLights;
var(Lighting) const bool bAcceptsDynamicLights;
var(Lighting) const bool bUseOnePassLightingOnTranslucency;
var(Lighting) const bool bUsePrecomputedShadows;
var private const transient bool bHasExplicitShadowParent;
var deprecated bool bAllowAmbientOcclusion;
var(Collision) const bool CollideActors;
var const bool AlwaysCheckCollision;
var(Collision) const bool BlockActors;
var(Collision) const bool BlockZeroExtent;
var(Collision) const bool BlockNonZeroExtent;
var(Collision) const bool CanBlockCamera;
var(Collision) const bool BlockRigidBody;
var(Collision) const bool bBlockFootPlacement;
var(Collision) const bool bSeenByAI;
var(Physics) const bool bDisableAllRigidBody;
var(Physics) const bool bSkipRBGeomCreation;
var(Physics) const bool bNotifyRigidBodyCollision;
var(Physics) const bool bFluidDrain;
var(Physics) const bool bFluidTwoWay;
var(Physics) bool bIgnoreRadialImpulse;
var(Physics) bool bIgnoreRadialForce;
var(Physics) bool bIgnoreForceField;
var(Physics) const bool bUseCompartment;
var private const bool AlwaysLoadOnClient;
var private const bool AlwaysLoadOnServer;
var() bool bIgnoreHiddenActorsMembership;
var() const bool AbsoluteTranslation;
var() const bool AbsoluteRotation;
var() const bool AbsoluteScale;
var bool bAllowShadowFade;
var bool bSupportedOnMobile;
var native const transient bool bWasSNFiltered;
var native const transient array<int> OctreeNodes;
var(Rendering) int TranslucencySortPriority;
var duplicatetransient int VisibilityId;
var(Lighting) const LightingChannelContainer LightingChannels;
var(Collision) const RBCollisionChannelContainer RBCollideWithChannels;
var(Physics) const PhysicalMaterial PhysMaterialOverride;
var duplicatetransient native const RB_BodyInstance BodyInstance;
var native const transient Matrix CachedParentToWorld;
var() const Vector Translation;
var() const Rotator Rotation;
var() const float Scale;
var() const Vector Scale3D;
var() const float BoundsScale;
var() const Vector OcclusionBoundsScale;
var() const float OcclusionSphereScale;
var float OverrideDrawDistanceScale;
var const transient float LastSubmitTime;
var transient float LastRenderTime;
var float ScriptRigidBodyCollisionThreshold;

// Export UPrimitiveComponent::execAddImpulse(FFrame&, void* const)
native final function AddImpulse(Vector Impulse, optional Vector Position, optional name BoneName, optional bool bVelChange);

// Export UPrimitiveComponent::execAddRadialImpulse(FFrame&, void* const)
native final function AddRadialImpulse(Vector Origin, float Radius, float Strength, PrimitiveComponent.ERadialImpulseFalloff Falloff, optional bool bVelChange);

// Export UPrimitiveComponent::execAddForce(FFrame&, void* const)
native final function AddForce(Vector Force, optional Vector Position, optional name BoneName);

// Export UPrimitiveComponent::execAddRadialForce(FFrame&, void* const)
native final function AddRadialForce(Vector Origin, float Radius, float Strength, PrimitiveComponent.ERadialImpulseFalloff Falloff);

// Export UPrimitiveComponent::execAddTorque(FFrame&, void* const)
native final function AddTorque(Vector Torque, optional name BoneName);

// Export UPrimitiveComponent::execSetRBLinearVelocity(FFrame&, void* const)
native final function SetRBLinearVelocity(Vector NewVel, optional bool bAddToCurrent);

// Export UPrimitiveComponent::execSetRBAngularVelocity(FFrame&, void* const)
native final function SetRBAngularVelocity(Vector NewAngVel, optional bool bAddToCurrent);

// Export UPrimitiveComponent::execRetardRBLinearVelocity(FFrame&, void* const)
native final function RetardRBLinearVelocity(Vector RetardDir, float VelScale);

// Export UPrimitiveComponent::execSetRBPosition(FFrame&, void* const)
native final function SetRBPosition(Vector NewPos, optional name BoneName);

// Export UPrimitiveComponent::execSetRBRotation(FFrame&, void* const)
native final function SetRBRotation(Rotator NewRot, optional name BoneName);

// Export UPrimitiveComponent::execWakeRigidBody(FFrame&, void* const)
native final function WakeRigidBody(optional name BoneName);

// Export UPrimitiveComponent::execPutRigidBodyToSleep(FFrame&, void* const)
native final function PutRigidBodyToSleep(optional name BoneName);

// Export UPrimitiveComponent::execRigidBodyIsAwake(FFrame&, void* const)
native final function bool RigidBodyIsAwake(optional name BoneName);

// Export UPrimitiveComponent::execSetBlockRigidBody(FFrame&, void* const)
native final function SetBlockRigidBody(bool bNewBlockRigidBody);

// Export UPrimitiveComponent::execSetRBCollidesWithChannel(FFrame&, void* const)
native final function SetRBCollidesWithChannel(PrimitiveComponent.ERBCollisionChannel Channel, bool bNewCollides);

// Export UPrimitiveComponent::execSetRBCollisionChannels(FFrame&, void* const)
native final function SetRBCollisionChannels(RBCollisionChannelContainer Channels);

// Export UPrimitiveComponent::execSetRBChannel(FFrame&, void* const)
native final function SetRBChannel(PrimitiveComponent.ERBCollisionChannel Channel);

// Export UPrimitiveComponent::execSetNotifyRigidBodyCollision(FFrame&, void* const)
native final function SetNotifyRigidBodyCollision(bool bNewNotifyRigidBodyCollision);

// Export UPrimitiveComponent::execInitRBPhys(FFrame&, void* const)
native final function InitRBPhys();

// Export UPrimitiveComponent::execSetPhysMaterialOverride(FFrame&, void* const)
native final function SetPhysMaterialOverride(PhysicalMaterial NewPhysMaterial);

// Export UPrimitiveComponent::execGetRootBodyInstance(FFrame&, void* const)
native final function RB_BodyInstance GetRootBodyInstance();

// Export UPrimitiveComponent::execSetRBDominanceGroup(FFrame&, void* const)
native final function SetRBDominanceGroup(byte InDomGroup);

// Export UPrimitiveComponent::execShouldComponentAddToScene(FFrame&, void* const)
native final function bool ShouldComponentAddToScene();

// Export UPrimitiveComponent::execSetHidden(FFrame&, void* const)
native final function SetHidden(bool NewHidden);

// Export UPrimitiveComponent::execSetOwnerNoSee(FFrame&, void* const)
native final function SetOwnerNoSee(bool bNewOwnerNoSee);

// Export UPrimitiveComponent::execSetOnlyOwnerSee(FFrame&, void* const)
native final function SetOnlyOwnerSee(bool bNewOnlyOwnerSee);

// Export UPrimitiveComponent::execSetIgnoreOwnerHidden(FFrame&, void* const)
native final function SetIgnoreOwnerHidden(bool bNewIgnoreOwnerHidden);

// Export UPrimitiveComponent::execSetShadowParent(FFrame&, void* const)
native final function SetShadowParent(PrimitiveComponent NewShadowParent);

// Export UPrimitiveComponent::execSetLightEnvironment(FFrame&, void* const)
native final function SetLightEnvironment(LightEnvironmentComponent NewLightEnvironment);

// Export UPrimitiveComponent::execSetCullDistance(FFrame&, void* const)
native final function SetCullDistance(float NewCullDistance);

// Export UPrimitiveComponent::execSetLightingChannels(FFrame&, void* const)
native final function SetLightingChannels(LightingChannelContainer NewLightingChannels);

// Export UPrimitiveComponent::execSetDepthPriorityGroup(FFrame&, void* const)
native final function SetDepthPriorityGroup(Scene.ESceneDepthPriorityGroup NewDepthPriorityGroup);

// Export UPrimitiveComponent::execSetViewOwnerDepthPriorityGroup(FFrame&, void* const)
native final function SetViewOwnerDepthPriorityGroup(bool bNewUseViewOwnerDepthPriorityGroup, Scene.ESceneDepthPriorityGroup NewViewOwnerDepthPriorityGroup);

// Export UPrimitiveComponent::execSetTraceBlocking(FFrame&, void* const)
native final function SetTraceBlocking(bool NewBlockZeroExtent, bool NewBlockNonZeroExtent);

// Export UPrimitiveComponent::execSetActorCollision(FFrame&, void* const)
native final function SetActorCollision(bool NewCollideActors, bool NewBlockActors, optional bool NewAlwaysCheckCollision);

// Export UPrimitiveComponent::execSetTranslation(FFrame&, void* const)
native function SetTranslation(Vector NewTranslation);

// Export UPrimitiveComponent::execSetRotation(FFrame&, void* const)
native function SetRotation(Rotator NewRotation);

// Export UPrimitiveComponent::execSetScale(FFrame&, void* const)
native function SetScale(float NewScale);

// Export UPrimitiveComponent::execSetScale3D(FFrame&, void* const)
native function SetScale3D(Vector NewScale3D);

// Export UPrimitiveComponent::execSetAbsolute(FFrame&, void* const)
native function SetAbsolute(optional bool NewAbsoluteTranslation, optional bool NewAbsoluteRotation, optional bool NewAbsoluteScale);

// Export UPrimitiveComponent::execGetPosition(FFrame&, void* const)
native function Vector GetPosition();

// Export UPrimitiveComponent::execGetRotation(FFrame&, void* const)
native function Rotator GetRotation();

// Export UPrimitiveComponent::execClosestPointOnComponentToPoint(FFrame&, void* const)
native final function PrimitiveComponent.GJKResult ClosestPointOnComponentToPoint(out Vector POI, out Vector Extent, out Vector OutPointA, out Vector OutPointB);

// Export UPrimitiveComponent::execClosestPointOnComponentToComponent(FFrame&, void* const)
native function PrimitiveComponent.GJKResult ClosestPointOnComponentToComponent(out PrimitiveComponent OtherComponent, out Vector PointOnComponentA, out Vector PointOnComponentB);

defaultproperties
{
    ReplacementPrimitive=none
    MotionBlurInstanceScale=1.0000000
    DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_World
    RBDominanceGroup=15
    PreviewEnvironmentShadowing=180
    bAllowCullDistanceVolume=true
    bSelectable=true
    bAcceptsDynamicDecals=true
    bAllowDecalAutomaticReAttach=true
    bCastDynamicShadow=true
    bCastStaticShadow=true
    bAcceptsDynamicDominantLightShadows=true
    bAcceptsDynamicLights=true
    CanBlockCamera=true
    bBlockFootPlacement=true
    AlwaysLoadOnClient=true
    AlwaysLoadOnServer=true
    bAllowShadowFade=true
    bSupportedOnMobile=true
    VisibilityId=-1
    Scale=1.0000000
    Scale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    BoundsScale=1.0000000
    OcclusionBoundsScale=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    OcclusionSphereScale=1.0000000
    OverrideDrawDistanceScale=-1.0000000
    LastRenderTime=-1000.0000000
}