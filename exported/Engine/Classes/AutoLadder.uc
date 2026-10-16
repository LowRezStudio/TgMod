class AutoLadder extends Ladder
    native
    notplaceable
    hidecategories(Navigation,Lighting,LightColor,Force);

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__AutoLadder.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Ladder.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    bCollideWhenPlacing=false
    CollisionComponent=CollisionCylinder
}