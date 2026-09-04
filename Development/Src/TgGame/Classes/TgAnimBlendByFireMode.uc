class TgAnimBlendByFireMode extends TgAnimNodeBlendList
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

var () int m_nDefaultFireMode;
var () TgObject.TG_EQUIP_POINT m_EquipPoint;

simulated function SelectFireMode(int FireMode) { }

simulated function SetDefaultFiremode() { }

defaultproperties
{
    m_nDefaultFireMode=1
    DefaultBlendTime=0.1000000
    Children=/* Array type was not detected. */
}
