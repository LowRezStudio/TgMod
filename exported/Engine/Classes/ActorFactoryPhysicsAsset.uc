class ActorFactoryPhysicsAsset extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() PhysicsAsset PhysicsAsset;
var() SkeletalMesh SkeletalMesh;
var() bool bStartAwake;
var() bool bDamageAppliesImpulse;
var() bool bNotifyRigidBodyCollision;
var() bool bUseCompartment;
var() bool bCastDynamicShadow;
var() Vector InitialVelocity;
var() Vector DrawScale3D;

defaultproperties
{
    bStartAwake=true
    bDamageAppliesImpulse=true
    bCastDynamicShadow=true
    DrawScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    GameplayActorClass=Class'Engine.KAssetSpawnable'
    MenuName="Add PhysicsAsset"
    NewActorClass=Class'Engine.KAsset'
}