class NxRadialForceField extends NxForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var export editinline DrawSphereComponent RenderComponent;
var() interp float ForceStrength;
var() interp float ForceRadius;
var() export PrimitiveComponent.ERadialImpulseFalloff ForceFalloff;
var native const transient Pointer LinearKernel;

defaultproperties
{
    // Reference: DrawSphereComponent'Engine.Default__NxRadialForceField.DrawSphere0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawSphere0'
    begin object name="DrawSphere0" class=Engine.DrawSphereComponent
        SphereColor=(R=64,G=70,B=255,A=255)
        SphereRadius=200.0000000
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawSphere0
    ForceStrength=10.0000000
    ForceRadius=200.0000000
    Components[0]=DrawSphere0
    Components[1]=none
}