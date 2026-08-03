class NxForceFieldComponent extends PrimitiveComponent
    abstract
    native(ForceField)
    editinlinenew
    collapsecategories
    hidecategories(Collision,Lighting,Physics,Rendering,Object);

var() export editinline ForceFieldShape Shape;
var export editinline ActorComponent DrawComponent;
var() int ExcludeChannel;
var() bool bForceActive;
var() bool bDestroyWhenInactive;
var() const RBCollisionChannelContainer CollideWithChannels;
var() float Duration;
var native const transient Pointer ForceField;
var native const transient array<Pointer> ConvexMeshes;
var native const transient array<Pointer> ExclusionShapes;
var native const transient array<Pointer> ExclusionShapePoses;
var native const int SceneIndex;
var float ElapsedTime;
var export editinline PrimitiveComponent RenderComponent;
var native Pointer RBPhysScene;

// Export UNxForceFieldComponent::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    bForceActive=true
    bDestroyWhenInactive=true
    CollideWithChannels=(Default=true,Nothing=false,Pawn=true,Vehicle=true,Water=true,GameplayPhysics=true,EffectPhysics=true,Untitled1=true,Untitled2=true,Untitled3=true,Untitled4=false,Cloth=true,FluidDrain=true,SoftBody=false,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    ReplacementPrimitive=none
    RBChannel=ERBCollisionChannel.RBCC_Nothing
    TickGroup=ETickingGroup.TG_PreAsyncWork
}