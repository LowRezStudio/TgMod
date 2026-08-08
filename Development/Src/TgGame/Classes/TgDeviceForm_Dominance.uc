class TgDeviceForm_Dominance extends TgDeviceForm
    native(ChampFlak)
    config(Engine);

var SkelControlBase m_SKCFlagScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

simulated event HideFlag() { }

simulated event ShowFlag() { }
