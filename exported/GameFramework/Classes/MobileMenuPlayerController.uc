class MobileMenuPlayerController extends GamePlayerController
    config(Game)
    hidecategories(Navigation);

defaultproperties
{
    InputClass=Class'GameFramework.MobilePlayerInput'
    // Reference: CylinderComponent'GameFramework.Default__MobileMenuPlayerController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GamePlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}