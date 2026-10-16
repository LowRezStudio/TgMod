class TgDeviceForm_LongbowPlanted extends TgDeviceForm
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }
