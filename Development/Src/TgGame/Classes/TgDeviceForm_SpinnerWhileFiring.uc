class TgDeviceForm_SpinnerWhileFiring extends TgDeviceForm
    native(Devices)
    config(Engine);

var const name m_SpinnerName;
var array<TgSkelCon_Spinner> m_SpinnerSkelControls1p;
var array<TgSkelCon_Spinner> m_SpinnerSkelControls3p;

native function CacheSkelControls(AnimTree pAnimTree, out array<TgSkelCon_Spinner> SpinnerSkelControls);  // Export UTgDeviceForm_SpinnerWhileFiring::execCacheSkelControls(FFrame&, void* const)

event Cache1PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

event Cache3PAnimNodes(TgSkeletalMeshComponent SkelComp) { }

function CacheSpinner(TgSkeletalMeshComponent SkelComp, out array<TgSkelCon_Spinner> SpinnerSkelControls) { }

function SetSpinnersActive(bool bActive) { }

function SetSpinnersRotationSpeedState(int nState) { }
