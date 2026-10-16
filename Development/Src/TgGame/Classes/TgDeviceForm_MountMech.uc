class TgDeviceForm_MountMech extends TgDeviceForm_Mount
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }
