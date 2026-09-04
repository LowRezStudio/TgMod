class TgVolumePathNode extends VolumePathNode
    native
    hidecategories(Navigation,Lighting,LightColor,Force);

var() editconst bool m_bIsAboveGround;
var() editconst Vector m_vGroundHitLocation;
var() float m_fGroundTraceDistance;
var export editinline SpriteComponent m_GroundSprite;

defaultproperties
{
    m_fGroundTraceDistance=999999.0000000
    // Reference: CylinderComponent'TgGame.Default__TgVolumePathNode.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__VolumePathNode.CollisionCylinder'
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
    CollisionComponent=CollisionCylinder
}