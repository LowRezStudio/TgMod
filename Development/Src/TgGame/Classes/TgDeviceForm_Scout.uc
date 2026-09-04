class TgDeviceForm_Scout extends TgDeviceForm
    config(Engine);

var SkelControlBase m_SKCBirdScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
