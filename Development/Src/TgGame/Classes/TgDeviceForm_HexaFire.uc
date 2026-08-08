class TgDeviceForm_HexaFire extends TgDeviceForm
    config(Engine);

var TgAnimNodeBlendList m_LeftRocket1p;
var TgAnimNodeBlendList m_LeftRocket3p;
var TgAnimNodeBlendList m_RightRocket1p;
var TgAnimNodeBlendList m_RightRocket3p;
var bool m_bFiringRightRocket;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

function SetAllInactive() { }

event DoInterrupt() { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

defaultproperties
{
    m_bFiringRightRocket=true
}
