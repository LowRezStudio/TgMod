class TgDeviceForm_Smash extends TgDeviceForm
    config(Engine);

var array<TgAnimNodeBlendByAbilitySmash> m_SmashBlendList1P;
var array<TgAnimNodeBlendByAbilitySmash> m_SmashBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot=0, optional int nSocketIndex=0, optional bool bSuccessfulHit=false, optional float fRefireTime) { }
