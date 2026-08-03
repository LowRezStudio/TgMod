class DynamicAnchor extends NavigationPoint
    native
    notplaceable
    hidecategories(Navigation,Lighting,LightColor,Force);

var Controller CurrentUser;

defaultproperties
{
    // Reference: CylinderComponent'Engine.Default__DynamicAnchor.CollisionCylinder'
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
    bStatic=false
    bNoDelete=false
    bCollideWhenPlacing=false
    CollisionComponent=CollisionCylinder
}