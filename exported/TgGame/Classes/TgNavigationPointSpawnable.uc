class TgNavigationPointSpawnable extends TgNavigationPoint
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgNavigationPointSpawnable.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgNavigationPoint.CollisionCylinder'
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
    CollisionComponent=CollisionCylinder
}