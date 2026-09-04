class TgDeviceForm_HeroicLeap extends TgDeviceForm
    config(Engine);

var TgAnimNodeBlendList m_BlendList1P;
var TgAnimNodeBlendList m_BlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
