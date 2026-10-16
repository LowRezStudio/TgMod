class TgAnimBlendByAmmo extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine)
    dependson(TgObject);

struct AmmoBlendParams {
    var () int MinAmmo;
    var () int MaxAmmo;
    var () int ChildNum;
    structdefaultproperties {}
};

var () int m_nDefaultChild;
var () TgObject.TG_EQUIP_POINT m_EquipPoint;
var () bool m_bDelayUpdateUntilReplay;
var () bool m_bCheckAmmoPerTick;
var () array<AmmoBlendParams> m_ChildAmmoParams;
var int m_nPendingChildIndex;
var int m_nAmmoUpdateTickTag;

native function PlayAnim(optional bool bLoop=false, optional float Rate=1.0000000, optional float StartTime=0.0000000);  // Export UTgAnimBlendByAmmo::execPlayAnim(FFrame&, void* const)

native function ReplayAnim();  // Export UTgAnimBlendByAmmo::execReplayAnim(FFrame&, void* const)

simulated function SetAmmoAmt(int nAmmo) { }

simulated function SetAmmoChild(int targetAmmoChild) { }

defaultproperties
{
    m_EquipPoint=EQP_AUTO
    m_bDelayUpdateUntilReplay=true
    m_ChildAmmoParams[0]=(MinAmmo=2,MaxAmmo=10000,ChildNum=0)
    m_ChildAmmoParams[1]=(MinAmmo=1,MaxAmmo=1,ChildNum=1)
    DefaultBlendTime=0.1000000
    Children=/* Array type was not detected. */
}
