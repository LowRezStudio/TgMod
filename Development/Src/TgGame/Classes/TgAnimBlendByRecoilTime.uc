class TgAnimBlendByRecoilTime extends AnimNodeBlend
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var TgDeviceForm m_TgDeviceForm;
var TgPawn m_TgPawn;
var float m_PctBlend;
var () float m_fBlendTime;
var () float m_fMaxRecoilTime;

defaultproperties
{
    m_fBlendTime=0.2000000
    Children=/* Array type was not detected. */
}
