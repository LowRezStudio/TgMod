class NxGenericForceFieldBrush extends Volume
    native(ForceField)
    placeable
    hidecategories(Navigation,Object,Movement,Display);

enum FFB_ForceFieldCoordinates
{
    FFB_CARTESIAN,                  // 0
    FFB_SPHERICAL,                  // 1
    FFB_CYLINDRICAL,                // 2
    FFB_TOROIDAL,                   // 3
    FFB_MAX                         // 4
};

var() int ExcludeChannel;
var() RBCollisionChannelContainer CollideWithChannels;
var() const PrimitiveComponent.ERBCollisionChannel RBChannel;
var() NxGenericForceFieldBrush.FFB_ForceFieldCoordinates Coordinates;
var() Vector Constant;
var() Vector PositionMultiplierX;
var() Vector PositionMultiplierY;
var() Vector PositionMultiplierZ;
var() Vector PositionTarget;
var() Vector VelocityMultiplierX;
var() Vector VelocityMultiplierY;
var() Vector VelocityMultiplierZ;
var() Vector VelocityTarget;
var() Vector Noise;
var() Vector FalloffLinear;
var() Vector FalloffQuadratic;
var() float TorusRadius;
var native const transient Pointer ForceField;
var native const transient array<Pointer> ConvexMeshes;
var native const transient array<Pointer> ExclusionShapes;
var native const transient array<Pointer> ExclusionShapePoses;
var native const transient Pointer LinearKernel;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x43
    if(BrushComponent != none)
    {
        bProjTarget = BrushComponent.BlockZeroExtent;
    }
    //return;    
}

simulated function bool StopsProjectile(Projectile P)
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    ExcludeChannel=1
    CollideWithChannels=(Default=true,Nothing=false,Pawn=true,Vehicle=true,Water=true,GameplayPhysics=true,EffectPhysics=true,Untitled1=true,Untitled2=true,Untitled3=true,Untitled4=false,Cloth=true,FluidDrain=true,SoftBody=true,FracturedMeshPart=false,BlockingVolume=false,DeadPawn=false,Clothing=false,ClothingCollision=false)
    RBChannel=ERBCollisionChannel.RBCC_Untitled1
    TorusRadius=1.0000000
    BrushColor=(R=100,G=255,B=100,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__NxGenericForceFieldBrush.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        bDisableAllRigidBody=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    bProjTarget=true
    CollisionComponent=BrushComponent0
    SupportedEvents=none
}