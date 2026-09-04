class TgDeviceForm_Disengage extends TgDeviceForm
    config(Engine);

var array<TgAnimNodeStanceTransitionerSynchronized> m_STSNodes3p;
var array<TgAnimNodeStanceTransitionerSynchronized> m_STSNodes1p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function SetStance(bool bActivated) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
