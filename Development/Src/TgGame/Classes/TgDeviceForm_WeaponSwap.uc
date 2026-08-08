class TgDeviceForm_WeaponSwap extends TgDeviceForm
    native(ChampOwl)
    config(Engine)
    dependson(TgPawn);

var array<TgSkelControlSingleBone> m_PistolScale1p;
var array<TgSkelControlSingleBone> m_PistolScale3p;
var array<TgSkelControlSingleBone> m_RifleScale1p;
var array<TgSkelControlSingleBone> m_RifleScale3p;

native function CacheSkelControls(AnimTree pAnimTree, out array<TgSkelControlSingleBone> PistolSkelControls, out array<TgSkelControlSingleBone> RifleSkelControls, name nmPistol, name nmRifle);  // Export UTgDeviceForm_WeaponSwap::execCacheSkelControls(FFrame&, void* const)

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function CacheControls(TgSkeletalMeshComponent SkelComp, out array<TgSkelControlSingleBone> PistolSkelControls, out array<TgSkelControlSingleBone> RifleSkelControls, name nmPistol, name nmRifle) { }

function SetSkelControlsActive(out array<TgSkelControlSingleBone> SkelControls, bool bActive) { }

simulated function RecoverDeviceState(TgPawn.TG_REP_DEVICE_STATE DesiredState) { }
