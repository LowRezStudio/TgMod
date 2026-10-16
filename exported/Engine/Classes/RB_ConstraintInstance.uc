class RB_ConstraintInstance extends Object
    native(Physics)
    hidecategories(Object);

var const transient Actor Owner;
var const export editinline transient PrimitiveComponent OwnerComponent;
var const int ConstraintIndex;
var native const int SceneIndex;
var native const bool bInHardware;
var(Linear) const bool bLinearXPositionDrive;
var(Linear) const bool bLinearXVelocityDrive;
var(Linear) const bool bLinearYPositionDrive;
var(Linear) const bool bLinearYVelocityDrive;
var(Linear) const bool bLinearZPositionDrive;
var(Linear) const bool bLinearZVelocityDrive;
var(Angular) const bool bSwingPositionDrive;
var(Angular) const bool bSwingVelocityDrive;
var(Angular) const bool bTwistPositionDrive;
var(Angular) const bool bTwistVelocityDrive;
var(Angular) const bool bAngularSlerpDrive;
var bool bTerminated;
var native const Pointer ConstraintData;
var(Linear) const Vector LinearPositionTarget;
var(Linear) const Vector LinearVelocityTarget;
var(Linear) const float LinearDriveSpring;
var(Linear) const float LinearDriveDamping;
var(Linear) const float LinearDriveForceLimit;
var(Angular) const Quat AngularPositionTarget;
var(Angular) const Vector AngularVelocityTarget;
var(Angular) const float AngularDriveSpring;
var(Angular) const float AngularDriveDamping;
var(Angular) const float AngularDriveForceLimit;
var private native const Pointer DummyKinActor;

// Export URB_ConstraintInstance::execInitConstraint(FFrame&, void* const)
native final function InitConstraint(PrimitiveComponent PrimComp1, PrimitiveComponent PrimComp2, RB_ConstraintSetup Setup, float Scale, Actor InOwner, PrimitiveComponent InPrimComp, bool bMakeKinForBody1);

// Export URB_ConstraintInstance::execTermConstraint(FFrame&, void* const)
native final function TermConstraint();

// Export URB_ConstraintInstance::execGetPhysicsAssetInstance(FFrame&, void* const)
native final function PhysicsAssetInstance GetPhysicsAssetInstance();

// Export URB_ConstraintInstance::execGetConstraintLocation(FFrame&, void* const)
native final function Vector GetConstraintLocation();

// Export URB_ConstraintInstance::execSetLinearPositionDrive(FFrame&, void* const)
native final function SetLinearPositionDrive(bool bEnableXDrive, bool bEnableYDrive, bool bEnableZDrive);

// Export URB_ConstraintInstance::execSetLinearVelocityDrive(FFrame&, void* const)
native final function SetLinearVelocityDrive(bool bEnableXDrive, bool bEnableYDrive, bool bEnableZDrive);

// Export URB_ConstraintInstance::execSetAngularPositionDrive(FFrame&, void* const)
native final function SetAngularPositionDrive(bool bEnableSwingDrive, bool bEnableTwistDrive);

// Export URB_ConstraintInstance::execSetAngularVelocityDrive(FFrame&, void* const)
native final function SetAngularVelocityDrive(bool bEnableSwingDrive, bool bEnableTwistDrive);

// Export URB_ConstraintInstance::execSetLinearPositionTarget(FFrame&, void* const)
native final function SetLinearPositionTarget(Vector InPosTarget);

// Export URB_ConstraintInstance::execSetLinearVelocityTarget(FFrame&, void* const)
native final function SetLinearVelocityTarget(Vector InVelTarget);

// Export URB_ConstraintInstance::execSetLinearDriveParams(FFrame&, void* const)
native final function SetLinearDriveParams(float InSpring, float InDamping, float InForceLimit);

// Export URB_ConstraintInstance::execSetAngularPositionTarget(FFrame&, void* const)
native final function SetAngularPositionTarget(const out Quat InPosTarget);

// Export URB_ConstraintInstance::execSetAngularVelocityTarget(FFrame&, void* const)
native final function SetAngularVelocityTarget(Vector InVelTarget);

// Export URB_ConstraintInstance::execSetAngularDriveParams(FFrame&, void* const)
native final function SetAngularDriveParams(float InSpring, float InDamping, float InForceLimit);

// Export URB_ConstraintInstance::execSetAngularDOFLimitScale(FFrame&, void* const)
native final function SetAngularDOFLimitScale(float InSwing1LimitScale, float InSwing2LimitScale, float InTwistLimitScale, RB_ConstraintSetup InSetup);

// Export URB_ConstraintInstance::execSetLinearLimitSize(FFrame&, void* const)
native final function SetLinearLimitSize(float NewLimitSize);

// Export URB_ConstraintInstance::execMoveKinActorTransform(FFrame&, void* const)
native final function MoveKinActorTransform(out Matrix NewTM);

defaultproperties
{
    LinearDriveSpring=50.0000000
    LinearDriveDamping=1.0000000
    AngularPositionTarget=(X=0.0000000,Y=0.0000000,Z=0.0000000,W=1.0000000)
    AngularDriveSpring=50.0000000
    AngularDriveDamping=1.0000000
}