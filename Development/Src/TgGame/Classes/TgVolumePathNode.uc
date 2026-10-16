class TgVolumePathNode extends VolumePathNode
    native
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

var () editconst bool m_bIsAboveGround;
var () editconst Vector m_vGroundHitLocation;
var () float m_fGroundTraceDistance;
var export editinline SpriteComponent m_GroundSprite;

defaultproperties
{}
