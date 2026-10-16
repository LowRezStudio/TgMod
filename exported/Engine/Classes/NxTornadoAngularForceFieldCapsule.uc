class NxTornadoAngularForceFieldCapsule extends NxTornadoAngularForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var() export editinline DrawCapsuleComponent RenderComponent;

defaultproperties
{
    // Reference: DrawCapsuleComponent'Engine.Default__NxTornadoAngularForceFieldCapsule.DrawCapsule0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DrawCapsule0'
    begin object name="DrawCapsule0" class=Engine.DrawCapsuleComponent
        ReplacementPrimitive=none
    end object
    RenderComponent=DrawCapsule0
    ForceHeight=200.0000000
    Components[0]=DrawCapsule0
    Components[1]=none
}