class TgDeviceForm_PoppyBomb extends TgDeviceForm
    config(Engine);

var TgAnimNodeBlendList m_PoppyShakeBlendList1P;

simulated event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

simulated event EnterTargetingMode() { }

simulated event ExitTargetingMode() { }
