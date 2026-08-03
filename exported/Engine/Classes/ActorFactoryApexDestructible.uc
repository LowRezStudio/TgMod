class ActorFactoryApexDestructible extends ActorFactory
    native
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object);

var() bool bStartAwake;
var() PrimitiveComponent.ERBCollisionChannel RBChannel;
var() const RBCollisionChannelContainer CollideWithChannels;
var() ApexDestructibleAsset DestructibleAsset;

defaultproperties
{
    RBChannel=ERBCollisionChannel.RBCC_EffectPhysics
    CollideWithChannels=(Default=true,Nothing=false,Pawn=false,Vehicle=false,Water=false,GameplayPhysics=true,EffectPhysics=true,Untitled1=false,Untitled2=false,Untitled3=false,Untitled4=false,Cloth=false,FluidDrain=false,SoftBody=false,FracturedMeshPart=false,BlockingVolume=true,DeadPawn=false,Clothing=false,ClothingCollision=false)
    GameplayActorClass=Class'Engine.ApexDestructibleActorSpawnable'
    MenuName="Add ApexDestructibleActor"
    NewActorClass=Class'Engine.ApexDestructibleActor'
}