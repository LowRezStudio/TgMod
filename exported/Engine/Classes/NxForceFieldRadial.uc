class NxForceFieldRadial extends NxForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var() editinline ForceFieldShape Shape;
var export editinline ActorComponent DrawComponent;
var() interp float ForceStrength;
var() interp float ForceRadius;
var() interp float SelfRotationStrength;
var() export PrimitiveComponent.ERadialImpulseFalloff ForceFalloff;
var native const transient Pointer Kernel;

// Export UNxForceFieldRadial::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    ForceRadius=200.0000000
    Components[0]=none
}