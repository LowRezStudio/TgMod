class TgDeviceForm_Hover extends TgDeviceForm
    config(Engine);

var TgAnimNodeBlendList m_HoverBlendList1P;
var TgAnimNodeBlendList m_HoverBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
