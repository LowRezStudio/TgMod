class TgDeviceForm_Whirlwind2 extends TgDeviceForm
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event DoInterrupt() { }

event StopFire(int nFireModeNum) { }
