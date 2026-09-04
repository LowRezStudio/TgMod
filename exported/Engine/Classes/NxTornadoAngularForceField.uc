class NxTornadoAngularForceField extends NxForceField
    abstract
    native(ForceField)
    notplaceable
    hidecategories(Navigation);

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

defaultproperties
{
    ForceRadius=200.0000000
}