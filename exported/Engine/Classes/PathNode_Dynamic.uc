class PathNode_Dynamic extends PathNode
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

simulated event string GetDebugAbbrev()
{
    return "DynPN";
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__PathNode_Dynamic.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__PathNode.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    bStatic=false
    CollisionComponent=CollisionCylinder
}