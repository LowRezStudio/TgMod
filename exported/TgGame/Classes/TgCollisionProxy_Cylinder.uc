class TgCollisionProxy_Cylinder extends TgCollisionProxy
    native
    notplaceable
    hidecategories(Navigation);

var export editinline CylinderComponent m_CollisionCylinder;

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgCollisionProxy_Cylinder.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgCollisionProxy.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    m_CollisionCylinder=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}