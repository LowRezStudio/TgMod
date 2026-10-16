class NxForceFieldGeneric extends NxForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

enum FFG_ForceFieldCoordinates
{
    FFG_CARTESIAN,                  // 0
    FFG_SPHERICAL,                  // 1
    FFG_CYLINDRICAL,                // 2
    FFG_TOROIDAL,                   // 3
    FFG_MAX                         // 4
};

var() editinline ForceFieldShape Shape;
var export editinline ActorComponent DrawComponent;
var() float RoughExtentX;
var() float RoughExtentY;
var() float RoughExtentZ;
var() NxForceFieldGeneric.FFG_ForceFieldCoordinates Coordinates;
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
var native const transient Pointer LinearKernel;

// Export UNxForceFieldGeneric::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    RoughExtentX=200.0000000
    RoughExtentY=200.0000000
    RoughExtentZ=200.0000000
    TorusRadius=1.0000000
    Components[0]=none
}