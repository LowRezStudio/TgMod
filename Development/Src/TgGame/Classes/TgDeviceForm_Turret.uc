class TgDeviceForm_Turret extends TgDeviceForm
    config(Engine);

var SkelControlBase m_SKCTurretScale;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event CooldownComplete() { }
