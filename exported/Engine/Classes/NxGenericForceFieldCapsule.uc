class NxGenericForceFieldCapsule extends NxGenericForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var export editinline DrawCapsuleComponent RenderComponent;
var() float CapsuleHeight;
var() float CapsuleRadius;

defaultproperties
{
    // Reference: DrawCapsuleComponent'Engine.Default__NxGenericForceFieldCapsule.DrawCapsule0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawCapsule0'
    begin object name="DrawCapsule0" class=Engine.DrawCapsuleComponent
        CapsuleColor=(R=64,G=70,B=255,A=255)
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawCapsule0
    CapsuleHeight=200.0000000
    CapsuleRadius=200.0000000
    Components[0]=DrawCapsule0
    Components[1]=none
}