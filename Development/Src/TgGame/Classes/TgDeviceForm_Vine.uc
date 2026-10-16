class TgDeviceForm_Vine extends TgDeviceForm
    native(ChampGrover)
    config(Engine);

var bool m_bBeamActive;
var bool m_bVineInterrupted;
var Actor m_BeamTarget;
var Vector m_vBeamTargetLocation;
var array<TgAnimNodeBlendByAbilityVine> m_VineBlendList1P;
var array<TgAnimNodeBlendByAbilityVine> m_VineBlendList3P;

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function ConnectBeamToTarget(Actor Target, Vector Location) { }

function DisconnectBeam() { }

event StartFire(int nFireMode, optional float fRefireTime, optional Actor Target, optional int nAmmoRemaining) { }

event StopFire(int nFireModeNum) { }

event Generic1(optional byte byExtraData) { }
