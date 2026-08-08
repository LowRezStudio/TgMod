class TgEffectForm_BuffBelt extends TgEffectForm
    native(Effects)
    config(Engine);

var float m_OrbitAngleYawOffset;
var float m_OrbitHeightOffset;
var bool m_bFirstUpdate;
var float m_OrbitRotationSpeed;

defaultproperties
{
    m_bFirstUpdate=true
    m_OrbitRotationSpeed=1.0000000
}
