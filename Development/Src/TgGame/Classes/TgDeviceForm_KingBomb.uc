class TgDeviceForm_KingBomb extends TgDeviceForm
    config(Engine);

event BuildUp(int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional float fBuildupTime=0.0000000) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }

function Cleanup() { }
