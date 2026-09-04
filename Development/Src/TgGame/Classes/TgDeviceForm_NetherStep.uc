class TgDeviceForm_NetherStep extends TgDeviceForm
    config(Engine);

var array<AnimNodeBlendList> m_stanceNodes1p;
var array<AnimNodeBlendList> m_stanceNodes3p;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event CooldownComplete() { }
