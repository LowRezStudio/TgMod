class ActorFactoryApexClothing extends ActorFactorySkeletalMesh
    native(Physics)
    config(Editor)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() array<ApexClothingAsset> ClothingAssets;
var() const PrimitiveComponent.ERBCollisionChannel ClothingRBChannel;
var() const RBCollisionChannelContainer ClothingRBCollideWithChannels;

defaultproperties
{
    ClothingRBChannel=ERBCollisionChannel.RBCC_Clothing
    ClothingRBCollideWithChannels=(Default=true,Nothing=false,Pawn=false,Vehicle=false,Water=false,GameplayPhysics=true,EffectPhysics=true,Untitled1=false,Untitled2=false,Untitled3=false,Untitled4=false,Cloth=false,FluidDrain=false,SoftBody=false,FracturedMeshPart=false,BlockingVolume=true,DeadPawn=false,Clothing=false,ClothingCollision=true)
    MenuName="Add Clothing"
}