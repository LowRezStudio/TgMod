class TgDeviceForm_HyperBeam extends TgDeviceForm_SpinnerWhileFiring
    config(Engine);

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

simulated function PlayTracerEffects(Vector endLocation, optional int nEquipSlot=0) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

function SetSpinnersActive(bool bActive) { }

defaultproperties
{
    m_SpinnerName="Stones"
}
