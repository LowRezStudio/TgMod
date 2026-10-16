class Trigger_PawnsOnly extends Trigger
    native
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__Trigger_PawnsOnly.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Trigger.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    // Reference: SpriteComponent'Engine.Default__Trigger_PawnsOnly.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    // Archetype: SpriteComponent'Engine.Default__Trigger.Sprite'
    begin object name="Sprite"
        ReplacementPrimitive=none
    end object
    Components[0]=Sprite
    Components[1]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}