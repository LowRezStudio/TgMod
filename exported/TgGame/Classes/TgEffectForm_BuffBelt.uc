class TgEffectForm_BuffBelt extends TgEffectForm
    native(Effects);

var private native const noexport Pointer VfTable_FTickableObject;
var float m_OrbitAngleYawOffset;
var float m_OrbitHeightOffset;
var bool m_bFirstUpdate;
var float m_OrbitRotationSpeed;

defaultproperties
{
    m_bFirstUpdate=true
    m_OrbitRotationSpeed=1.0000000
}