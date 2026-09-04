class NxCylindricalForceFieldCapsule extends NxCylindricalForceField
    native(ForceField)
    placeable
    hidecategories(Navigation);

var() export editinline DrawCapsuleComponent RenderComponent;

// Export UNxCylindricalForceFieldCapsule::execDoInitRBPhys(FFrame&, void* const)
native function DoInitRBPhys();

defaultproperties
{
    // Reference: DrawCapsuleComponent'Engine.Default__NxCylindricalForceFieldCapsule.DrawCapsule0'
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