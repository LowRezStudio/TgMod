class TgDeviceForm_Lockdown extends TgDeviceForm
    config(Engine);

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StopFire(int nFireModeNum) { }
