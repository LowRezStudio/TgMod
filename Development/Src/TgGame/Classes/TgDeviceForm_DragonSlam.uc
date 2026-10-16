class TgDeviceForm_DragonSlam extends TgDeviceForm
    config(Engine)
    dependson(TgObject);

var bool m_bStartFireInAir;
var array<TgAnimNodeBlendByAbilityDragonSlam> m_DragonSlamBlendList1P;
var array<TgAnimNodeBlendByAbilityDragonSlam> m_DragonSlamBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event BuildUp(int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional float fBuildupTime=0.0000000) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }

event Hit(int nFireMode, Actor Target, float fDamageAmount, Vector HitLocation, Vector HitNormal, const out ExtraDamageInfo ExtraInfo) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }

function Cleanup() { }
