class TgDeviceForm_BladesInhand extends TgDeviceForm
    native(Devices)
    config(Engine);

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }
