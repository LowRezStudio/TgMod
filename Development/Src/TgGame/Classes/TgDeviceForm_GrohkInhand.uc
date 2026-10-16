class TgDeviceForm_GrohkInhand extends TgDeviceForm_ArcingBeam
    config(Engine);

var TgSkelCon_Spinner m_SpinnerSkelControl;

function SetBeamFXForHit(bool DidHit) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }
