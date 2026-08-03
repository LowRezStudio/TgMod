class NxForceFieldCylindricalComponent extends NxForceFieldComponent
    native(ForceField)
    editinlinenew
    collapsecategories
    hidecategories(Collision,Lighting,Physics,Rendering,Object);

var() interp float RadialStrength;
var() interp float RotationalStrength;
var() interp float LiftStrength;
var() interp float ForceRadius;
var() interp float ForceTopRadius;
var() interp float LiftFalloffHeight;
var() interp float EscapeVelocity;
var() interp float ForceHeight;
var() interp float HeightOffset;
var() bool UseSpecialRadialForce;
var native const transient Pointer Kernel;

defaultproperties
{
    LiftStrength=10.0000000
    ForceRadius=200.0000000
    ForceTopRadius=200.0000000
    ForceHeight=200.0000000
    // Reference: ForceFieldShapeCapsule'Engine.Default__NxForceFieldCylindricalComponent.Shape0'
    begin object name="Shape0" class=Engine.ForceFieldShapeCapsule
        // Reference: DrawCapsuleComponent'Engine.Default__NxForceFieldCylindricalComponent.Shape0.DrawCapsule0'
        // TemplateOwnerClass: none
        // TemplateOwnerName: 'DrawCapsule0'
        // Archetype: DrawCapsuleComponent'Engine.Default__ForceFieldShapeCapsule.DrawCapsule0'
        begin object name="DrawCapsule0"
            ReplacementPrimitive=none
        end object
        Shape=DrawCapsule0
    end object
    Shape=Shape0
    ReplacementPrimitive=none
}