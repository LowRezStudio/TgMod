class TgNavigationPoint extends NavigationPoint
    abstract
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

var(Object) editconst int m_nMapObjectId;

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgNavigationPoint.CollisionCylinder'
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