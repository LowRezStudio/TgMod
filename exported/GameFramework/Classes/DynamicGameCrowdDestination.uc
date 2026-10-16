class DynamicGameCrowdDestination extends GameCrowdDestination
    placeable
    hidecategories(Navigation,Advanced,Collision,Display,Actor,Movement,Physics);

defaultproperties
{
    // Reference: CylinderComponent'GameFramework.Default__DynamicGameCrowdDestination.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'GameFramework.Default__GameCrowdDestination.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=none
    Components[2]=none
    bStatic=false
    CollisionComponent=CollisionCylinder
}