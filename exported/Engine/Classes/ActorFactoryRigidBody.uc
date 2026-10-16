class ActorFactoryRigidBody extends ActorFactoryDynamicSM
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() bool bStartAwake;
var() bool bDamageAppliesImpulse;
var() bool bLocalSpaceInitialVelocity;
var() bool bEnableStayUprightSpring;
var() Vector InitialVelocity;
var() export editinline DistributionVector AdditionalVelocity;
var() export editinline DistributionVector InitialAngularVelocity;
var() PrimitiveComponent.ERBCollisionChannel RBChannel;
var() float StayUprightTorqueFactor;
var() float StayUprightMaxTorque;

defaultproperties
{
    bStartAwake=true
    bDamageAppliesImpulse=true
    RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
    StayUprightTorqueFactor=1000.0000000
    StayUprightMaxTorque=1500.0000000
    bNoEncroachCheck=true
    bBlockRigidBody=true
    CollisionType=ECollisionType.COLLIDE_BlockAll
    GameplayActorClass=Class'Engine.KActorSpawnable'
    MenuName="Add RigidBody"
    MenuPriority=15
    NewActorClass=Class'Engine.KActor'
}