class NxRadialCustomForceField extends NxRadialForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var() interp float SelfRotationStrength;
var native const transient Pointer Kernel;

defaultproperties
{
    // Reference: DrawSphereComponent'Engine.Default__NxRadialCustomForceField.DrawSphere0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawSphere0'
    // Archetype: DrawSphereComponent'Engine.Default__NxRadialForceField.DrawSphere0'
    begin object name="DrawSphere0"
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawSphere0
    Components[0]=DrawSphere0
    Components[1]=none
}