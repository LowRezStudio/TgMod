class TgLanePylon extends Pylon
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force,Lighting,LightColor,Force);

var() int m_nLane;

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgLanePylon.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Pylon.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    Components[5]=none
    Components[6]=none
    Components[7]=none
    CollisionComponent=CollisionCylinder
}