class TgTrigger_AIControlledCharacters extends Trigger
    native(Kismet)
    hidecategories(Navigation);

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgTrigger_AIControlledCharacters.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Trigger.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    // Reference: SpriteComponent'TgGame.Default__TgTrigger_AIControlledCharacters.Sprite'
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