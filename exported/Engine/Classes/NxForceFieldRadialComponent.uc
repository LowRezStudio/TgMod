class NxForceFieldRadialComponent extends NxForceFieldComponent
    native(ForceField)
    editinlinenew
    collapsecategories
    hidecategories(Collision,Lighting,Physics,Rendering,Object);

var() interp float ForceStrength;
var() interp float ForceRadius;
var() interp float SelfRotationStrength;
var() export PrimitiveComponent.ERadialImpulseFalloff ForceFalloff;
var native const transient Pointer Kernel;

defaultproperties
{
    ForceStrength=200.0000000
    ForceRadius=200.0000000
    SelfRotationStrength=200.0000000
    // Reference: ForceFieldShapeSphere'Engine.Default__NxForceFieldRadialComponent.Shape0'
    begin object name="Shape0" class=Engine.ForceFieldShapeSphere
        // Reference: DrawSphereComponent'Engine.Default__NxForceFieldRadialComponent.Shape0.DrawSphere0'
        // TemplateOwnerClass: none
        // TemplateOwnerName: 'DrawSphere0'
        // Archetype: DrawSphereComponent'Engine.Default__ForceFieldShapeSphere.DrawSphere0'
        begin object name="DrawSphere0"
            ReplacementPrimitive=none
        end object
        Shape=DrawSphere0
    end object
    Shape=Shape0
    ReplacementPrimitive=none
}