class RB_BodyInstance extends Object
    native(Physics)
    hidecategories(Object);

var const export editinline transient PrimitiveComponent OwnerComponent;
var const int BodyIndex;
var Vector Velocity;
var Vector PreviousVelocity;
var native const int SceneIndex;
var native const Pointer BodyData;
var native const Pointer BoneSpring;
var native const Pointer BoneSpringKinActor;
var(BoneSpring) bool bEnableBoneSpringLinear;
var(BoneSpring) bool bEnableBoneSpringAngular;
var(BoneSpring) bool bDisableOnOverextension;
var(BoneSpring) bool bNotifyOwnerOnOverextension;
var(BoneSpring) bool bTeleportOnOverextension;
var(BoneSpring) bool bUseKinActorForBoneSpring;
var(BoneSpring) bool bMakeSpringToBaseCollisionComponent;
var(Physics) const bool bOnlyCollideWithPawns;
var(Physics) const bool bEnableCollisionResponse;
var(Physics) const bool bPushBody;
var private transient bool bForceUnfixed;
var private transient bool bInstanceAlwaysFullAnimWeight;
var(BoneSpring) const float BoneLinearSpring;
var(BoneSpring) const float BoneLinearDamping;
var(BoneSpring) const float BoneAngularSpring;
var(BoneSpring) const float BoneAngularDamping;
var(BoneSpring) float OverextensionThreshold;
var() float CustomGravityFactor;
var transient float LastEffectPlayedTime;
var(Physics) float ContactReportForceThreshold;
var(Physics) float InstanceMassScale;
var(Physics) float InstanceDampingScale;
var(Physics) const PhysicalMaterial PhysMaterialOverride;

// Export URB_BodyInstance::execGetBodyMass(FFrame&, void* const)
native final function float GetBodyMass();

// Export URB_BodyInstance::execSetFixed(FFrame&, void* const)
native final function SetFixed(bool bNewFixed);

// Export URB_BodyInstance::execIsFixed(FFrame&, void* const)
native final function bool IsFixed();

// Export URB_BodyInstance::execIsValidBodyInstance(FFrame&, void* const)
native final function bool IsValidBodyInstance();

// Export URB_BodyInstance::execGetPhysicsAssetInstance(FFrame&, void* const)
native final function PhysicsAssetInstance GetPhysicsAssetInstance();

// Export URB_BodyInstance::execGetUnrealWorldTM(FFrame&, void* const)
native final function Matrix GetUnrealWorldTM();

// Export URB_BodyInstance::execGetUnrealWorldVelocity(FFrame&, void* const)
native final function Vector GetUnrealWorldVelocity();

// Export URB_BodyInstance::execGetUnrealWorldAngularVelocity(FFrame&, void* const)
native final function Vector GetUnrealWorldAngularVelocity();

// Export URB_BodyInstance::execGetUnrealWorldVelocityAtPoint(FFrame&, void* const)
native final function Vector GetUnrealWorldVelocityAtPoint(Vector Point);

// Export URB_BodyInstance::execEnableBoneSpring(FFrame&, void* const)
native final function EnableBoneSpring(bool bInEnableLinear, bool bInEnableAngular, const out Matrix InBoneTarget);

// Export URB_BodyInstance::execSetBoneSpringParams(FFrame&, void* const)
native final function SetBoneSpringParams(float InLinearSpring, float InLinearDamping, float InAngularSpring, float InAngularDamping);

// Export URB_BodyInstance::execSetBoneSpringTarget(FFrame&, void* const)
native final function SetBoneSpringTarget(const out Matrix InBoneTarget, bool bTeleport);

// Export URB_BodyInstance::execSetBlockRigidBody(FFrame&, void* const)
native final function SetBlockRigidBody(bool bNewBlockRigidBody);

// Export URB_BodyInstance::execSetPhysMaterialOverride(FFrame&, void* const)
native final function SetPhysMaterialOverride(PhysicalMaterial NewPhysMaterial);

// Export URB_BodyInstance::execEnableCollisionResponse(FFrame&, void* const)
native final function EnableCollisionResponse(bool bEnableResponse);

// Export URB_BodyInstance::execSetContactReportForceThreshold(FFrame&, void* const)
native final function SetContactReportForceThreshold(float Threshold);

// Export URB_BodyInstance::execUpdateMassProperties(FFrame&, void* const)
native final function UpdateMassProperties(RB_BodySetup Setup);

// Export URB_BodyInstance::execUpdateDampingProperties(FFrame&, void* const)
native final function UpdateDampingProperties();

defaultproperties
{
    bEnableCollisionResponse=true
    BoneLinearSpring=10.0000000
    BoneLinearDamping=0.1000000
    BoneAngularSpring=1.0000000
    BoneAngularDamping=0.1000000
    CustomGravityFactor=1.0000000
    ContactReportForceThreshold=-1.0000000
    InstanceMassScale=1.0000000
    InstanceDampingScale=1.0000000
}