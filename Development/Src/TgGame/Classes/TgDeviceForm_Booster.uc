class TgDeviceForm_Booster extends TgDeviceForm
    config(Engine);

var array<TgAnimNodeBlendByDrogozFlying> m_FlyingBlendList1P;
var array<TgAnimNodeBlendByDrogozFlying> m_FlyingBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
