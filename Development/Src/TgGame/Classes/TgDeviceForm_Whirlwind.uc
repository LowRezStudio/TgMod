class TgDeviceForm_Whirlwind extends TgDeviceForm
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event DoInterrupt() { }

event Generic1(optional byte byExtraData) { }

event StopFire(int nFireModeNum) { }
