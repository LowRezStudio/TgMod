class TgDeviceForm_Barrage extends TgDeviceForm
    config(Engine);

var TgPlayerController m_CachedActiveOverlayController;

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StopFire(int nFireModeNum) { }
