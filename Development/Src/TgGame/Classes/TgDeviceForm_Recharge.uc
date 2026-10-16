class TgDeviceForm_Recharge extends TgDeviceForm_SpinnerWhileFiring
    config(Engine);

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

function SetLockedForBlendNodes(bool bLocked) { }

defaultproperties
{
    m_SpinnerName="RechargeCrystal"
}
