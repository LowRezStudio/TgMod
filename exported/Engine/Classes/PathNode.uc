class PathNode extends NavigationPoint
    native
    placeable
    hidecategories(Navigation,Lighting,LightColor,Force);

simulated event string GetDebugAbbrev()
{
    return "PN";
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__PathNode.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__NavigationPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}