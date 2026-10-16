class TgDeviceForm_CounterAttack extends TgDeviceForm
    native(ChampDarklord)
    config(Engine);

var array<TgAnimBlendByPaladinsCharacter> m_DarklordNodes3p;
var array<TgAnimBlendByPaladinsCharacter> m_DarklordNodes1p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Generic1(optional byte byExtraData) { }
