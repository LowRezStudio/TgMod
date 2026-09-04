class RB_RadialImpulseComponent extends PrimitiveComponent
    native(Physics)
    hidecategories(Object);

var() PrimitiveComponent.ERadialImpulseFalloff ImpulseFalloff;
var() float ImpulseStrength;
var() float ImpulseRadius;
var() bool bVelChange;
var() bool bCauseFracture;
var export editinline DrawSphereComponent PreviewSphere;

// Export URB_RadialImpulseComponent::execFireImpulse(FFrame&, void* const)
native function FireImpulse(Vector Origin);

defaultproperties
{
    ImpulseStrength=900.0000000
    ImpulseRadius=200.0000000
    ReplacementPrimitive=none
    TickGroup=ETickingGroup.TG_PreAsyncWork
}