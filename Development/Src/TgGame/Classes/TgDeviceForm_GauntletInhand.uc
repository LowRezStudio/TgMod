class TgDeviceForm_GauntletInhand extends TgDeviceForm_SpinnerWhileFiring
    config(Engine);

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

function SetLockedForBlendNodes(bool bLocked) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_SpinnerName="Stones"
}
