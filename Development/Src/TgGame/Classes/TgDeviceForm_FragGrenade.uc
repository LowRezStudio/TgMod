class TgDeviceForm_FragGrenade extends TgDeviceForm
    config(Engine);

var array<TgAnimNodeBlendByAbilityFragGrenade> m_FragGrenadeBlendList1P;
var array<TgAnimNodeBlendByAbilityFragGrenade> m_FragGrenadeBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Generic1(optional byte byExtraData) { }

event DoInterrupt() { }
