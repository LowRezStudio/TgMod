class GameCrowdInteractionDestination extends GameCrowdDestination
    placeable
    hidecategories(Navigation,Advanced,Collision,Display,Actor,Movement,Physics);

defaultproperties
{
    bAvoidWhenPanicked=true
    bMustReachExactly=true
    bAllowsSpawning=false
    Capacity=1
    // Reference: CylinderComponent'GameFramework.Default__GameCrowdInteractionDestination.CollisionCylinder'
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
    CollisionComponent=CollisionCylinder
}