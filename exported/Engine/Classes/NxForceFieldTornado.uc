class NxForceFieldTornado extends NxForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var() editinline ForceFieldShape Shape;
var export editinline ActorComponent DrawComponent;
var() interp float RadialStrength;
var() interp float RotationalStrength;
var() interp float LiftStrength;
var() interp float ForceRadius;
var() interp float ForceTopRadius;
var() interp float LiftFalloffHeight;
var() interp float EscapeVelocity;
var() interp float ForceHeight;
var() interp float HeightOffset;
var() bool BSpecialRadialForceMode;
var() interp float SelfRotationStrength;
var native const transient Pointer Kernel;

// Export UNxForceFieldTornado::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    ForceRadius=200.0000000
    ForceTopRadius=200.0000000
    ForceHeight=200.0000000
    Components[0]=none
}