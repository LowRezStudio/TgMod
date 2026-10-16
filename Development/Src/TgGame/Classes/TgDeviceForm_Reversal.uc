class TgDeviceForm_Reversal extends TgDeviceForm
    native(ChampAndroxus)
    config(Engine)
    dependson(TgAnimNodeBlendByAbilityReversal);

var float m_fAccumulatedDamage;
var float m_fMaxChargeDamage;
var TgEmitter_CameraEffect c_CameraEffect;
var array<TgAnimNodeBlendList> m_1pNodes;
var array<TgAnimNodeBlendList> m_3pNodes;
var bool m_bIsAbsorbingShots;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function SetActiveChildren(TgAnimNodeBlendByAbilityReversal.EBlendReversal ChildIndex) { }

event UpdateAccumulatedDamage(float newDamage) { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event DoInterrupt() { }

defaultproperties
{
    m_fMaxChargeDamage=800.0000000
}
