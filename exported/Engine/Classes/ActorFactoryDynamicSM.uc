class ActorFactoryDynamicSM extends ActorFactory
    abstract
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() StaticMesh StaticMesh;
var() Vector DrawScale3D;
var() bool bNoEncroachCheck;
var() bool bNotifyRigidBodyCollision;
var() bool bBlockRigidBody;
var() bool bUseCompartment;
var() bool bCastDynamicShadow;
var() Actor.ECollisionType CollisionType;

defaultproperties
{
    DrawScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    bCastDynamicShadow=true
    CollisionType=ECollisionType.COLLIDE_NoCollision
}